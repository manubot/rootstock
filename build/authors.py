"""
Process author table
"""

import metadata

def get_author_info(path):
    """
    Load the author table and return the list of authors.
    """
    return metadata.get_metadata_object(path).author_info

