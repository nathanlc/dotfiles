# dotfiles
You know what this is.

## "Install"
After cloning:
Each "thing" (package) is in its own folder so it can be stowed, eg:
```sh
# Inside the dotfiles repo:
stow --dotfiles --target ~/. tmux
```

`agents`: create `~/.agents/skills` first (`mkdir -p ~/.agents/skills`) so stow links each skill
instead of the whole directory. Otherwise skills installed by tools (Claude sync, `npx skills`)
land in this repo.
