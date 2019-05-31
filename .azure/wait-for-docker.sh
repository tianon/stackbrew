#!/usr/bin/env bash
set -Eeuo pipefail -x

# sometimes Docker on the Windows workers is a bit slow to start, so let's give it a sec if it isn't responding yet

# (kick the service explicitly if we're on Windows, just for extra "oompf")
if [ "$AGENT_OS" = 'Windows_NT' ] && command -v net &> /dev/null; then
	net start docker || :
fi

tries=30
while [ "$tries" -gt 0 ] && ! docker version &> /dev/null; do
	(( tries-- ))
	sleep 1
done
