# Output directory containing the formatted manuscript

The [`gh-pages`](https://github.com/greenelab/manubot-rootstock/tree/gh-pages) branch hosts the contents of this directory at https://$(dirname greenelab/manubot-rootstock).github.io/$(basename greenelab/manubot-rootstock)/.

## Files

This directory contains the following files, which are mostly ignored on the `master` branch:

+ [`index.html`](index.html) is an HTML manuscript.
+ [`github-pandoc.css`](github-pandoc.css) sets the display style for `index.html`.
+ [`manuscript.pdf`](manuscript.pdf) is a PDF manuscript.
+ `*.ots` files are OpenTimestamps which can be used to verify manuscript existence at or before a given time.
  [OpenTimestamps](opentimestamps.org) uses the Bitcoin blockchain to attest to file hash existence.

## Source

The manuscripts in this directory were built from
[`f82ae0dc1a059bce05a8c43c0bf5e6a58edc4f2c`](https://github.com/greenelab/manubot-rootstock/commit/f82ae0dc1a059bce05a8c43c0bf5e6a58edc4f2c).
