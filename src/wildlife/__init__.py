"""
Wildlife
========

Description.

The top-level package provides:

- Version information
- Public API facades for major subpackages
- Common exceptions and constants

Examples
--------
>>> import wildlife
>>> wildlife.__version__
'0.0.0'

>>> from wildlife import imputation
>>> imputation.list_methods()
['knn', 'mice', 'dtree']
"""

from __future__ import annotations

# Version info (PEP 396)
from wildlife._version import __version__, __version_info__

# Common exceptions
# from wildlife.exceptions import wildlifeError

# Public subpackage facades
# from wildlife import dimensions
# from wildlife import external
# from wildlife import imputation
# from wildlife import semantic
# from wildlife import gui

__all__ = [
    "__version__",
    "__version_info__",
    # "wildlifeError",
    # "dimensions",
    # "external",
    # "imputation",
    # "semantic",
    # "gui",
]

__label__ = "wildlife Package"
