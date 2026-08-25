# Contributing

Thanks for helping keep the tap healthy. There are two very different kinds of
change, and they go to different places.

## Formula content → upstream

`Formula/*.rb` is **generated** by
[`scripts/brew-formula.mjs`](https://github.com/mchittineni/tf-arch-diagram-generator/blob/main/scripts/brew-formula.mjs)
in the tool's repository and pushed here on every release. A hand edit will be
overwritten by the next release, so:

- wrong `desc`, `homepage`, `test do`, dependency, install step → change the
  generator upstream and open the PR there;
- new version → nothing to do, the release pipeline handles it. If the tap
  lags npm (the weekly *Formulae track upstream* job fails), regenerate by hand
  from a checkout of the upstream repo:

  ```bash
  node scripts/brew-formula.mjs <version> > /path/to/homebrew-tap/Formula/tf-arch.rb
  ```

## Everything else → here

CI, docs, issue templates and repository configuration live in this repo.
Please:

1. Open a pull request against `main`.
2. Make sure CI is green — it runs `brew style`, `brew audit --strict --online`,
   builds every formula from source and runs `brew test` on macOS and Linux.
3. Keep GitHub Actions pinned to a full commit SHA with the version in a
   trailing comment (Dependabot maintains them).

## Testing a formula locally

```bash
brew tap mchittineni/tap
brew style mchittineni/tap
brew audit --strict --online --tap mchittineni/tap
brew install --build-from-source --verbose mchittineni/tap/tf-arch
brew test --verbose mchittineni/tap/tf-arch
```

To test an uncommitted change, edit the file inside
`$(brew --repository mchittineni/tap)` directly — that directory *is* the tap
checkout — and run the same commands.

## Reporting problems

- Installation or upgrade fails → open an issue here using the template.
- The tool misbehaves once installed → the
  [upstream issue tracker](https://github.com/mchittineni/tf-arch-diagram-generator/issues).
- Security → see [SECURITY.md](SECURITY.md).
