Osker
=====

Sharing work on resumption monad

Setup
-----
Run `./setup.sh` to prepare the development environment.  The script
shows which tmux related packages are available, installs the tools
required for building the Haskell sources along with QEMU for
virtualization experiments, and writes a tmux configuration using the
plugin manager.  It installs debugging utilities such as `shellcheck`
and `hlint` and performs a verbose build of the `Posix` directory with
aggressive optimization flags.  The default compile options are
documented in `setup.sh` and include `-O3 -Wall -fllvm -threaded -rtsopts -with-rtsopts=-N`.  The
`build.log` file records the full command lines so you can verify the
flags in use.

Configuration
-------------
You can provide your own compiler options by setting the `HASKELL_OPTS`
environment variable before running the setup script.  These options are
passed directly to `make` and echoed into `build.log`.  For example:

```
HASKELL_OPTS="-O0 -Wall -threaded" ./setup.sh
```

After the script completes `build.log` will contain a line beginning with
`USED FLAGS:` showing the exact arguments applied.

Usage
-----
After running the setup you can build each part of Osker using the
provided Makefiles. For example:

```
cd Posix
make
```

Use tmux to keep multiple build shells or editors open during
development.

Building
--------
The Makefiles expect a `dirs.mk` file that is not included in this
repository. The setup script still runs a small build of the `Posix`
directory so that missing dependencies are surfaced in `build.log`. Once
you provide `dirs.mk` you can build each component normally with
`make`.

Tests
-----
The `tests/test_flags.sh` script validates that the default compiler
flags are applied correctly.  Run it after `setup.sh` to confirm that
`build.log` contains the optimization options.
The companion script `tests/test_custom_flags.sh` demonstrates how to
override the compiler settings and ensures the log reflects the custom
arguments.
