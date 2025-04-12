# -e: exit on error
# -u: exit on unset variables
set -eu

log_color() {
  color_code="$1"
  shift

  printf "\033[${color_code}m%s\033[0m\n" "$*" >&2
}

log_red() {
  log_color "0;31" "$@"
}

log_blue() {
  log_color "0;34" "$@"
}

log_green() {
  log_color "0;32" "$@"
}

log_task() {
  log_blue "🔃" "$@"
}

log_error() {
  log_red "❌" "$@"
}

log_manual_action() {
  log_red "⚠️" "$@"
}

error() {
  log_error "$@"
  exit 1
}

sudo() {
  if [ "$(id -u)" -eq 0 ]; then
    "$@"
  else
    if ! command sudo --non-interactive true 2>/dev/null; then
      log_manual_action "Root privileges are required, please enter your password below"
      command sudo --validate
    fi
    command sudo "$@"
  fi
}

# TODO: if Debian-based
# TODO: charm/gum

log_task "Updating packages"
sudo apt update
sudo apt upgrade

log_task "Removing unneeded deps"
sudo apt autoremove

if ! command -v git >/dev/null 2>&1; then
  log_task "Installing git with APT"
  sudo apt env DEBIAN_FRONTEND=noninteractive apt install --yes --no-install-recommends git
else
  log_green "git is already installed"
fi

error "Implement more"
