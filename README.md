# homebrew-aegis-rs

A [Homebrew](https://brew.sh) tap for [`aegis-rs`](https://github.com/Granddave/aegis-rs)
— an Aegis-compatible OTP (TOTP) generator for the command line.

This tap installs a **pre-compiled binary** from the upstream
[GitHub Releases](https://github.com/Granddave/aegis-rs/releases), so no Rust
toolchain is required.

## Supported platforms

| OS    | Architecture        |
|-------|---------------------|
| macOS | Apple Silicon (arm64) |
| macOS | Intel (x86_64)        |
| Linux | arm64 (aarch64, gnu)  |
| Linux | x86_64 (gnu)          |

## Installation

```sh
brew install lucasfais/aegis-rs/aegis-rs
```

## Usage

```sh
aegis-rs ~/path/to/aegis-backup.json
```

See the [upstream README](https://github.com/Granddave/aegis-rs#readme) for full
usage, flags, and environment variables.

## Upgrading

```sh
brew update
brew upgrade aegis-rs
```

## Uninstalling

```sh
brew uninstall aegis-rs
brew untrust --formula lucasfais/aegis-rs/aegis-rs   # or: brew untrust lucasfais/aegis-rs
brew untap lucasfais/aegis-rs
```

## Updating to a new upstream version

### Automatic (GitHub Actions)

The [`Update formula`](.github/workflows/update-formula.yml) workflow keeps the tap
in sync with upstream:

- **Daily schedule** — polls [`aegis-rs` releases](https://github.com/Granddave/aegis-rs/releases)
  and, when a newer version exists, opens a pull request that bumps `version` and
  recomputes all four `sha256` checksums.
- **Manual run** — trigger it from the Actions tab ("Run workflow"), optionally
  passing a specific version; leave blank to use the latest release.

Each run downloads the release assets and runs `brew style` / `brew audit` before
opening the PR. Review the diff and merge to publish the new version.

> Requires repo setting **Settings → Actions → General → "Allow GitHub Actions to
> create and approve pull requests"** to be enabled.

### Manual

Run the helper script with the new version (without the `v` prefix); it downloads
each asset, computes checksums, and rewrites the formula:

```sh
bash scripts/update-formula.sh 0.5.2
```

Then verify (see `TESTING.md`) and commit. The URLs reference `#{version}`
automatically, so only `version` and the `sha256` lines change.

## License

The `aegis-rs` software is licensed under GPL-3.0-only by its author. This tap
repository only contains packaging metadata (the Homebrew formula).
