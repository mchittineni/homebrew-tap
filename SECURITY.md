# Security policy

## Reporting

Please **do not open a public issue** for a vulnerability.

- A problem in the tool itself (`tf-arch`): report it upstream via
  [tf-arch-diagram-generator's security policy](https://github.com/mchittineni/tf-arch-diagram-generator/blob/main/SECURITY.md).
- A problem in this tap — a formula fetching the wrong artifact, a CI
  workflow leaking or over-privileging a token — use
  [GitHub private vulnerability reporting](https://github.com/mchittineni/homebrew-tap/security/advisories/new)
  on this repository.

You will get an acknowledgement within a few days. Fixes ship as a new formula
revision; there is no embargo period beyond what is needed to publish the fix.

## How the formulae are protected

- **Pinned, verified artifacts.** Every formula points at one exact npm tarball
  (`registry.npmjs.org/<package>/-/<package>-<version>.tgz`) and carries its
  `sha256`. Homebrew refuses to install if the download does not match.
- **Generated, not hand-written.** Formulae are produced by
  [`scripts/brew-formula.mjs`](https://github.com/mchittineni/tf-arch-diagram-generator/blob/main/scripts/brew-formula.mjs)
  during the upstream release. The generator checks the tarball against the
  registry's own `dist.integrity` (sha512) before computing the `sha256` it
  writes here, so a formula can only ever describe the bytes npm actually
  published.
- **Provenance upstream.** The npm package is published from GitHub Actions
  via OIDC trusted publishing — no long-lived npm token exists — and is
  installed by Homebrew with `npm install` of that tarball only; the tool has
  zero runtime dependencies, so nothing else is fetched.
- **Least-privilege automation.** The upstream pipeline writes to this
  repository with a fine-grained token scoped to *this repository only* with
  `Contents: read/write`, held in a single workflow step. CI here runs with
  `contents: read`, and every action is pinned to a commit SHA and kept
  current by Dependabot.
- **Continuous verification.** CI builds from source and runs each formula's
  `test do` block on macOS and Linux for every change and weekly, and a weekly
  `brew livecheck` fails if the tap has fallen behind the upstream release.

## Supported versions

Only the newest formula revision is supported. `brew upgrade` is the fix for
anything found in an older one.
