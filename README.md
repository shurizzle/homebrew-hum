# shurizzle/homebrew-hum

Homebrew tap for [hum](https://github.com/shurizzle/hum), a terminal Spotify client.

```sh
brew install --cask shurizzle/hum/hum
```

macOS only. On Apple Silicon the cask pulls in
[`spotify-soloist`](https://formulae.brew.sh/cask/spotify-soloist); on Intel hum uses its bundled
Electron engine (no Soloist build exists). `spotify-soloist` is unversioned and Soloist builds expire
after 90 days, so update it with:

```sh
brew upgrade --cask --greedy spotify-soloist
```

## Updating

After a hum `vX.Y.Z` release, in `Casks/hum.rb` bump `version` and both `sha256`:

```sh
for a in aarch64 x86_64; do
  curl -sL "https://github.com/shurizzle/hum/releases/download/vX.Y.Z/hum-$a-apple-darwin.tar.gz" | shasum -a 256
done
```
