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

if gh release view "$tag" >/dev/null 2>&1; then
  gh release edit "$tag" --title "$tag" --notes-file "$notes"
else
  gh release create "$tag" --title "$tag" --notes-file "$notes"
fi
