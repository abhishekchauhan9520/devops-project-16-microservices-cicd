#!/usr/bin/env bash
set -euo pipefail
curl --fail --silent --show-error http://localhost:6000/health >/dev/null
