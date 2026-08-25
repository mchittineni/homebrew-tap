# mchittineni/homebrew-tap

[![CI](https://github.com/mchittineni/homebrew-tap/actions/workflows/ci.yml/badge.svg)](https://github.com/mchittineni/homebrew-tap/actions/workflows/ci.yml)
[![tf-arch on npm](https://img.shields.io/npm/v/tf-arch-diagram-generator?label=tf-arch)](https://www.npmjs.com/package/tf-arch-diagram-generator)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

Homebrew formulae for [mchittineni](https://github.com/mchittineni)'s tools.

```bash
brew install mchittineni/tap/tf-arch
```

| Formula | What it is |
|---|---|
| [`tf-arch`](Formula/tf-arch.rb) | [tf-arch-diagram-generator](https://github.com/mchittineni/tf-arch-diagram-generator) — turn any Terraform plan into an interactive cloud architecture diagram (AWS, Google Cloud, Azure) |

## Usage

```bash
# install (taps the repository for you) / upgrade / remove
brew install mchittineni/tap/tf-arch
brew upgrade tf-arch
brew uninstall tf-arch && brew untap mchittineni/tap

# then, from a Terraform working directory
terraform plan -out=tfplan && terraform show -json tfplan > plan.json
tf-arch serve plan.json --open          # interactive viewer
tf-arch render plan.json --out arch.svg # standalone SVG
```

The formula installs the exact npm tarball of the release and pulls in
Homebrew's `node` as a dependency, so you never manage a Node.js installation
yourself. macOS (Apple silicon and Intel) and Linux are supported and tested.

## How this tap is maintained

- **Formulae are generated, not hand-written.** Each release of an upstream
  project runs
  [`scripts/brew-formula.mjs`](https://github.com/mchittineni/tf-arch-diagram-generator/blob/main/scripts/brew-formula.mjs),
  which verifies the freshly published npm tarball against the registry's
  integrity hash and commits the resulting formula here. The version in the
  formula therefore always equals the version on npm.
- **Every change is tested.** [CI](.github/workflows/ci.yml) runs `brew style`,
  `brew audit --strict --online`, a from-source install and each formula's
  `brew test` on macOS and Linux — on every push and pull request, and weekly
  so upstream changes (new Node majors, registry behaviour) are caught early.
  A weekly `brew livecheck` fails if the tap has fallen behind npm.
- **Supply-chain posture.** Pinned sha256 per artifact, SHA-pinned GitHub
  Actions kept current by Dependabot, read-only CI token, single-purpose
  write token for the release automation. Details in [SECURITY.md](SECURITY.md).

## Troubleshooting

| Symptom | What to do |
|---|---|
| `Error: mchittineni/tap/tf-arch: ... SHA256 mismatch` | Your download was corrupted or tampered with. `brew cleanup tf-arch` and retry; if it persists, open an issue here. |
| `tf-arch: command not found` after install | `brew link tf-arch`, or check `brew doctor` for a `PATH` warning. |
| Wrong version after `brew upgrade` | `brew update` first — the tap is a git repo Homebrew refreshes on update. |
| The diagram is wrong / a resource is missing | That is the tool, not the packaging — report it [upstream](https://github.com/mchittineni/tf-arch-diagram-generator/issues). |

## Contributing and security

- Formula bugs and features → the upstream generator ([CONTRIBUTING.md](CONTRIBUTING.md) explains why).
- CI, docs and repo config → pull requests here.
- Vulnerabilities → [SECURITY.md](SECURITY.md); please do not open public issues.

Licensed under the [MIT License](LICENSE).
