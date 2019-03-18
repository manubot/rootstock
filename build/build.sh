set -o errexit

# Set timezone used by Python for setting the manuscript's date
export TZ=Etc/UTC
# Default Python to read/write text files using UTF-8 encoding
export LC_ALL=en_US.UTF-8

# Generate reference information
echo "Retrieving and processing reference metadata"
manubot process \
  --content-directory=content \
  --output-directory=output \
  --cache-directory=ci/cache \
  --log-level=INFO

# pandoc settings
CSL_PATH=build/assets/style.csl
BIBLIOGRAPHY_PATH=output/references.json
INPUT_PATH=output/manuscript.md

# Make output directory
mkdir -p output

# Create JSON output of Pandoc's Abstract Syntax Tree
echo "Exporting Pandoc JSON manuscript"
pandoc --verbose \
  --from=markdown \
  --to=json \
  --filter=pandoc-fignos \
  --filter=pandoc-eqnos \
  --filter=pandoc-tablenos \
  --bibliography=$BIBLIOGRAPHY_PATH \
  --csl=$CSL_PATH \
  --metadata link-citations=true \
  $INPUT_PATH \
  | python -m json.tool >| output/manuscript.json  # Prettify JSON

# Create HTML output
# http://pandoc.org/MANUAL.html
echo "Exporting HTML manuscript"
pandoc --verbose \
  --from=json \
  --to=html5 \
  --include-after-body=build/themes/default.html \
  --include-after-body=build/plugins/table-scroll.html \
  --include-after-body=build/plugins/anchors.html \
  --include-after-body=build/plugins/accordion.html \
  --include-after-body=build/plugins/tooltips.html \
  --include-after-body=build/plugins/jump-to-first.html \
  --include-after-body=build/plugins/link-highlight.html \
  --include-after-body=build/plugins/table-of-contents.html \
  --include-after-body=build/plugins/lightbox.html \
  --mathjax \
  --variable math="" \
  --include-after-body=build/plugins/math.html \
  --include-after-body=build/plugins/hypothesis.html \
  --include-after-body=build/plugins/analytics.html \
  --output=output/manuscript.html \
  output/manuscript.json

# Create PDF output (unless BUILD_PDF environment variable equals "false")
if [ "$BUILD_PDF" != "false" ]; then
  echo "Exporting PDF manuscript"
  if [ -L images ]; then rm images; fi  # if images is a symlink, remove it
  ln -s content/images
  pandoc \
    --from=json \
    --to=html5 \
    --pdf-engine=weasyprint \
    --pdf-engine-opt=--presentational-hints \
    --webtex=https://latex.codecogs.com/svg.latex? \
    --include-after-body=build/themes/default.html \
    --output=output/manuscript.pdf \
    output/manuscript.json
  rm images
fi

# Create DOCX output (if BUILD_DOCX environment variable equals "true")
if [ "$BUILD_DOCX" = "true" ]; then
  echo "Exporting Word Docx manuscript"
  pandoc --verbose \
    --from=json \
    --to=docx \
    --reference-doc=build/themes/default.docx \
    --resource-path=.:content \
    --output=output/manuscript.docx \
    output/manuscript.json
fi

echo "Build complete"
