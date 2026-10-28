#!/usr/bin/env bash
# Verify that a release tag is safe to publish.
#
# Usage: verify-release.sh <tag> <notes-file>
#   RELEASE_BASE_REF  branch the tag must be reachable from (default: main)
#
# Exit 0 writes the changelog section for the tag's version to <notes-file>.
# Exit 1 writes "::error::<message>" to stderr.
set -euo pipefail

if [ "$#" -ne 2 ]; then
  echo "usage: verify-release.sh <tag> <notes-file>" >&2
  exit 2
fi

tag=$1
notes=$2
base_ref=${RELEASE_BASE_REF:-main}

fail() {
  echo "::error::$*" >&2
  exit 1
}

if ! printf '%s' "$tag" |
  grep -Eq '^v(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)$'; then
  fail "Tag '$tag' is not vMAJOR.MINOR.PATCH"
fi

root=$(git rev-parse --show-toplevel)
cd "$root"

manifest_version=$(jq -r '.version' "$root/.skills.json")
tag_version=${tag#v}
if [ "$tag_version" != "$manifest_version" ]; then
  fail "Tag $tag does not match .skills.json version $manifest_version"
fi

if ! git rev-parse --verify --quiet "origin/$base_ref" >/dev/null; then
  fail "Base ref origin/$base_ref not found"
fi
if ! git merge-base --is-ancestor HEAD "origin/$base_ref"; then
  fail "Tag commit $(git rev-parse --short HEAD) is not on $base_ref"
fi

awk -v v="$tag_version" '
  index($0, "## [" v "]") == 1 { found = 1; next }
  found && (index($0, "## [") == 1 || $0 == "---") { exit }
  found { print }
' "$root/CHANGELOG.md" > "$notes"

sed -i '/./,$!d' "$notes"

if ! grep -q '[^[:space:]]' "$notes"; then
  fail "CHANGELOG.md has no entry for $tag_version"
fi
