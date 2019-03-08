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

# Create HTML output
# http://pandoc.org/MANUAL.html
echo "Exporting HTML manuscript"
pandoc --verbose \
  --from=markdown \
  --to=html5 \
  --filter=pandoc-fignos \
  --filter=pandoc-eqnos \
  --filter=pandoc-tablenos \
  --bibliography=$BIBLIOGRAPHY_PATH \
  --csl=$CSL_PATH \
  --metadata link-citations=true \
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
  --output=output/manuscript.html \
  $INPUT_PATH

echo "Build complete"
