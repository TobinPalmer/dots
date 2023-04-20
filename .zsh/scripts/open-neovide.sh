#!/bin/bash
SERVICE="Neovide"
if pgrep -f "$SERVICE" >/dev/null
then
	open /Applications/Neovide.app/
else
	export LUNARVIM_RUNTIME_DIR="${LUNARVIM_RUNTIME_DIR:-"$HOME/.local/share/lunarvim"}"
	export LUNARVIM_CONFIG_DIR="${LUNARVIM_CONFIG_DIR:-"$HOME/.config/lvim"}"
	export LUNARVIM_CACHE_DIR="${LUNARVIM_CACHE_DIR:-"$HOME/.cache/lvim"}"

	cd $HOME

	exec /opt/homebrew/bin/neovide --multigrid -- -u "$LUNARVIM_RUNTIME_DIR/lvim/init.lua" .
fi
