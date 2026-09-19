#!/bin/sh
# Initialize or adopt the Jarn AI-Driven Software Development Blueprint.
# Pure basic shell (POSIX sh) with zero external runtime dependencies.
# Usage:
#   Public / HTTP (Default):
#     curl -fsSL https://raw.githubusercontent.com/noyzilla/jarn/main/scripts/jarn.sh | sh
#     curl -fsSL https://raw.githubusercontent.com/noyzilla/jarn/main/scripts/jarn.sh | sh -s -- <project-directory>
#   Private / GitHub CLI (gh):
#     gh api repos/noyzilla/jarn/contents/scripts/jarn.sh -H "Accept: application/vnd.github.raw+json" | sh -s -- gh
#     gh api repos/noyzilla/jarn/contents/scripts/jarn.sh -H "Accept: application/vnd.github.raw+json" | sh -s -- gh <project-directory>

set -eu

REPO="${JARN_REPO:-noyzilla/jarn}"
VERSION="${JARN_VERSION:-latest}"

METHOD="${JARN_METHOD:-curl}"
TARGET_DIR="."

if [ "${1:-}" = "gh" ] || [ "${1:-}" = "--gh" ]; then
  METHOD="gh"
  TARGET_DIR="${2:-.}"
elif [ -n "${1:-}" ]; then
  TARGET_DIR="${1}"
fi

if [ "${METHOD}" = "curl" ]; then
  HTTP_STATUS=$(curl -o /dev/null -s -w "%{http_code}" "https://api.github.com/repos/${REPO}" || echo "000")
  if [ "${HTTP_STATUS}" != "200" ] && command -v gh >/dev/null 2>&1; then
    METHOD="gh"
  fi
fi

if [ "${VERSION}" = "latest" ]; then
  if [ "${METHOD}" = "gh" ]; then
    VERSION=$(gh api "repos/${REPO}/releases/latest" -q '.tag_name' 2>/dev/null || echo "")
  else
    VERSION=$(curl -s "https://api.github.com/repos/${REPO}/releases/latest" | grep '"tag_name":' | head -n 1 | sed -E 's/.*"([^"]+)".*/\1/' || true)
  fi
  
  if [ -z "${VERSION}" ] || [ "${VERSION}" = "null" ]; then
    echo "Error: Could not resolve latest tag for ${REPO}." >&2
    echo "  Ensure that the repository has at least one Git tag (release)." >&2
    exit 1
  else
    echo "Resolved latest tag: ${VERSION}"
  fi
fi

TARBALL_URL="https://github.com/${REPO}/tarball/${VERSION}"

mkdir -p "${TARGET_DIR}"
TARGET_ABS_DIR=$(cd "${TARGET_DIR}" && pwd)

echo "Initializing Jarn blueprint from ${REPO}@${VERSION} into ${TARGET_DIR}..."

TMP_DIR=$(mktemp -d)
RECORD_DIR=$(mktemp -d)
trap 'rm -rf "${TMP_DIR}" "${RECORD_DIR}"' EXIT INT TERM

if [ "${METHOD}" = "gh" ]; then
  if ! command -v gh >/dev/null 2>&1; then
    echo "Error: GitHub CLI 'gh' is required for gh mode but is not installed or not in PATH." >&2
    exit 1
  fi
  echo "Downloading Jarn blueprint archive via GitHub CLI (gh api)..."
  gh api "repos/${REPO}/tarball/${VERSION}" | tar -xz -C "${TMP_DIR}" --strip-components 1
else
  echo "Downloading Jarn blueprint archive via HTTP (curl)..."
  curl -fsSL "${TARBALL_URL}" | tar -xz -C "${TMP_DIR}" --strip-components 1 || true
fi

if [ ! -d "${TMP_DIR}/.agents" ]; then
  echo "Error: Failed to download Jarn blueprint archive from '${REPO}'." >&2
  echo "  If '${REPO}' is a private repository, run with GitHub CLI (gh) mode:" >&2
  echo "    gh api repos/${REPO}/contents/scripts/jarn.sh -H \"Accept: application/vnd.github.raw+json\" | sh -s -- gh" >&2
  exit 1
