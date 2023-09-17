#!/usr/bin/env bash

#-----------------------------------------------------------------------------
# centeredtext.sh
# Display centered text in the screen in reverse video
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# Script Functions
#-----------------------------------------------------------------------------

function wait_for_key() {
	local STORAGE_VAR
	STORAGE_VAR="$1"
	read -p "" "${STORAGE_VAR?}"
}

function clear_screen() {
	tput clear
}

function move_cursor_to_coordinates() {
	local X_POS
	local Y_POS

	X_POS=$1
	Y_POS=$2

	tput cup $X_POS $Y_POS
}

function set_reverse_mode() {
	# set reverse video mode
	tput rev
}

function set_bold_text() {
	tput bold
}

function set_colors() {
	tput setaf 6
}

function hide_cursor() {
	tput civis
}

function show_cursor() {
	tput cnorm
}

function reset_text() {
	tput sgr0
}

function reset_cursor() {
	tput rc
}

function reset_screen_text_and_cursor_cleanup() {
	clear_screen
	reset_text
	reset_cursor
}

function print_centered_fullscreen_message() {

	local _COLUMNS
	local _LINES
	local _MESSAGE
	local _USER_KEY_ENTRY
	local x
	local y

	# Find out current screen width and hight
	_COLUMNS=$(tput cols)
	_LINES=$(tput lines)

	# Set default message if $1 input not provided
	_MESSAGE="${1:-Centered Full Screen Message}"

	# Calculate x and y coordinates in order to display centered text
	x=$((_LINES / 2))
	y=$(((_COLUMNS - ${#_MESSAGE}) / 2))

	
	clear_screen

	hide_cursor

	move_cursor_to_coordinates $x $y
	
	set_reverse_mode
	
	# display text stored in $_MESSAGE
	echo "${_MESSAGE}"
	
	wait_for_key _USER_KEY_ENTRY

	reset_screen_text_and_cursor_cleanup

	show_cursor
	
}

#-----------------------------------------------------------------------------
# Script Main Function
#-----------------------------------------------------------------------------

main() {
	print_centered_fullscreen_message "$@"
}

#-----------------------------------------------------------------------------
# Script Runtime
#-----------------------------------------------------------------------------

main "$@"

#==========================================================
# SCRIPT END
#==========================================================

 