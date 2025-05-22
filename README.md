# NZ's dotfiles

This repository contains my config files for the current workspace.
It also provides workspace installation and synchronization scripts.

All the packages in the workspace are specified in [`deps.txt`](./deps.txt)

## `install.sh`

This is a workspace installation script.
It performs installation of all the packages and programs that I use.
Only missing packages will be installed.

### Usage

```bash
$ /path/to/dotfiles/install.sh
```

No arguments accepted. You will be prompted to confirm installation.

## `sync.sh`

This is a config files synchronization script.
It performs copying all the dotfiles from the repo to the homedir fully preserving file hierarchy.

### Usage

```bash
$ /path/to/dotfiles/sync.sh
```

No arguments accepted. You will not be prompted for anything.

## Credits

Made by **nz** aka **nunzayin** aka **Nick Zaber**

## License

See the [`LICENSE`](./LICENSE)
