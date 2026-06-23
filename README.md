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

## Versioning

The formula is pinned to a specific upstream release (currently **v0.5.1**) with
per-architecture SHA256 checksums.

## Updating to a new upstream version

When [`aegis-rs`](https://github.com/Granddave/aegis-rs/releases) publishes a new
release, update the formula by hand:

1. **Recompute the checksums** for the four supported targets. Set `VERSION` to the
   new release (without the `v` prefix) and run:

   ```sh
   VERSION=0.5.2
   BASE="https://github.com/Granddave/aegis-rs/releases/download/v${VERSION}"
   for t in aarch64-apple-darwin x86_64-apple-darwin \
            aarch64-unknown-linux-gnu x86_64-unknown-linux-gnu; do
     f="aegis-${t}-v${VERSION}.tgz"
     curl -sL "${BASE}/${f}" -o "/tmp/${f}"
     echo "${t}: $(shasum -a 256 "/tmp/${f}" | cut -d' ' -f1)"
   done
   ```

2. **Edit `Formula/aegis-rs.rb`:** bump `version` to the new value and replace each
   of the four `sha256` lines with the matching checksum printed above. The URLs
   reference `#{version}` automatically, so they don't need editing.

3. **Verify** the formula still installs and passes its test (see `TESTING.md`),
   then commit.

> Automating these bumps with GitHub Actions is a planned future improvement.

## License

The `aegis-rs` software is licensed under GPL-3.0-only by its author. This tap
repository only contains packaging metadata (the Homebrew formula).
