# bug-banner

A bug-themed ASCII terminal banner for Termux and other shells.

## Usage

```
bug-banner [OPTIONS] [COMMAND]
```

### Commands

| Command   | Description                                      |
|-----------|--------------------------------------------------|
| `show`    | Print the banner (default)                       |
| `info`    | Print system information only                    |
| `hunt`    | Print the bug hunt banner                        |
| `shell`   | Interactive mode (see below)                     |
| `help`    | Show help                                        |
| `version` | Show version                                     |
| `exit`    | Exit without output (also `quit`)                |

### Shell mode

- `shell` inside shell mode opens a nested level. The prompt shows the level, e.g. `bug[2]`.
- `back` or `bugs` leaves the current level.
- `exit` or `quit` leaves every level and returns to Termux.
- Leaving shell mode prints `Leaving bug-banner. Bye.`

### Options

| Option                 | Description                                        |
|------------------------|----------------------------------------------------|
| `-c, --color NAME`     | `green` (default), `cyan`, `yellow`, `red`, `none` |
| `-n, --no-info`        | Hide the system information line                  |
| `-h, --help`           | Show help                                          |
| `-v, --version`        | Show version                                       |

### Examples

```
bash bug-banner.sh
bash bug-banner.sh --color cyan info
bash bug-banner.sh -n show
bash bug-banner.sh shell
```

## Install in Termux

Link the script so you can run `bug-banner` from anywhere:

```
ln -sf ~/bug-banner/bug-banner.sh "$PREFIX/bin/bug-banner"
```

## Show on Termux startup

Add this line to `~/.bashrc`:

```
bash ~/bug-banner/bug-banner.sh
```
