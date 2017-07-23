#! /usr/bin/env python
"""
Pandoc filter to convert svg files to pdf as suggested at:
https://github.com/jgm/pandoc/issues/265#issuecomment-27317316
"""

__author__ = "Jerome Robert"

import mimetypes
import subprocess
import os
import sys
import re
import urllib
from pandocfilters import toJSONFilter, Para, Image

fmt_to_option = {
    "docx": ("--export-pdf", "pdf")
}


build_dir = os.getcwd()
img_dir = "content/images/"


def svg_to_any(key, value, fmt, meta):
    if key == 'Image':
        if len(value) == 2:
            # before pandoc 1.16
            alt, [src, title] = value
            attrs = None
        else:
            attrs, alt, [src, title] = value
        mimet, _ = mimetypes.guess_type(src)
        option = fmt_to_option.get(fmt)
        if mimet == 'image/svg+xml' and option:
            web_image = re.compile('^http[s]?://')
            if web_image.match(src):
                base_name = os.path.basename(src)
                base_name, _ = os.path.splitext(base_name)
                eps_name = os.path.join(build_dir, img_dir, base_name + "." + option[1])
                file_name = src
            else:
                base_name, _ = os.path.splitext(src)
                eps_name = os.path.join(build_dir, base_name + "." + option[1])
                file_name = os.path.join(build_dir, src)
            try:
                mtime = os.path.getmtime(eps_name)
            except OSError:
                mtime = -1
            try:
                 src_mtime = os.path.getmtime(src)
            except FileNotFoundError:
                src_mtime = -1
            if mtime < src_mtime or web_image.match(src):
                cmd_line = ['inkscape', option[0], eps_name, file_name]
                sys.stderr.write("Running %s\n" % " ".join(cmd_line))
                subprocess.call(cmd_line, stdout=sys.stderr.fileno())
            if attrs:
                return Image(attrs, alt, [eps_name, title])
            else:
                return Image(alt, [eps_name, title])

if __name__ == "__main__":
    toJSONFilter(svg_to_any)
