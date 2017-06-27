# install-opt

This is a collection of scripts, used to install optional tools, required during builds.

The strategy is to allow separate updates for separate builds, otherwise updating the tools for one build may affect other builds.

As a consequence, this means to avoid a large install with all tool needed by all builds, and to install separate sets of tools, one for each build.

A small disadvantage of this strategy is a possible duplication of tools, but disk space is not a real limitation.

The build scripts should update the PATH themselves to access the optional tools.

For manual use, for each set of tools an alias to upadate the PATH can be defined.

## Download

These scripts can be downloaded from GitHub [ilg-ul/opt-install-scripts](https://github.com/ilg-ul/opt-install-scripts).

```
$ mkdir -p ${HOME}/opt
$ git clone https://github.com/ilg-ul/opt-install-scripts \
    ${HOME}/opt/install-scripts.git
```

## homebrew

This Homebrew instance provides general purpose tools, like minicom.

To run the install script:

```
$ caffeinate bash ${HOME}/opt/install-scripts.git/install-homebrew.sh
```

The alias to add these tools to the PATH is `hb`.

```
$ alias ahb='export PATH=${HOME}/opt/homebrew/bin:${PATH}'
```

## homebrew-gme

This Homebrew instance provides tools used during [GNU MCU Eclipse]((http://gnuarmeclipse.github.io)) binary tools builds, like [QEMU](http://gnuarmeclipse.github.io/qemu/), [OpenOCD](http://gnuarmeclipse.github.io/openocd/) and [Windows Build Tools](http://gnuarmeclipse.github.io/windows-build-tools/).

To run the install script:

```
$ caffeinate bash 
$ bash ${HOME}/opt/install-scripts.git/install-homebrew-gme.sh
```

The alias to add these tools to the PATH is `agme`.

```
$ alias agme='export PATH${HOME}/opt/homebrew-gae/bin:${PATH}'
```

## homebrew-gae (DEPRECATED)

This Homebrew instance provides tools used during [GNU ARM Eclipse]((http://gnuarmeclipse.github.io)) binary tools builds, like [QEMU](http://gnuarmeclipse.github.io/qemu/), [OpenOCD](http://gnuarmeclipse.github.io/openocd/) and [Windows Build Tools](http://gnuarmeclipse.github.io/windows-build-tools/).

To run the install script:

```
$ caffeinate bash 
$ bash ${HOME}/opt/install-scripts.git/install-homebrew-gae.sh
```

The alias to add these tools to the PATH is `agae`.

```
$ alias agae='export PATH${HOME}/opt/homebrew-gae/bin:${PATH}'
```

## homebrew-gcc

This Homebrew instance provides GCC 5 and GCC 6, used during µOS++ test builds.

To run the install script:

```
$ caffeinate bash 
$ bash ${HOME}/opt/install-scripts.git/install-homebrew-gcc.sh
```

The alias to add these tools to the PATH is `hbgcc`.

```
$ alias agcc='export PATH=${HOME}/opt/homebrew-gcc/bin:${PATH}'
```

## homebrew-jekyll

This Homebrew instance provides Jekyll, used to generate the GitHub Pages static sites, like [GNU ARM Eclipse](http://gnuarmeclipse.github.io), [µOS++ IIIe/CMSIS++/POSIX++](http://micro-os-plus.github.io), [XCDL/xPack](http://xcdl.github.io).

To run the install script:

```
$ caffeinate bash 
$ bash ${HOME}/opt/install-scripts.git/install-homebrew-jekyll.sh
```

The alias to add these tools to the PATH is `hbj`.

```
$ alias ajkl='export PATH=${HOME}/opt/homebrew-jekyll/bin:${PATH}'
```

## homebrew-newt

This Homebrew instance provides Apache `newt`, used to experiment with [mynewt](https://mynewt.apache.org/).

To run the install script:

```
$ caffeinate bash 
$ bash ${HOME}/opt/install-scripts.git/install-homebrew-newt.sh
```

The alias to add these tools to the PATH is `newt`.

```
$ alias anewt='; export GOPATH=${HOME}/dev/go; export PATH=${HOME}/opt/homebrew-jekyll/bin:GOPATH/bin:${PATH}'
```

## texlive

This is a local instance of [TeX Live](https://tug.org/texlive/), used to build the OpenOCD & QEMU manuals.

It generally includes the same packages as the MacTex distribution, and is **very large** (> 4.5 GB).

To run the install script:

```
$ caffeinate bash 
$ bash ${HOME}/opt/install-scripts.git/install-texlive.sh
```

The alias to add these tools to the PATH is `tl`.

```
$ alias atl='export PATH=${HOME}/opt/texlive/bin/x86_64-darwin:${PATH}'
```

Note 1: Homebrew blacklisted TeX, (_"Installing TeX from source is weird and gross"_), but, apart from size and install time, there are no other problems.

Note 2: However, due to its size, it is better to keep TeX separate from the Homebrew instances, which can now be reinstalled more easily. 
