#!/usr/bin/env bash

# Project:    Snow tmux
# Repository: https://github.com/mcchrish/snow-tmux
# License:    MIT
# References:
#   https://tmux.github.io

SNOW_TMUX_COLOR_THEME_FILE=src/snow.conf
SNOW_TMUX_VERSION=0.1.0
SNOW_TMUX_STATUS_CONTENT_FILE="src/snow-status-content.conf"
SNOW_TMUX_STATUS_CONTENT_NO_PATCHED_FONT_FILE="src/snow-status-content-no-patched-font.conf"
SNOW_TMUX_STATUS_CONTENT_OPTION="@snow_tmux_show_status_content"
SNOW_TMUX_NO_PATCHED_FONT_OPTION="@snow_tmux_no_patched_font"
_current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

__cleanup() {
  unset -v SNOW_TMUX_COLOR_THEME_FILE SNOW_TMUX_VERSION
  unset -v SNOW_TMUX_STATUS_CONTENT_FILE SNOW_TMUX_STATUS_CONTENT_NO_PATCHED_FONT_FILE
  unset -v SNOW_TMUX_STATUS_CONTENT_OPTION SNOW_TMUX_NO_PATCHED_FONT_OPTION
  unset -v _current_dir
  unset -f __load __cleanup
}

__load() {
  tmux source-file "$_current_dir/$SNOW_TMUX_COLOR_THEME_FILE"

  local status_content=$(tmux show-option -gqv "$SNOW_TMUX_STATUS_CONTENT_OPTION")
  local no_patched_font=$(tmux show-option -gqv "$SNOW_TMUX_NO_PATCHED_FONT_OPTION")

  if [ "$status_content" != "0" ]; then
    if [ "$no_patched_font" != "1" ]; then
      tmux source-file "$_current_dir/$SNOW_TMUX_STATUS_CONTENT_FILE"
    else
      tmux source-file "$_current_dir/$SNOW_TMUX_STATUS_CONTENT_NO_PATCHED_FONT_FILE"
    fi
  fi
}

__load
__cleanup
