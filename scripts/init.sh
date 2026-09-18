#!/bin/sh
# Initialize a new project with the complete Jarn AI-Driven Software Development Blueprint.
# Pure basic shell (POSIX sh) with zero external runtime dependencies.
# Usage:
#   Public / HTTP (Default):
#     curl -fsSL https://raw.githubusercontent.com/noyzilla/jarn/main/scripts/init.sh | sh
#     curl -fsSL https://raw.githubusercontent.com/noyzilla/jarn/main/scripts/init.sh | sh -s -- <project-directory>
#   Private / GitHub CLI (gh):
#     gh api repos/noyzilla/jarn/contents/scripts/init.sh -H "Accept: application/vnd.github.raw+json" | sh -s -- gh
#     gh api repos/noyzilla/jarn/contents/scripts/init.sh -H "Accept: application/vnd.github.raw+json" | sh -s -- gh <project-directory>

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

if [ "${VERSION}" = "latest" ]; then
  if [ "${METHOD}" = "gh" ]; then
    VERSION=$(gh api "repos/${REPO}/tags" -q '.[0].name' 2>/dev/null || echo "")
  else
    VERSION=$(curl -s "https://api.github.com/repos/${REPO}/tags" | grep '"name":' | head -n 1 | sed -E 's/.*"([^"]+)".*/\1/' || true)
  fi
  
  if [ -z "${VERSION}" ] || [ "${VERSION}" = "null" ]; then
    echo "Warning: Could not resolve latest tag. Falling back to 'main'." >&2
    VERSION="main"
  else
    echo "Resolved latest tag: ${VERSION}"
  fi
fi

TARBALL_URL="https://github.com/${REPO}/tarball/${VERSION}"

echo "Initializing new project from ${REPO}@${VERSION}..."

if [ "${TARGET_DIR}" != "." ]; then
  mkdir -p "${TARGET_DIR}"
  echo "Target directory: ${TARGET_DIR}"
fi

# Pre-flight safety check: prevent accidental clobbering of existing projects
if [ -d "${TARGET_DIR}" ]; then
  EXISTING_FILES=0
  for item in "${TARGET_DIR}"/* "${TARGET_DIR}"/.[!.]*; do
    if [ -e "${item}" ]; then
      base_item=$(basename "${item}")
      if [ "${base_item}" != ".git" ] && [ "${base_item}" != "*" ]; then
        EXISTING_FILES=1
        break
      fi
    fi
  done

  if [ "${EXISTING_FILES}" -eq 1 ] && [ "${FORCE:-0}" != "1" ]; then
    echo "Error: Target directory '${TARGET_DIR}' is not empty." >&2
    echo "  'scripts/init.sh' is intended only for empty/new projects." >&2
    echo "  To adopt jarn into an existing project safely without clobbering files, run:" >&2
    echo "    curl -fsSL https://raw.githubusercontent.com/${REPO}/${VERSION}/scripts/adopt.sh | sh" >&2
    echo "  (Or pass FORCE=1 to force overwrite)." >&2
    exit 1
  fi
fi

if [ "${METHOD}" = "gh" ]; then
  if ! command -v gh >/dev/null 2>&1; then
    echo "Error: GitHub CLI 'gh' is required for gh mode but is not installed or not in PATH." >&2
    exit 1
  fi
  echo "Downloading Jarn blueprint archive via GitHub CLI (gh api)..."
  gh api "repos/${REPO}/tarball/${VERSION}" | tar -xz -C "${TARGET_DIR}" --strip-components 1
else
  echo "Downloading Jarn blueprint archive via HTTP (curl)..."
  curl -fsSL "${TARBALL_URL}" | tar -xz -C "${TARGET_DIR}" --strip-components 1 || true
fi

if [ ! -f "${TARGET_DIR}/AGENTS.md" ]; then
  echo "Error: Failed to download Jarn blueprint archive from '${REPO}'." >&2
  echo "  If '${REPO}' is a private repository, run with GitHub CLI (gh) mode:" >&2
  echo "    gh api repos/${REPO}/contents/scripts/init.sh -H \"Accept: application/vnd.github.raw+json\" | sh -s -- gh" >&2
  exit 1
fi

cd "${TARGET_DIR}"

# Remove bootstrap scripts from initialized project
rm -f scripts/init.sh scripts/adopt.sh
rmdir scripts 2>/dev/null || true

# Remove Jarn-specific architectural decisions
rm -f docs/decisions/0001-project-identity-jarn.md

# Deploy clean templates
if [ -d "templates" ]; then
  cp templates/* . 2>/dev/null || true
  rm -rf templates
fi

if command -v git >/dev/null 2>&1 && [ ! -d ".git" ]; then
  git init -q
  echo "Initialized empty Git repository in $(pwd)/.git/"
fi

echo "Project initialized successfully."
echo "Next steps:"
echo "  - Open AGENTS.md and select your language preset (TypeScript, Java, Python, Go, Rust)."
echo "  - Update README.md and ARCHITECTURE.md with your project specifics."
echo "  - Manage Jarn standards and skills via .agents/scripts/jarn-update.sh"
echo "  - Verify with your project's native test and lint commands."
