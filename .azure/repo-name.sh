#!/usr/bin/env bash
set -Eeuo pipefail

# https://docs.microsoft.com/en-us/azure/devops/pipelines/build/variables?view=azure-devops&tabs=yaml#build-variables
# "Build.Repository.Name"

for e in \
	BUILD_REPOSITORY_NAME \
	BUILD_REPOSITORY_URI \
	BUILD_REPOSITORY_ID \
	SYSTEM_TEAMPROJECT \
; do
	v="${!e:-}"
	v="${v%.git}" # URI could end in ".git"
	v="${v##*/}" # "tianon/stackbrew" -> "stackbrew", etc
	if [ -n "$v" ]; then
		echo "$v"
		exit
	fi
done

echo >&2 'error: failed to determine Azure "Repo Name"; are we running in Azure Pipelines?'
exit 1
