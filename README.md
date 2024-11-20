# dotfiles

My dotfiles for various things.

```
mkdir -p ~/.githooks
ln -s /Users/<username>/dotfiles/.gitconfig ~/.gitconfig
ln -s /Users/<username>/dotfiles/pre-push ~/.githooks/pre-push
git config --local hooks.allowpushmain true
ln -s /Users/<username>/dotfiles/.zprofile ~/.zprofile
ln -s /Users/<username>/dotfiles/.gitattributes ~/.gitattributes
ln -s /Users/<username>/dotfiles/direnv.toml ~/.config/direnv/direnv.toml
```
