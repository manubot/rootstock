#!/usr/bin/env python

import tempfile
import shutil
from pathlib import Path

from manubot.ai_editor.editor import ManuscriptEditor
from manubot.ai_editor.models import GPT3CompletionModel

if __name__ == "__main__":
    # create a manuscript editor and model to revise
    me = ManuscriptEditor(
        content_dir="content",
    )

    model = GPT3CompletionModel(
        title=me.title,
        keywords=me.keywords,
    )

    # revise the manuscript
    with tempfile.TemporaryDirectory() as t:
        output_folder = Path(t)
        print(f"Temporary directory: {output_folder}")

        me.revise_manuscript(output_folder, model, debug=True)

        # move the revised manuscript back to the content folder
        for f in output_folder.glob("*"):
            f.rename(me.content_dir / f.name)
