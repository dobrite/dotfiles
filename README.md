# dotfiles

My dotfiles for various things.

```
mkdir -p ~/.githooks
ln -s $HOME/dotfiles/.gitconfig ~/.gitconfig
ln -s $HOME/dotfiles/pre-push ~/.githooks/pre-push
git config --local hooks.allowpushmain true
ln -s $HOME/dotfiles/.zprofile ~/.zprofile
ln -s $HOME/dotfiles/.gitattributes ~/.gitattributes
ln -s $HOME/dotfiles/.gitignore_global ~/.gitignore_global
ln -s $HOME/dotfiles/direnv.toml ~/.config/direnv/direnv.toml
ln -s $HOME/dotfiles/ghostty-config ~/.config/ghostty/config
ln -s $HOME/dotfiles/.irbrc ~/.irbrc
ln -s $HOME/dotfiles/bin/git-delete-local-merged /usr/local/bin
ln -s $HOME/dotfiles/bin/git-super-prune /usr/local/bin
ln -s $HOME/dotfiles/bin/timey.rb /usr/local/bin
ln -s $HOME/dotfiles/home_claude.md ~/.claude/CLAUDE.md
mkdir ~/.config/herdr
ln -s $HOME/dotfiles/herdr-config.toml ~/.config/herdr/config.toml
```

Raycast: Settings → Extensions → Script Commands → Add Directories → `$HOME/dotfiles/raycast`.
Then set the alias `pr-review` on the "PR review" command so `/pr-review` works.
