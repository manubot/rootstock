#!/usr/bin/env python
# coding: utf-8
"""
Process manuscript metadata and author metadata
"""
import collections
import pathlib

import yaml


def get_metadata_object(path):
    """
    Load all of the metadata from a yaml file, & return.

    :param path: pathlib.Path to a metadata YAML file.
    :return: structured metadata object.
    """
    class metadata(object):
        pass
    with path.open('r') as read_file:
        metadata_dict = yaml.load(read_file)
    initials = []
    metadata_dict['author'] = []
    # Check for duplicated initials
    for author in metadata_dict['author_info']:
        initials.append(author['initials'])
        metadata_dict['author'].append(author['full_name'])
    initials_counts = collections.Counter(initials)
    if max(initials_counts.values()) > 1:
        duplicated_initials = [k for k, v in d.items() if v > 1]
        msg = f'Duplicated initials in metadata.yaml: {duplicated_initials}'
        raise ValueError(msg)
    metadata.author_info = metadata_dict.pop('author_info')
    metadata.header_block = metadata_dict
    return metadata

def get_metadata_info(path):
    """
    Load the metadata yaml block for doc header

    :param path: pathlib.Path to a metadata YAML file.
    :return: dict with structured metadata.
    """
    return get_metadata_object(path).header_block