fi

# Synchronize core .agents/ directory (rules, skills)
mkdir -p "${TARGET_ABS_DIR}/.agents/rules"
for rule_file in "${TMP_DIR}/.agents/rules/jarn-"*; do
  if [ -f "${rule_file}" ]; then
    cp "${rule_file}" "${TARGET_ABS_DIR}/.agents/rules/"
  fi
done

for skill_dir in "${TMP_DIR}/.agents/skills/jarn-"*; do
  if [ -d "${skill_dir}" ]; then
    skill_name="${skill_dir##*/}"
    mkdir -p "${TARGET_ABS_DIR}/.agents/skills/${skill_name}"
    cp -R "${skill_dir}/." "${TARGET_ABS_DIR}/.agents/skills/${skill_name}/"
  fi
done

# Synchronize Shadow Templates
SHADOW_DIR="${TARGET_ABS_DIR}/.agents/.jarn-templates"
mkdir -p "${SHADOW_DIR}"

if [ -d "${TMP_DIR}/templates" ]; then
  # Clean existing shadow templates before syncing new ones to avoid stale files
  rm -rf "${SHADOW_DIR}"/* "${SHADOW_DIR}"/.[!.]* 2>/dev/null || true
  cp -R "${TMP_DIR}/templates/." "${SHADOW_DIR}/"
fi

# Ensure .agents/.gitignore ignores the shadow templates
GITIGNORE_FILE="${TARGET_ABS_DIR}/.agents/.gitignore"
if [ ! -f "${GITIGNORE_FILE}" ] || ! grep -q "^.jarn-templates/" "${GITIGNORE_FILE}"; then
  echo ".jarn-templates/" >> "${GITIGNORE_FILE}"
fi

# Process template files (Zero-Conflict Seeding)
CREATED_RECORD="${RECORD_DIR}/created.list"
touch "${CREATED_RECORD}"

if [ -d "${SHADOW_DIR}" ]; then
  (
    cd "${SHADOW_DIR}"
    find . -type f
  ) | while IFS= read -r file_path; do
    rel_path="${file_path#./}"
    dest_file="${TARGET_ABS_DIR}/${rel_path}"
    dest_dir=$(dirname "${dest_file}")
    
    if [ ! -f "${dest_file}" ]; then
      mkdir -p "${dest_dir}"
      cp "${SHADOW_DIR}/${rel_path}" "${dest_file}"
      echo "${rel_path}" >> "${CREATED_RECORD}"
    fi
  done
fi

# Optional Git initialization if target is not a Git repo
if command -v git >/dev/null 2>&1 && [ ! -d "${TARGET_ABS_DIR}/.git" ]; then
  (cd "${TARGET_ABS_DIR}" && git init -q)
  echo "Initialized empty Git repository in ${TARGET_ABS_DIR}/.git/"
fi

# Output summary and AI directive
echo ""
echo "======================================================================"
echo "  Jarn Blueprint Initialization/Update Summary"
echo "======================================================================"
echo "  Core standards synchronized: .agents/ (rules, skills)"
echo "  Shadow templates stored in:  .agents/.jarn-templates/"

if [ -s "${CREATED_RECORD}" ]; then
  echo ""
  echo "  New blueprint files seeded (because they did not exist):"
  while IFS= read -r item; do
    echo "    + ${item}"
  done < "${CREATED_RECORD}"
fi

echo ""
echo "----------------------------------------------------------------------"
echo "🤖 AI ADOPTION DIRECTIVE (Copy & paste to your AI coding agent):"
echo "----------------------------------------------------------------------"
echo "Please compare the files in '.agents/.jarn-templates/' with the root project files."
echo "Carefully merge any missing standards, architectural updates, or new configurations"
echo "into the project files without disrupting existing domain logic or active commands."
echo "Do not run commands that overwrite data unprompted. Present a merge plan first."
echo "----------------------------------------------------------------------"

# Record version
echo "${VERSION}" > "${TARGET_ABS_DIR}/.agents/.jarn-version"

echo ""
