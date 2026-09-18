#!/bin/sh
# Adopt the Jarn AI-Driven Software Development Blueprint into an existing project.
# Pure basic shell (POSIX sh) with zero external runtime dependencies.
# Usage:
#   Public / HTTP (Default):
#     curl -fsSL https://raw.githubusercontent.com/noyzilla/jarn/main/scripts/adopt.sh | sh
#     curl -fsSL https://raw.githubusercontent.com/noyzilla/jarn/main/scripts/adopt.sh | sh -s -- <project-directory>
#   Private / GitHub CLI (gh):
#     gh api repos/noyzilla/jarn/contents/scripts/adopt.sh -H "Accept: application/vnd.github.raw+json" | sh -s -- gh
#     gh api repos/noyzilla/jarn/contents/scripts/adopt.sh -H "Accept: application/vnd.github.raw+json" | sh -s -- gh <project-directory>

set -eu

REPO="${JARN_REPO:-noyzilla/jarn}"
BRANCH="${JARN_BRANCH:-latest}"
SUFFIX="pending-merge"

METHOD="${JARN_METHOD:-curl}"
TARGET_DIR="."

if [ "${1:-}" = "gh" ] || [ "${1:-}" = "--gh" ]; then
  METHOD="gh"
  TARGET_DIR="${2:-.}"
elif [ -n "${1:-}" ]; then
  TARGET_DIR="${1}"
fi

if [ "${BRANCH}" = "latest" ]; then
  if [ "${METHOD}" = "gh" ]; then
    BRANCH=$(gh api "repos/${REPO}/tags" -q '.[0].name' 2>/dev/null || echo "")
  else
    BRANCH=$(curl -s "https://api.github.com/repos/${REPO}/tags" | grep '"name":' | head -n 1 | sed -E 's/.*"([^"]+)".*/\1/' || true)
  fi
  
  if [ -z "${BRANCH}" ] || [ "${BRANCH}" = "null" ]; then
    echo "Warning: Could not resolve latest tag. Falling back to 'main'." >&2
    BRANCH="main"
  else
    echo "Resolved latest tag: ${BRANCH}"
  fi
fi

TARBALL_URL="https://github.com/${REPO}/tarball/${BRANCH}"

mkdir -p "${TARGET_DIR}"
TARGET_ABS_DIR=$(cd "${TARGET_DIR}" && pwd)

echo "Adopting jarn blueprint from ${REPO}@${BRANCH} into ${TARGET_DIR}..."

TMP_DIR=$(mktemp -d)
RECORD_DIR=$(mktemp -d)
trap 'rm -rf "${TMP_DIR}" "${RECORD_DIR}"' EXIT INT TERM

if [ -n "${JARN_LOCAL_DIR:-}" ] && [ -d "${JARN_LOCAL_DIR}" ]; then
  echo "Copying blueprint from local source: ${JARN_LOCAL_DIR}..."
  cp -R "${JARN_LOCAL_DIR}/." "${TMP_DIR}/"
elif [ "${METHOD}" = "gh" ]; then
  if ! command -v gh >/dev/null 2>&1; then
    echo "Error: GitHub CLI 'gh' is required for gh mode but is not installed or not in PATH." >&2
    exit 1
  fi
  echo "Downloading blueprint archive via GitHub CLI (gh api)..."
  gh api "repos/${REPO}/tarball/${BRANCH}" | tar -xz -C "${TMP_DIR}" --strip-components 1
else
  echo "Downloading blueprint archive via HTTP (curl)..."
  curl -fsSL "${TARBALL_URL}" | tar -xz -C "${TMP_DIR}" --strip-components 1 || true
fi

if [ ! -f "${TMP_DIR}/AGENTS.md" ]; then
  echo "Error: Failed to download Jarn blueprint archive from '${REPO}'." >&2
  echo "  If '${REPO}' is a private repository, run with GitHub CLI (gh) mode:" >&2
  echo "    gh api repos/${REPO}/contents/scripts/adopt.sh -H \"Accept: application/vnd.github.raw+json\" | sh -s -- gh" >&2
  exit 1
fi

# 1. Synchronize core .agents/ directory (rules, skills, updater)
if [ -d "${TMP_DIR}/.agents/rules/jarn" ]; then
  mkdir -p "${TARGET_ABS_DIR}/.agents/rules/jarn"
  cp -R "${TMP_DIR}/.agents/rules/jarn/." "${TARGET_ABS_DIR}/.agents/rules/jarn/"
fi

