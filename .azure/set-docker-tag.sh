#!/usr/bin/env bash
set -Eeuo pipefail -x

dir="$(dirname "$BASH_SOURCE")"

repoName="$("$dir/repo-name.sh")"
jobName="$("$dir/job-name.sh")"

# TODO filter out/replace invalid characters
dockerTag="azure-pipeline/$repoName:$jobName"

echo "##vso[task.setvariable variable=dockerTag;]$dockerTag"
