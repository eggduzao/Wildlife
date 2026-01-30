"""
Phenoteka main entry point
==========================

Allows running Phenoteka directly via ``python -m phenoteka``.
This entry point typically delegates to the CLI or GUI dispatcher.

Examples
--------
Command line::

    $ python -m phenoteka --help

Python::

    >>> import runpy
    >>> runpy.run_module("phenoteka", run_name="__main__")

Notes
-----
Author: Eduardo Gade Gusmao
Created On: 11/12/2024
Last Updated: 15/02/2025
Version: 0.1.0
License: MIT License
"""

from __future__ import annotations
import sys

def main(argv: list[str] | None = None) -> None:
    """
    Main entry point for Phenoteka CLI/GUI.

    Parameters
    ----------
    argv : list of str or None
        Command-line arguments. If ``None``, defaults to ``sys.argv[1:]``.

    Notes
    -----
    - For CLI: dispatch to `phenoteka.cli.main`.
    - For GUI: dispatch to `phenoteka.gui.main` (optional, if GUI exists).
    """
    if argv is None:
        argv = sys.argv[1:]

    if "--gui" in argv:
        from phenoteka.gui import main as gui_main
        gui_main(argv)
    else:
        from phenoteka.cli import main as cli_main
        cli_main(argv)

if __name__ == "__main__":
    main()
