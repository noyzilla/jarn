#!/bin/sh
# Update all Jarn standards and skills from GitHub upstream repository.
# Pure basic shell (POSIX sh) with zero external runtime dependencies.
# Usage:
#   ./.agents/scripts/jarn-update.sh
#   curl -fsSL https://raw.githubusercontent.com/noyzilla/jarn/main/.agents/scripts/jarn-update.sh | sh

set -eu

REPO="${JARN_REPO:-noyzilla/jarn}"
BRANCH="${JARN_BRANCH:-main}"
TARBALL_URL="https://github.com/${REPO}/archive/refs/heads/${BRANCH}.tar.gz"
AGENTS_DIR=".agents"

echo "Updating Jarn standards and skills from ${REPO}@${BRANCH}..."

TMP_DIR=$(mktemp -d)
trap 'rm -rf "${TMP_DIR}"' EXIT INT TERM

curl -fsSL "${TARBALL_URL}" | tar -xz -C "${TMP_DIR}" --strip-components=1

# 1. Synchronize Jarn core rules
if [ -d "${TMP_DIR}/.agents/rules/jarn" ]; then
  mkdir -p "${AGENTS_DIR}/rules/jarn"
  cp -R "${TMP_DIR}/.agents/rules/jarn/." "${AGENTS_DIR}/rules/jarn/"
  echo "  - Jarn rules updated in ${AGENTS_DIR}/rules/jarn/"
fi

# 2. Synchronize Jarn skills (matching jarn-*)
for skill_dir in "${TMP_DIR}/${AGENTS_DIR}/skills/jarn-"*; do
  if [ -d "${skill_dir}" ]; then
    skill_name="${skill_dir##*/}"
    mkdir -p "${AGENTS_DIR}/skills/${skill_name}"
    cp -R "${skill_dir}/." "${AGENTS_DIR}/skills/${skill_name}/"
    echo "  - Jarn skill updated: ${AGENTS_DIR}/skills/${skill_name}"
  fi
done

# 3. Synchronize this updater script itself
if [ -f "${TMP_DIR}/.agents/scripts/jarn-update.sh" ]; then
  mkdir -p "${AGENTS_DIR}/scripts"
  cp "${TMP_DIR}/.agents/scripts/jarn-update.sh" "${AGENTS_DIR}/scripts/jarn-update.sh"
  chmod +x "${AGENTS_DIR}/scripts/jarn-update.sh" 2>/dev/null || true
  echo "  - Jarn updater updated in ${AGENTS_DIR}/scripts/jarn-update.sh"
fi

echo "Update complete. All Jarn components are up to date."
