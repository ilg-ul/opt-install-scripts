# opt-install-scripts

This is a collection of scripts, used to install optional tools, required during builds.

The strategy is to allow separate updates for separate builds, otherwise updating the tools for one build may affect other builds.

As a consequence, this means to avoid a large install with all tool needed by all builds, and to install separate sets of tools, one for each build.

A small disadvantage of this strategy is a possible duplication of tools, but disk space is not a real limitation.

The build scripts should update the PATH themselves to access the optional tools.

For manual use, for each set of tools an alias to upadate the PATH can be defined.

## Download

These scripts can be downloaded from GitHub [ilg-ul/opt-install-scripts](https://github.com/ilg-ul/opt-install-scripts).

```bash
$ mkdir -p "${HOME}/opt"
$ git clone https://github.com/ilg-ul/opt-install-scripts \
    "${HOME}/opt/install-scripts.git"
```

## homebrew

This Homebrew instance provides general purpose tools, like minicom.

To run the install script:

```bash
$ caffeinate bash "${HOME}/opt/install-scripts.git/install-homebrew.sh"
```

The alias to add these tools to the PATH is `ahb`.

```bash
$ alias ahb='export PATH=${HOME}/opt/homebrew/hb/bin:${PATH}'
```

## homebrew/gcc

This Homebrew instance provides GCC 6 & GCC 7, used during µOS++ test builds.

To run the install script:

```bash
$ caffeinate bash "${HOME}/opt/install-scripts.git/install-homebrew-gcc.sh"
```

The alias to add these tools to the PATH is `agcc`.

```bash
$ alias agcc='export PATH=${HOME}/opt/homebrew/gcc/bin:${PATH}'
```

## homebrew/jekyll

This Homebrew instance provides Jekyll, used to generate the GitHub Pages static sites, like [GNU ARM Eclipse](http://gnuarmeclipse.github.io), [µOS++ IIIe/CMSIS++/POSIX++](http://micro-os-plus.github.io), [XCDL/xPack](http://xcdl.github.io).

To run the install script:

```bash
$ caffeinate bash 
$ exec bash "${HOME}/opt/install-scripts.git/install-homebrew-jekyll.sh"
```

The alias to add these tools to the PATH is `ajkl`.

```bash
$ alias ajkl='export PATH=${HOME}/opt/homebrew/jekyll/bin:${PATH}'
```

## texlive

This is a local instance of [TeX Live](https://tug.org/texlive/), used to build the OpenOCD & QEMU manuals.

It generally includes the same packages as the MacTex distribution, and is **very large** (> 4.5 GB).

To run the install script:

```bash
$ caffeinate bash 
$ exec bash "${HOME}/opt/install-scripts.git/install-texlive.sh"
```

The alias to add these tools to the PATH is `atl`.

```bash
$ alias atl='export PATH=${HOME}/opt/texlive/bin/x86_64-darwin:${PATH}'
```

Notes:

- homebrew blacklisted TeX, (_"Installing TeX from source is weird and gross"_), but, apart from size and install time, there are no other problems.
- however, due to its size, it is better to keep TeX separate from the Homebrew instances, which can now be reinstalled more easily. 
- the current script installs TeX Live 2016.
- the GCC manuals fail with `-scheme basic` (! I can't find file `texinfo.tex'.)
- the OpenOCD manual passes with `-scheme basic`

## homebrew/xbb

It was moved to [xpack/xpack-build-box.git](https://github.com/xpack/xpack-build-box).

---

## homebrew-newt (DEPRECATED)

This Homebrew instance provides Apache `newt`, used to experiment with [mynewt](https://mynewt.apache.org/).

To run the install script:

```bash
$ caffeinate bash 
$ exec bash "${HOME}/opt/install-scripts.git/install-homebrew-newt.sh"
```

The alias to add these tools to the PATH is `newt`.

```bash
$ alias anewt='; export GOPATH=${HOME}/dev/go; export PATH=${HOME}/opt/homebrew/jekyll/bin:GOPATH/bin:${PATH}'
```

## homebrew-gme (DEPRECATED)

This Homebrew instance provides tools used during [GNU MCU Eclipse]((http://gnuarmeclipse.github.io)) binary tools builds, like [QEMU](http://gnuarmeclipse.github.io/qemu/), [OpenOCD](http://gnuarmeclipse.github.io/openocd/) and [Windows Build Tools](http://gnuarmeclipse.github.io/windows-build-tools/).

To run the install script:

```
$ caffeinate bash 
$ exec bash ${HOME}/opt/install-scripts.git/install-homebrew-gme.sh
```

The alias to add these tools to the PATH is `agme`.

```
$ alias agme='export PATH=${HOME}/opt/homebrew/gme/bin:${PATH}'
```

This formula is keg-only, which means it was not symlinked into /Users/ilg/opt/homebrew/gme,
because macOS provides the BSD gettext library & some software gets confused if both are in the library path.


## homebrew/gae (DEPRECATED)

This Homebrew instance provides tools used during [GNU ARM Eclipse]((http://gnuarmeclipse.github.io)) binary tools builds, like [QEMU](http://gnuarmeclipse.github.io/qemu/), [OpenOCD](http://gnuarmeclipse.github.io/openocd/) and [Windows Build Tools](http://gnuarmeclipse.github.io/windows-build-tools/).

To run the install script:

```bash
$ caffeinate bash 
$ exec bash "${HOME}/opt/install-scripts.git/install-homebrew-gae.sh"
```

The alias to add these tools to the PATH is `agae`.

```bash
$ alias agae='export PATH=${HOME}/opt/homebrew/gae/bin:${PATH}'
```

