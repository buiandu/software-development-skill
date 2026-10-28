#!/usr/bin/env bash
# Create or update the GitHub Release for a verified tag.
#
# Usage: publish-release.sh <tag> <notes-file>
# Requires the `gh` CLI and GH_TOKEN (provided by the workflow).
set -euo pipefail

if [ "$#" -ne 2 ]; then
  echo "usage: publish-release.sh <tag> <notes-file>" >&2
  exit 2
fi

tag=$1
notes=$2

probe_err=$(mktemp)
trap 'rm -f "$probe_err"' EXIT

if gh release view "$tag" >/dev/null 2>"$probe_err"; then
  gh release edit "$tag" --title "$tag" --notes-file "$notes"
else
  if ! grep -qi 'not found' "$probe_err"; then
    cat "$probe_err" >&2
    echo "::error::Cannot determine whether release $tag exists" >&2
    exit 1
  fi
  gh release create "$tag" --verify-tag --title "$tag" --notes-file "$notes"
fi
