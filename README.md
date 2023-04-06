# makmonty's dotfiles

## Requirements

For AwesomeWM to work:

- Install `xsettingsd` to get authentication popups. [More info](https://wiki.archlinux.org/title/Polkit#Authentication_agents)
- Install `lxsession` to get GTK apps themed. [More info](https://www.reddit.com/r/awesomewm/comments/k662sl/two_problems_with_awesome_gtk_theme_gaps_settings/)

To be able to get SSIDs in the network widget:

```bash
echo "%network ALL=(ALL:ALL) NOPASSWD:/usr/bin/iw" > /etc/sudoers.d/network
```

## Features

- `.zsh_local` for local ZSH configuration. Gitignored
