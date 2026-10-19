#!/usr/bin/env bash
# Fails unless every package's version matches VERSION (and the tag, when one
# is given), so one release always publishes the same version everywhere.
set -euo pipefail
cd "$(dirname "$0")/.."

want="$(tr -d '[:space:]' < VERSION)"
tag="${1:-}"
status=0

if [[ -n "$tag" && "$tag" != "v$want" ]]; then
  echo "tag $tag does not match VERSION $want" >&2
  status=1
fi

npm_version="$(node -p 'require("./npm/package.json").version')"
if [[ "$npm_version" != "$want" ]]; then
  echo "npm/package.json version $npm_version != $want" >&2
  status=1
fi

for project in pypi/*/; do
  got="$(sed -n 's/^version = "\(.*\)"$/\1/p' "$project/pyproject.toml")"
  if [[ "$got" != "$want" ]]; then
    echo "$project/pyproject.toml version $got != $want" >&2
    status=1
  fi
done

[[ $status -eq 0 ]] && echo "all packages at $want"
exit $status
