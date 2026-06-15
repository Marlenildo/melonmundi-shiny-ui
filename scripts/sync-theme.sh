#!/usr/bin/env bash
set -euo pipefail

# Sync the shared MelonMundi Shiny theme into sibling app repositories.
#
# Usage:
#   ./scripts/sync-theme.sh check all
#   ./scripts/sync-theme.sh sync agrofito
#   ./scripts/sync-theme.sh sync all
#   MELONMUNDI_ROOT=/path/to/melonmundi ./scripts/sync-theme.sh sync agrofruta

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
ECOSYSTEM_ROOT="${MELONMUNDI_ROOT:-$(cd "${REPO_ROOT}/.." && pwd)}"
SOURCE_THEME="${REPO_ROOT}/inst/assets/melonmundi-theme.css"

usage() {
  cat <<'EOF'
Usage:
  ./scripts/sync-theme.sh check <app|all>
  ./scripts/sync-theme.sh sync <app|all>
  ./scripts/sync-theme.sh list

Apps:
  agrofito
  agrofruta
  agrosolo
EOF
}

app_repo_dir() {
  case "$1" in
    agrofito) echo "${ECOSYSTEM_ROOT}/app-agrofito" ;;
    agrofruta) echo "${ECOSYSTEM_ROOT}/app-agrofruta" ;;
    agrosolo) echo "${ECOSYSTEM_ROOT}/app-agrosolo" ;;
    *)
      echo "ERROR: unknown app '$1'" >&2
      exit 2
      ;;
  esac
}

app_theme_path() {
  echo "$(app_repo_dir "$1")/www/melonmundi-theme.css"
}

ensure_prereqs() {
  if [[ ! -f "${SOURCE_THEME}" ]]; then
    echo "ERROR: source theme not found: ${SOURCE_THEME}" >&2
    exit 1
  fi
}

list_apps() {
  printf '%s\n' agrofito agrofruta agrosolo
}

check_one() {
  local app="$1"
  local repo_dir target_path
  repo_dir="$(app_repo_dir "${app}")"
  target_path="$(app_theme_path "${app}")"

  if [[ ! -d "${repo_dir}" ]]; then
    echo "[missing] ${app}: repo not found at ${repo_dir}"
    return 1
  fi

  if [[ ! -d "${repo_dir}/.git" ]]; then
    echo "[invalid] ${app}: not a git repo at ${repo_dir}"
    return 1
  fi

  if [[ ! -f "${target_path}" ]]; then
    echo "[outdated] ${app}: target theme missing (${target_path})"
    return 1
  fi

  if cmp -s "${SOURCE_THEME}" "${target_path}"; then
    echo "[ok] ${app}: theme is in sync"
    return 0
  fi

  echo "[outdated] ${app}: theme differs from shared source"
  return 1
}

sync_one() {
  local app="$1"
  local repo_dir target_path
  repo_dir="$(app_repo_dir "${app}")"
  target_path="$(app_theme_path "${app}")"

  if [[ ! -d "${repo_dir}" ]]; then
    echo "ERROR: repo not found for ${app}: ${repo_dir}" >&2
    exit 1
  fi

  if [[ ! -d "${repo_dir}/.git" ]]; then
    echo "ERROR: target is not a git repo for ${app}: ${repo_dir}" >&2
    exit 1
  fi

  mkdir -p "$(dirname "${target_path}")"

  if [[ -f "${target_path}" ]] && cmp -s "${SOURCE_THEME}" "${target_path}"; then
    echo "[skip] ${app}: already in sync"
    return 0
  fi

  cp "${SOURCE_THEME}" "${target_path}"
  echo "[sync] ${app}: updated ${target_path}"
  git -C "${repo_dir}" status --short -- "www/melonmundi-theme.css" || true
}

run_for_target() {
  local action="$1"
  local target="$2"
  local overall_status=0
  local app

  if [[ "${target}" == "all" ]]; then
    while IFS= read -r app; do
      if [[ "${action}" == "check" ]]; then
        check_one "${app}" || overall_status=1
      else
        sync_one "${app}"
      fi
    done < <(list_apps)
    return "${overall_status}"
  fi

  case "${action}" in
    check) check_one "${target}" ;;
    sync) sync_one "${target}" ;;
    *)
      echo "ERROR: invalid action '${action}'" >&2
      usage
      exit 2
      ;;
  esac
}

main() {
  local action="${1:-}"
  local target="${2:-}"

  ensure_prereqs

  case "${action}" in
    list)
      list_apps
      ;;
    check|sync)
      if [[ -z "${target}" ]]; then
        usage
        exit 2
      fi
      run_for_target "${action}" "${target}"
      ;;
    *)
      usage
      exit 2
      ;;
  esac
}

main "$@"
