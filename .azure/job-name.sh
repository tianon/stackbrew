#!/usr/bin/env bash
set -Eeuo pipefail

# In a "strategy: matrix: ..." multi-target build, this script should return the name of the matrix stage from the YAML file ("linux", "windows-1803", etc)

# "SYSTEM_JOBNAME" isn't documented anywhere I can find
# "AGENT_JOBNAME" includes a "Job xxx" prefix (as does the also undocumented "SYSTEM_JOBDISPLAYNAME", and "SYSTEM_JOBIDENTIFIER" includes a "Job.xxx" prefix)

for e in \
	SYSTEM_JOBNAME \
	AGENT_JOBNAME \
	SYSTEM_JOBDISPLAYNAME \
	SYSTEM_JOBIDENTIFIER \
; do \
	v="${!e:-}"
	v="${v#Job }"
	v="${v#Job.}"
	if [ -n "$v" ]; then
		echo "$v"
		exit
	fi
done

echo >&2 'error: failed to determine Azure "Job Name"; are we running in Azure Pipelines?'
exit 1
