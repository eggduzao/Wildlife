# Phenoteka — developer Makefile
# ==============================
# Public targets:
#   make test   -> uninstall + editable install + run ONE chosen pytest command
#   make tox    -> uninstall + editable install + run ONE chosen tox env combo
#
# To change which command runs:
# - In the "PYTEST COMMAND CHOICES" block, uncomment exactly ONE line for $(PYTEST_CMD)
# - In the "TOX COMMAND CHOICES" block, uncomment exactly ONE line for $(TOX_CMD)

# ---- knobs ---------------------------------------------------------------
SHELL  := /bin/bash
PYTHON ?= python3
PKG    ?= phenoteka
PIP    ?= $(PYTHON) -m pip
CONSTR ?= -c constraints.txt
 
# ---- choose your pytest command (uncomment exactly ONE) ------------------
# Each option has an explanation next to it. Only one should remain uncommented.
# NOTE: Make uses the LAST assignment that is not commented out.

# Run entire test suite, verbose defaults
#PYTEST_CMD := pytest
# Quieter output (default here)
#PYTEST_CMD := pytest -q
# Test one module
# PYTEST_CMD := pytest -q tests/test_tables/test_pheno_table.py
# Test one function
#PYTEST_CMD := pytest tests/test_tables/test_pheno_table.py::test_basic_smoke
# Show live logs for a specific module - '-s' prints "print()"s
PYTEST_CMD := pytest -q tests/test_io/test_yaml_io.py -o log_cli=true -o log_cli_level=INFO -s
# Coverage with missing lines shown
#PYTEST_CMD := pytest -q tests/test_tables -s --cov=phenoteka.tables --cov-report=term-missing
# Run tests excluding @pytest.mark.slow
#PYTEST_CMD := pytest -m "not slow"
# Stop on first failure (fail fast)
#PYTEST_CMD := pytest -x
# Show print/log output live
#PYTEST_CMD := pytest -s
# Run tests whose names match "test_pheno_table".
#PYTEST_CMD := pytest -k test_pheno_table
# Show live logs for CLI tests.
#PYTEST_CMD := pytest -o log_cli=true -o log_cli_level=INFO tests/test_cli

# ---- choose your tox command (uncomment exactly ONE) ---------------------
# Tox runs the envs defined in tox.ini. Pick one combo as your default.

# Run unit tests on Python 3.12 (default)
TOX_CMD := tox -e py312
# Run linter env (ruff/flake8 as configured)
#TOX_CMD := tox -e lint
# Run formatting checks (black/isort/ruff)
#TOX_CMD := tox -e format
# Run static type checks (e.g., mypy/pyright)
#TOX_CMD := tox -e type
# Clean artifacts / build caches env
#TOX_CMD := tox -e clean
# Run multiple envs in one go
#TOX_CMD := tox -e py312,lint,format,type

# ---- phony targets -------------------------------------------------------
.PHONY: test tox reinstall uninstall install

# Top-level dev loops
test: reinstall
	@echo "==> Running tests with: $(PYTEST_CMD)"
	@set -euo pipefail; \
	$(PYTEST_CMD) >debbug.txt 2>&1

tox: reinstall
	@echo "==> Running tox with: $(TOX_CMD)"
	@set -euo pipefail; \
	$(TOX_CMD)

# Common pre-steps
reinstall: uninstall install

uninstall:
	@echo "==> Uninstalling $(PKG) (ignore errors if not installed)"
	@set -euo pipefail; \
	$(PIP) uninstall -y $(PKG) >/dev/null 2>&1 || true

install:
	@echo "==> Editable install of $(PKG)"
	@set -euo pipefail; \
	$(PIP) install -e . $(CONSTR) >/dev/null