# opt-install-scripts

This is a collection of scripts, used to install optional tools,
required during builds.

The strategy is to allow separate updates for separate builds,
otherwise updating the tools for one build may affect other builds.

As a consequence, this means to avoid a large install with all
tools needed by all builds, and to install separate sets of tools,
one for each build.

A small disadvantage of this strategy is a possible duplication of
tools, but disk space is not a real limitation.

The build scripts should update the PATH themselves to access
the optional tools.

For manual use, for each set of tools an alias to upadate the
PATH can be defined.

## Download

These scripts can be downloaded from GitHub
[ilg-ul/opt-install-scripts](https://github.com/ilg-ul/opt-install-scripts).

```sh
rm -rf "${HOME}/Downloads/opt-install-scripts.git"; \
git clone https://github.com/ilg-ul/opt-install-scripts \
    "${HOME}/Downloads/opt-install-scripts.git"
```

## homebrew

This Homebrew instance provides general purpose tools, like minicom.

To run the install script:

```sh
caffeinate bash "${HOME}/Downloads/opt-install-scripts.git/install-homebrew.sh"
```

The alias to add these tools to the PATH is `ahb`.

```sh
alias ahb='export PATH=${HOME}/.local/homebrew/hb/bin:${PATH}'
```

## homebrew/jekyll

This Homebrew instance provides Jekyll, used to generate the GitHub Pages
static sites locally.

To run the install script:

```sh
caffeinate bash "${HOME}/Downloads/opt-install-scripts.git/install-homebrew-jekyll.sh"
```

The alias to add these tools to the PATH is `ajkl`.

```sh
alias ajkl='export PATH=${HOME}/.local/homebrew/jekyll/bin:${PATH}'
```

## texlive

This is a local instance of [TeX Live](https://tug.org/texlive/), used to build the OpenOCD & QEMU manuals.

It generally includes the same packages as the MacTex distribution, and is **very large** (> 4.5 GB).

To run the install script:

```sh
ahb

caffeinate bash "${HOME}/Downloads/opt-install-scripts.git/install-texlive.sh"
chmod -R a-w "${HOME}/.local/texlive"
```

The alias to add these tools to the PATH is `atl`.

```sh
alias atl='export PATH=${HOME}/.local/texlive/bin/x86_64-darwin:${PATH}'
```

Notes:

- homebrew blacklisted TeX, (_"Installing TeX from source is weird and gross"_), but, apart from size and install time, there are no other problems
- however, due to its size, it is better to keep TeX separate from the Homebrew instances, which can now be reinstalled more easily
- the current script installs TeX Live 2016, the medium scheme (1015 packets)
- the GCC manuals fail with `-scheme basic` (! I can't find file `texinfo.tex'.)
- the OpenOCD manual passes with `-scheme basic`

## maven

The Apache Maven download page is:

- <https://maven.apache.org/download.cgi>

To install maven in a custom folder in `$HOME/.local`, use:

```sh
caffeinate bash "${HOME}/Downloads/opt-install-scripts.git/install-maven.sh"
```

The alias to add these tools to the PATH is `amaven`.

```sh
alias amaven='export PATH=${HOME}/.local/apache-maven-3.6.3/bin:${PATH}'
```
