#!/usr/bin/env bash
set -euo pipefail
curl --fail --silent --show-error http://localhost:5000/health >/dev/null
