#!/usr/bin/env bash
# Setup script for the Osker development environment.
# Installs Haskell tooling, tmux helpers and QEMU.  A small build is
# attempted so that any compiler issues surface immediately.

set -euo pipefail
# Print each command before executing so that failures are easy to spot
set -x

# Default optimization flags for the Haskell compiler.  Users may
# override these by setting the HASKELL_OPTS environment variable before
# invoking this script.
HASKELL_OPTS=${HASKELL_OPTS:-"-O3 -Wall -fllvm -threaded -rtsopts -with-rtsopts=-N"}

# Display available tmux related packages so they can be installed if desired.
list_tmux_packages() {
    apt-cache search tmux | awk '{print "    " $0}'
}

# Install packages required for building Osker and running QEMU
install_packages() {
    sudo apt-get update
    sudo apt-get install -y \
        build-essential git make \
        ghc cabal-install \
        tmux tmux-plugin-manager python3-libtmux python3-tmuxp \
        qemu-system-x86 qemu-system-arm qemu-utils \
        shellcheck hlint gdb strace
}


# Try building a simple component to verify the Haskell toolchain.
# Run a small build and log the output for review.  Failures are allowed so
# the script can continue even if build prerequisites are missing.
build_osker() {
    (
        cd Posix && \
        make --debug=v HCFLAGS="$HASKELL_OPTS" quick 2>&1 | tee ../build.log
    ) || true
    echo "USED FLAGS: $HASKELL_OPTS" >> build.log
}

# Install a default tmux configuration tailored for development.
install_tmux_conf() {
    cat <<'TMUXCONF' > "$HOME/.tmux.conf"
# Enable mouse support and longer history.
set -g mouse on
set -g history-limit 10000

# Start pane and window numbering at 1.
set -g base-index 1
setw -g pane-base-index 1

# Set a simple status bar theme.
set -g status-bg colour234
set -g status-fg colour136

# Use TPM for plugin management
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'

run '~/.tmux/plugins/tpm/tpm'
TMUXCONF
}

# Run all setup steps in order.
main() {
    list_tmux_packages
    install_packages
    install_tmux_conf
    build_osker
    printf "Setup completed. You can now run make in each directory.\n"
}

main "$@"

