import os
import pathlib
import shutil

commit = os.environ.get('TRAVIS_COMMIT', 'local')
print(f'TRAVIS_COMMIT={commit}')

# Create webpage/v/commit directory
version_directory = pathlib.Path('webpage/v')
version_directory.mkdir(exist_ok=True)
commit_directory = version_directory.joinpath(commit)
commit_directory.mkdir(exist_ok=True)

# Symlink webpage/v/latest to point to webpage/v/commit
latest_directory = version_directory.joinpath('latest')
if latest_directory.is_symlink():
    latest_directory.unlink()
latest_directory.symlink_to(commit, target_is_directory=True)

# Copy content/images to webpage/v/commit/images
dst = commit_directory.joinpath('images')
if dst.is_dir():
    shutil.rmtree(dst)
shutil.copytree(
    src=pathlib.Path('content/images'),
    dst=dst,
)

# Copy output files to to webpage/v/commit/
output_directory = pathlib.Path('output')
for name in 'manuscript.html', 'manuscript.pdf':
    shutil.copy2(
        src=output_directory.joinpath(name),
        dst=commit_directory.joinpath(name),
    )

# Copy webpage/github-pandoc.css to to webpage/v/commit/github-pandoc.css
shutil.copy2(
    src=pathlib.Path('webpage/github-pandoc.css'),
    dst=commit_directory.joinpath('github-pandoc.css'),
)

# Must populate webpage/v from the gh-pages branch to get history
# http://clubmate.fi/git-checkout-file-or-directories-from-another-branch/
# https://stackoverflow.com/a/2668947/4651668
# https://stackoverflow.com/a/16493707/4651668
# git --work-tree=webpage checkout upstream/gh-pages -- v
