set -o errexit

# Generate reference information
echo "Retrieving and processing reference metadata"
(cd build && python references.py)

# pandoc settings
CSL_PATH=references/style.csl
BIBLIOGRAPHY_PATH=references/generated/bibliography.json
INPUT_PATH=references/generated/all-sections.md

# Make output directory
mkdir -p output
# Move images to output directory
cp -R sections/images output/

# Create HTML outpout
# http://pandoc.org/MANUAL.html
echo "Exporting HTML manuscript"
pandoc --verbose \
  --from=markdown --to=html \
  --filter pandoc-fignos \
  --filter pandoc-eqnos \
  --bibliography=$BIBLIOGRAPHY_PATH \
  --csl=$CSL_PATH \
  --metadata link-citations=true \
  --css=github-pandoc.css \
  --include-in-header=build/assets/analytics.js \
  --include-after-body=build/assets/anchors.js \
  --output=output/index.html \
  $INPUT_PATH

# Create PDF outpout
echo "Exporting PDF manuscript"
cd output
pandoc \
  --from=markdown \
  --to=html5 \
  --filter pandoc-fignos \
  --filter pandoc-eqnos \
  --bibliography=../$BIBLIOGRAPHY_PATH \
  --csl=../$CSL_PATH \
  --metadata link-citations=true \
  --output=manuscript.pdf \
  ../$INPUT_PATH
