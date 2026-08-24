#!/usr/bin/env bash
set -euo pipefail
REGISTRY="${1:-REPLACE_REGISTRY}"
TAG="${2:-latest}"

[[ "$REGISTRY" != "REPLACE_REGISTRY" ]] || { echo "Set a registry" >&2; exit 2; }

TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT

for file in k8s/*.yaml; do
  sed -e "s|REPLACE_REGISTRY|${REGISTRY}|g" -e "s|IMAGE_TAG|${TAG}|g" "$file" > "$TMPDIR/$(basename "$file")"
done

kubectl apply -f "$TMPDIR/"
kubectl rollout status deployment/service-a --timeout=120s
kubectl rollout status deployment/service-b --timeout=120s
kubectl rollout status deployment/frontend --timeout=120s
