#!/usr/bin/env bash
#
# Update Formula/aegis-rs.rb to a given upstream version.
# Downloads each supported release asset, computes its SHA256, and rewrites the
# `version` and the four `sha256` lines in the formula.
#
# Usage: scripts/update-formula.sh <version>     # version without the leading "v"
#   e.g. scripts/update-formula.sh 0.5.2
#
set -euo pipefail

VERSION="${1:?usage: update-formula.sh <version-without-v>}"
VERSION="${VERSION#v}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FORMULA="${SCRIPT_DIR}/../Formula/aegis-rs.rb"
BASE="https://github.com/Granddave/aegis-rs/releases/download/v${VERSION}"

# Targets in the same order they appear in the formula.
TARGETS="aarch64-apple-darwin x86_64-apple-darwin aarch64-unknown-linux-gnu x86_64-unknown-linux-gnu"

sha256_of() {
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$1" | awk '{print $1}'
  else
    shasum -a 256 "$1" | awk '{print $1}'
  fi
}

# Replace the sha256 line that immediately follows the url line for a target.
update_sha() {
  local target="$1" sha="$2"
  awk -v target="$target" -v sha="$sha" '
    {
      if (index($0, "aegis-" target "-v") > 0) { saw = 1 }
      if (saw && $0 ~ /sha256 "/) {
        sub(/sha256 "[0-9a-f]+"/, "sha256 \"" sha "\"")
        saw = 0
      }
      print
    }
  ' "$FORMULA" > "$FORMULA.tmp" && mv "$FORMULA.tmp" "$FORMULA"
}

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

# Bump the version line.
sed -i.bak -E "s/^([[:space:]]*version )\"[^\"]+\"/\1\"${VERSION}\"/" "$FORMULA"
rm -f "$FORMULA.bak"

for t in $TARGETS; do
  f="aegis-${t}-v${VERSION}.tgz"
  url="${BASE}/${f}"
  echo "Downloading ${url}" >&2
  if ! curl -fsSL "$url" -o "$tmp/$f"; then
    echo "ERROR: failed to download ${url} (does the release exist?)" >&2
    exit 1
  fi
  sha="$(sha256_of "$tmp/$f")"
  echo "  ${t}: ${sha}" >&2
  update_sha "$t" "$sha"
done

echo "Updated ${FORMULA} to version ${VERSION}" >&2
