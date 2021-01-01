#!/usr/bin/env bash
#
# Run base ansible-lint tests against playbooks
#

## Shell Opts ----------------------------------------------------------------

set -ex

## Vars ----------------------------------------------------------------------

export WORKING_DIR="${WORKING_DIR:-$(pwd)}"
export PLAYBOOK_DIR="${PLAYBOOK_DIR:-${WORKING_DIR}/ansible}"
export ANSIBLE_LINT_PARAMS="${ANSIBLE_LINT_PARAMS:--vvvv --exclude=${HOME}/.ansible}"

## Main ----------------------------------------------------------------------

PLAYBOOK_FILES=$(find ${PLAYBOOK_DIR} -type f -name '*.yml' -maxdepth 1)
echo "ANSIBLE_LINT_PARAMS: ${ANSIBLE_LINT_PARAMS}"
echo "PLAYBOOK_DIR: ${PLAYBOOK_DIR}"
echo "PLAYBOOK_FILES: ${PLAYBOOK_FILES}"

for PLAYBOOK in ${PLAYBOOK_FILES}; do
    ansible-lint ${ANSIBLE_LINT_PARAMS} ${PLAYBOOK}
done
