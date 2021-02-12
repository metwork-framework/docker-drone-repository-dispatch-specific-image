#!/bin/bash

if test "${PLUGIN_REPOSITORIES:-}" = ""; then
  echo "missing PLUGIN_REPOSITORIES env var"
  echo "=> miss repositories value in configuration ?"
  exit 1
fi
if test "${DOWNSTREAM_GITHUB_TOKEN:-}" != ""; then
    if test "${GITHUB_TOKEN:-}" = ""; then
        export GITHUB_TOKEN=${DOWNSTREAM_GITHUB_TOKEN}
    fi
fi
if test "${GITHUB_TOKEN:-}" = ""; then
  echo "missing GITHUB_TOKEN env var"
  echo "=> miss downstream_github_token secret in configuration ?"
  exit 1
fi

#if test -f .drone_downstream_bypass; then
#    echo "downstream bypass"
#    exit 0
#fi

for REPO in $(echo "${PLUGIN_REPOSITORIES}" |sed 's/,/ /g'); do
    REPO_NAME=$(echo "${REPO}" |awk -F '@' '{print $1;}')
    BRANCH_NAME=$(echo "${REPO}" |awk -F '@' '{print $2;}')
    if test "${BRANCH_NAME:-}" = ""; then
        BRANCH_NAME=master
    fi
    echo "Creating repository-dispatch event on REPO_NAME=${REPO_NAME} and BRANCH=${BRANCH_NAME}..."
    echo '{"event_type": "metwork-trigger", "client_payload": {"branch": "'${BRANCH_NAME}'"}}' > fic.json
    cat fic.json
    curl -H "Accept: application/vnd.github.everest-preview+son" -H "Authorization: token ${GITHUB_TOKEN}" --request POST --data-binary @fic.json https://api.github.com/repos/metwork-framework/${REPO_NAME}/dispatches

    if test $? -ne 0; then
        echo "ERROR during curl action"
        exit 1
    fi
done
