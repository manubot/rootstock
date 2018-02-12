# Output directory containing the formatted manuscript

The [`gh-pages`](https://github.com/$TRAVIS_REPO_SLUG/tree/gh-pages) branch hosts the contents of this directory at https://$OWNER_NAME.github.io/$REPO_NAME/.
The permalink for this webpage version is https://$OWNER_NAME.github.io/$REPO_NAME/v/$TRAVIS_COMMIT/.
To redirect to the permalink for the latest manuscript version at anytime, use the link https://$OWNER_NAME.github.io/$REPO_NAME/v/freeze/.

## Files

This directory contains the following files, which are mostly ignored on the `master` branch:

+ [`index.html`](index.html) is an HTML manuscript.
+ [`github-pandoc.css`](github-pandoc.css) sets the display style for `index.html`.
+ [`manuscript.pdf`](manuscript.pdf) is a PDF manuscript.

The [`v`](v) directory contains directories for each manuscript version.
In general, a version is identified by the commit hash of the source content that created it.
The `*.ots` files in version directories are OpenTimestamps which can be used to verify manuscript existence at or before a given time.
[OpenTimestamps](opentimestamps.org) uses the Bitcoin blockchain to attest to file hash existence.

## Source

The manuscripts in this directory were built from
[`$TRAVIS_COMMIT`](https://github.com/$TRAVIS_REPO_SLUG/commit/$TRAVIS_COMMIT).
