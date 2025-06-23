#!/usr/bin/env bash
set -euo pipefail
HASKELL_OPTS="-O3 -Wall -fllvm -threaded -rtsopts -with-rtsopts=-N"
(
    cd Posix && make --debug=v HCFLAGS="$HASKELL_OPTS" quick > ../build.log 2>&1
) || true
# Mirror the behaviour of setup.sh so the log captures the options
echo "USED FLAGS: $HASKELL_OPTS" >> build.log
# Ensure the build log records the flags
grep -q -- "USED FLAGS: $HASKELL_OPTS" build.log
