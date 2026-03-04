# bunenv

Bun version management with a familiar `rbenv`-style workflow.

`bunenv` lets you install multiple Bun versions and switch between them per-shell,
per-project, or globally.

## How it works

- `bunenv` installs Bun versions under `~/.bunenv/versions/*`
- `bunenv rehash` creates shims in `~/.bunenv/shims`
- putting `~/.bunenv/shims` first in `PATH` routes `bun`/`bunx` through bunenv
- active version selection order:
	1. `BUNENV_VERSION`
	2. nearest `.bun-version` (current dir up to root)
	3. `~/.bunenv/version`
	4. `system`

## Installation

On systems with Homebrew, using a package manager is usually preferred.
If a `bunenv` formula is not available yet, use the Basic Git Checkout method.

### Using Package Managers

#### Homebrew (when available)

```bash
brew install bunenv
```

If Homebrew reports no available formula for `bunenv`, install via Git checkout below.

Set up your shell to load bunenv:

```bash
bunenv init
```

Restart your shell so changes take effect.

### Basic Git Checkout

For a manual install that tracks the latest bunenv version:

Clone bunenv into `~/.bunenv`:

```bash
git clone https://github.com/bunenv/bunenv.git ~/.bunenv
```

Set up your shell to load bunenv:

```bash
~/.bunenv/bin/bunenv init
```

For Fish shell:

```bash
echo 'status --is-interactive; and ~/.bunenv/bin/bunenv init - fish | source' >> ~/.config/fish/config.fish
```

Restart your shell so these changes take effect.

### Shell completions

When manually installing bunenv, completion scripts help expand commands and flags.

- Bash completion ships with bunenv and is loaded by `bunenv init`.
- Fish completion ships with bunenv and is loaded by `bunenv init`.
- Zsh completion ships with bunenv, but you may need to add completions to `FPATH`:

```bash
# assuming bunenv is installed to ~/.bunenv
FPATH=~/.bunenv/completions:"$FPATH"

autoload -U compinit
compinit
```

## Usage

```bash
# List installable Bun releases
bunenv install --list

# Install a version
bunenv install 1.3.10

# Set as global default
bunenv global 1.3.10

# Set per-project
cd my-project
bunenv local 1.3.10

# Show active version and origin
bunenv version

# List installed versions
bunenv versions

# Temporarily override in current shell
bunenv shell 1.3.10

# Uninstall a version
bunenv uninstall 1.2.0
```

## Commands

- `bunenv commands`
- `bunenv completions <command>`
- `bunenv exec <command> [args...]`
- `bunenv global [version|--unset]`
- `bunenv help [--usage] [command]`
- `bunenv hooks <hook-name>`
- `bunenv init [-|--no-rehash] [shell]`
- `bunenv install <version> | --list | --list-all`
- `bunenv local [version|--unset]`
- `bunenv prefix [version]`
- `bunenv rehash`
- `bunenv root`
- `bunenv shell [version|-|--unset]`
- `bunenv shims [--short]`
- `bunenv uninstall [-f|--force] <version>`
- `bunenv version`
- `bunenv version-name`
- `bunenv version-origin`
- `bunenv versions [--bare|--skip-aliases]`
- `bunenv whence <command>`
- `bunenv which <command>`

## Environment variables

- `BUNENV_ROOT` (default `~/.bunenv`)
- `BUNENV_VERSION` (shell/session override)
- `BUNENV_DIR` (directory used for `.bun-version` lookup)
- `BUNENV_DEBUG` (set to non-empty for trace mode)
- `BUNENV_GITHUB_TOKEN` or `GITHUB_TOKEN` (GitHub API auth for install/list)
- `BUNENV_BUILD_VARIANT=baseline` (install baseline release artifact)

## License

MIT