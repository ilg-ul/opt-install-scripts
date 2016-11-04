# install-opt

This is a collection of scripts, used to install optional tools, used during builds.

The strategy is to allow separate updates for separate builds, otherwise updating the tools for a build may affect other builds.

As a consequence, this means to avoid a large install with every tool needed by all builds, and to install separate set of tools, for each build.

A small disadvantage of this strategy is a possible duplication of tools, but disk space is not a real limitation.

The build scripts should update the PATH themselves to access the optional tools.

For manual use, for each set of tools can be defined an alias to upadate the PATH.


## homebrew

This Homebrew instance installs general purpose tools, like minicom.

The alias to add these tools to the PATH is `hb`.

```
alias hb='export PATH=$HOME/opt/homebrew/bin:$PATH'
```

## homebrew-gae

This Homebrew instance installs tools used during [GNU ARM Eclipse]((http://gnuarmeclipse.github.io)) binary tools builds, like [QEMU](http://gnuarmeclipse.github.io/qemu/), [OpenOCD](http://gnuarmeclipse.github.io/openocd/) and [Windows Build Tools](http://gnuarmeclipse.github.io/windows-build-tools/).

The alias to add these tools to the PATH is `hbg`.

```
alias hbg='export PATH$HOME/opt/homebrew-gae/bin:$PATH'
```

## homebrew-gcc

This Homebrew instance installs GCC 5 and GCC 6, used during µOS++ test builds.

The alias to add these tools to the PATH is `hbgcc`.

```
alias hbgcc='export PATH=$HOME/opt/homebrew-gcc/bin:$PATH'
```

## homebrew-jekyll

This Homebrew instance installs Jekyll, used to generate the GitHub Pages static sites, like [GNU ARM Eclipse](http://gnuarmeclipse.github.io), [µOS++ IIIe / CMSIS++ / POSIX++](http://micro-os-plus.github.io), [XCDL / xPack](http://xcdl.github.io).

The alias to add these tools to the PATH is `hbj`.

```
alias hbj='export PATH=$HOME/opt/homebrew-jekyll/bin:$PATH'
```

## texlive

This is a local instance of Texlive, used to build the OpenOCD & QEMU manuals.

It generally includes the same packages as the MacTex distribution, and is **very large** (> 4.5 GB).

The alias to add these tools to the PATH is `tl`.

```
alias tl='export PATH=$HOME/opt/texlive/bin/x86_64-darwin:$PATH'
```
