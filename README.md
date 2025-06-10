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
and `hlint` and performs a verbose build of the `Posix` directory.
All compiler output is recorded in `build.log` for later review.

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