for skill_dir in "${TMP_DIR}/.agents/skills/jarn-"*; do
  if [ -d "${skill_dir}" ]; then
    skill_name="${skill_dir##*/}"
    mkdir -p "${TARGET_ABS_DIR}/.agents/skills/${skill_name}"
    cp -R "${skill_dir}/." "${TARGET_ABS_DIR}/.agents/skills/${skill_name}/"
  fi
done

if [ -f "${TMP_DIR}/.agents/scripts/jarn-update.sh" ]; then
  mkdir -p "${TARGET_ABS_DIR}/.agents/scripts"
  cp "${TMP_DIR}/.agents/scripts/jarn-update.sh" "${TARGET_ABS_DIR}/.agents/scripts/jarn-update.sh"
  chmod +x "${TARGET_ABS_DIR}/.agents/scripts/jarn-update.sh" 2>/dev/null || true
fi

# 2. Process template files with non-destructive pending-merge staging
CREATED_RECORD="${RECORD_DIR}/created.list"
PENDING_RECORD="${RECORD_DIR}/pending.list"
touch "${CREATED_RECORD}" "${PENDING_RECORD}"

(
  cd "${TMP_DIR}"
  find . -type f
) | while IFS= read -r file_path; do
  rel_path="${file_path#./}"

  case "${rel_path}" in
    .agents/*) continue ;;
    scripts/*) continue ;;
    templates/*) continue ;;
    .git|.git/*|*/.git|*/.git/*) continue ;;
    .gemini|.gemini/*|*/.gemini|*/.gemini/*) continue ;;
    .DS_Store*|*/.DS_Store*) continue ;;
    *.list) continue ;;
    docs/decisions/0001-project-identity-jarn.md) continue ;;
  esac

  dest_file="${TARGET_ABS_DIR}/${rel_path}"
  dest_dir=$(dirname "${dest_file}")
  mkdir -p "${dest_dir}"

  if [ ! -f "${dest_file}" ]; then
    cp "${TMP_DIR}/${rel_path}" "${dest_file}"
    echo "${rel_path}" >> "${CREATED_RECORD}"
  elif ! cmp -s "${TMP_DIR}/${rel_path}" "${dest_file}"; then
    pending_file="${dest_file}.${SUFFIX}"
    cp "${TMP_DIR}/${rel_path}" "${pending_file}"
    echo "${rel_path}.${SUFFIX}" >> "${PENDING_RECORD}"
  fi
done

# 3. Optional Git initialization if target is not a Git repo
if command -v git >/dev/null 2>&1 && [ ! -d "${TARGET_ABS_DIR}/.git" ]; then
  (cd "${TARGET_ABS_DIR}" && git init -q)
  echo "Initialized empty Git repository in ${TARGET_ABS_DIR}/.git/"
fi

# 4. Output summary and AI directive
echo ""
echo "======================================================================"
echo "  Jarn Blueprint: Brownfield Adoption Summary"
echo "======================================================================"
echo "  Core standards synchronized: .agents/ (rules, skills, update script)"

if [ -s "${CREATED_RECORD}" ]; then
  echo ""
  echo "  New blueprint files created:"
  while IFS= read -r item; do
    echo "    + ${item}"
  done < "${CREATED_RECORD}"
fi

if [ -s "${PENDING_RECORD}" ]; then
  echo ""
  echo "  Files requiring AI merge (*.${SUFFIX}):"
  while IFS= read -r item; do
    echo "    ! ${item}"
  done < "${PENDING_RECORD}"
  echo ""
  echo "----------------------------------------------------------------------"
  echo "🤖 AI ADOPTION DIRECTIVE (Copy & paste to your AI coding agent):"
  echo "----------------------------------------------------------------------"
  echo "Scan for all files matching '*.${SUFFIX}'."
  echo "For each found file:"
  echo "1. Upgrade and intelligently merge its template structure, universal standards,"
  echo "   and invariants into the base file (by removing the '.${SUFFIX}' suffix),"
  echo "   strictly preserving existing project commands, configurations, and domain context."
  echo "2. Once successfully merged, delete the '*.${SUFFIX}' file."
  echo "3. Verify clean integration with git status and git diff."
  echo "----------------------------------------------------------------------"
else
  echo ""
  echo "All Jarn blueprint files were adopted with zero conflicts."
  echo "Next steps:"
  echo "  - Open AGENTS.md and configure project active commands."
  echo "  - Review CONTEXT.md and define domain context."
  echo "  - Update standards anytime via ./.agents/scripts/jarn-update.sh"
fi
echo ""
