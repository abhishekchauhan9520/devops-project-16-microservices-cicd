#!/usr/bin/env bash
set -euo pipefail
REGISTRY="${1:-REPLACE_REGISTRY}"
TAG="${2:-latest}"

[[ "$REGISTRY" != "REPLACE_REGISTRY" ]] || { echo "Set a registry, e.g. ghcr.io/OWNER/REPO" >&2; exit 2; }

for service in service-a service-b frontend; do
  image="${REGISTRY}/${service}:${TAG}"
  echo "Building ${image}"
  docker build -t "$image" "./${service}"
  docker push "$image"
done
