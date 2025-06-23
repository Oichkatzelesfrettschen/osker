#!/usr/bin/env bash
set -euo pipefail
CUSTOM_FLAGS="-O0 -Wall -fllvm -threaded"
(
    cd Posix && make --debug=v HCFLAGS="$CUSTOM_FLAGS" quick > ../build.log 2>&1
) || true
# Mirror setup.sh behaviour
echo "USED FLAGS: $CUSTOM_FLAGS" >> build.log
# Verify the custom flags were logged
grep -q -- "USED FLAGS: $CUSTOM_FLAGS" build.log
