#!/bin/sh
# PreToolUse guard for non-negotiable Jarn safety invariants.
# Requirements: POSIX sh, git, grep, sed, tr (no jq or python needed).
# Contract: reads hook JSON on stdin, prints decision JSON on stdout.
# Prints {} (no opinion) when no invariant is violated so normal permission flow still applies.

payload=$(tr '\n' ' ')

field() {
  # Extract the first string value for a JSON key from the flattened payload.
  printf '%s' "$payload" | sed -nE "s/.*\"$1\" *: *\"(([^\"\\\\]|\\\\.)*)\".*/\\1/p" | head -n 1
}

deny() {
  printf '{"decision":"deny","reason":"%s"}\n' "$1"
  exit 0
}

tool=$(field name)
target=$(field TargetFile)
command_line=$(field CommandLine)
if [ -z "$target" ]; then target=$(field AbsolutePath); fi

repo_root=$(git -C "$(dirname "$0")" rev-parse --show-toplevel 2>/dev/null)
branch=$(git -C "$(dirname "$0")" branch --show-current 2>/dev/null)

in_repo() {
  case "$1" in "$repo_root"/*) return 0 ;; *) return 1 ;; esac
}

case "$tool" in
  write_to_file | replace_file_content | multi_replace_file_content)
    # Step 0 Branch Isolation: no codebase edits on main.
    if [ "$branch" = "main" ] && in_repo "$target"; then
      deny "Step 0 violated: on main. Run git checkout -b <type>/<slug> before editing."
    fi
    # Root Pollution: scratch artifacts belong in .scratch/<task-slug>/tmp/.
    if [ "$(dirname "$target")" = "$repo_root" ]; then
      case "$(basename "$target")" in
        tmp* | temp* | scratch* | repro* | mock* | debug* | *.log)
          deny "Root pollution: write transient files under .scratch/<task-slug>/tmp/."
          ;;
      esac
    fi
    ;;
esac

case "$tool" in
  write_to_file | replace_file_content | multi_replace_file_content | view_file)
    # Credential Exposure: never touch real env files (templates are fine).
    case "$(basename "$target")" in
      .env.example | .env.sample | .env.template) ;;
      .env | .env.*) deny "Credential exposure: .env files are off limits." ;;
    esac
    ;;
esac

if [ "$tool" = "run_command" ]; then
  # Git History Rewrite: no force pushes.
  if printf '%s' "$command_line" | grep -Eq 'git +push.*( --force| -f( |$)|--force-with-lease)'; then
    deny "Force push is prohibited without explicit human confirmation."
  fi
  # Credential Exposure: no reading env files from the shell.
  if printf '%s' "$command_line" | grep -Eq '(cat|less|more|head|tail|source|grep|cp) +[^|;&]*\.env( |$)'; then
    deny "Credential exposure: .env files are off limits."
  fi
  # Step 0 Branch Isolation: no commits on main, except the release ceremony.
  if [ "$branch" = "main" ] && printf '%s' "$command_line" | grep -Eq 'git +commit'; then
    if ! printf '%s' "$command_line" | grep -Eq 'chore\(release\)'; then
      deny "Step 0 violated: commits on main are prohibited (except chore(release))."
    fi
  fi
fi

printf '{"decision":"ask","reason":"No Jarn invariant violated; defer to normal permission flow."}\n'
