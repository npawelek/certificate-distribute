#!/usr/bin/env bash
#
# Run pylint tests on python code
#

## Shell Opts ----------------------------------------------------------------

set -ex

## Vars ----------------------------------------------------------------------

export WORKING_DIR="${WORKING_DIR:-$(pwd)}"
export PYLINT_OPTS="${PYLINT_OPTS:---rcfile=tests/pylintrc --verbose --disable=C0103,R0914,W0613,R1705}"

## Main ----------------------------------------------------------------------

# Lambda functions don't use shebangs, so match on boto which indicates python
# code
grep --recursive --binary-files=without-match \
        --files-with-match 'import.*boto' \
        --exclude-dir .git \
        "${WORKING_DIR}" | grep '.py$' |
        xargs pylint ${PYLINT_OPTS}

# Look for shebang python files
grep --recursive --binary-files=without-match \
        --files-with-match '^.!.*python' \
        --exclude-dir .git \
        "${WORKING_DIR}" |
        xargs pylint ${PYLINT_OPTS}
