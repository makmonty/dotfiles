# makmonty's dotfiles

## Requirements

For AwesomeWM to work:

- Install `lxsession-gtk3` to get authentication popups. [More info](https://wiki.archlinux.org/title/Polkit#Authentication_agents)
- Install `lxappearance` to apply themes to GTK apps.

To be able to get SSIDs in the network widget:

```bash
echo "%network ALL=(ALL:ALL) NOPASSWD:/usr/bin/iw" > /etc/sudoers.d/network
```

## Features

- `.zsh_local` for local ZSH configuration. Gitignored
