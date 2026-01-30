#!/usr/bin/env bash
find . -name "*.DS_Store*" -type f -delete
find . -name "*.Rout" -type f -delete
find . -name "*.RData" -type f -delete
find . -name "*.pyc" -type f -delete
git config --global credential.helper 'cache --timeout=3600000000000'
