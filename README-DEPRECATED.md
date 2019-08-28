
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

