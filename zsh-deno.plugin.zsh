#!/usr/bin/env zsh
# shellcheck disable=SC1090

# Exit if the 'deno' command can not be found
if ! (( $+commands[deno] )); then
    echo "WARNING: 'deno' command not found"
    return
fi

# Completions directory for `deno` commands
local COMPLETIONS_DIR="${0:A:h}/completions"

# Add completions to the FPATH
typeset -TUx FPATH fpath
fpath=("$COMPLETIONS_DIR" $fpath)

# If the completion file does not exist yet, then we need to autoload
# and bind it to `deno`. Otherwise, compinit will have already done that.
if [[ ! -f "$COMPLETIONS_DIR/_deno" ]]; then
    typeset -g -A _comps
    autoload -Uz _deno
    _comps[deno]=_deno
fi

# Generate and load completion in the background
deno completions zsh >| "$COMPLETIONS_DIR/_deno" &|
