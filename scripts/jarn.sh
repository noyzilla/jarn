#!/bin/sh
# Backward-compatibility redirect shim.
# scripts/jarn.sh has moved to install.sh at the repository root.
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/noyzilla/jarn/main/scripts/jarn.sh | sh
#   curl -fsSL https://raw.githubusercontent.com/noyzilla/jarn/main/scripts/jarn.sh | sh -s -- <target-directory>

set -eu

SCRIPT_DIR=$(cd "$(dirname "$0")/.." 2>/dev/null && pwd || echo "")

if [ -n "${SCRIPT_DIR}" ] && [ -f "${SCRIPT_DIR}/install.sh" ]; then
  exec sh "${SCRIPT_DIR}/install.sh" "$@"
fi

INSTALLER_URL="https://raw.githubusercontent.com/noyzilla/jarn/main/install.sh"
curl -fsSL "${INSTALLER_URL}" | sh -s -- "$@"
