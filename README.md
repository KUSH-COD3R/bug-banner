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
| `shell`   | Interactive mode. Type `exit` or `quit` to leave |
| `help`    | Show help                                        |
| `version` | Show version                                     |

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

## Show on Termux startup

Add this line to `~/.bashrc`:

```
bash ~/bug-banner/bug-banner.sh
```
