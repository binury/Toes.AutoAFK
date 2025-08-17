#    Copyright 2024 Robin Ury

#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at

#        http://www.apache.org/licenses/LICENSE-2.0

#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.

extends Node

const MOD_ID = "Toes.AutoAFK"
const AFK_TIMEOUT = 60000
const CYCLE_COOLDOWN = 1500

onready var Lure := get_node("/root/SulayreLure")
onready var	Players := get_node("/root/ToesSocks/Players")


var last_input_time := Time.get_ticks_msec()
var last_cycle_time := 0
var backup_title := ''


func _ready():
	Lure.add_content(MOD_ID, "title0", "mod://Resources/Cosmetics/title_afk.tres", [
		Lure.FLAGS.FREE_UNLOCK
	])
	Lure.add_content(MOD_ID, "title1", "mod://Resources/Cosmetics/title_afk1.tres")
	Lure.add_content(MOD_ID, "title2", "mod://Resources/Cosmetics/title_afk2.tres")
	Lure.add_content(MOD_ID, "title3", "mod://Resources/Cosmetics/title_afk3.tres")


func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		_restore_title()
		get_tree().quit() # default behavior

func _exit_tree() -> void:
	if not backup_title.empty(): _restore_title()


func _input(event: InputEvent) -> void:
	# Ignore any controllers plugged in
	# if event.as_text().find('Joypad'): return

	last_input_time = Time.get_ticks_msec()


func _process(delta: float) -> void:
	if not Players.in_game or not Players.local_player: return

	var NOW = Time.get_ticks_msec()
	var player_is_afk  = NOW - AFK_TIMEOUT >= last_input_time or (not OS.is_window_focused() and not OS.is_window_always_on_top())
	# var player_has_returned = NOW - AFK_TIMEOUT < last_input_time and not backup_title.empty()
	if player_is_afk:
		if backup_title.empty():
			_backup_title()
			PlayerData._send_notification("AFK")
			Players.set_cosmetic('title', MOD_ID + '.title0')
			last_cycle_time = NOW
			return
		if last_cycle_time + CYCLE_COOLDOWN < NOW:
			Players.set_cosmetic('title', MOD_ID + '.' + _get_next_title())
			last_cycle_time = NOW
			return
	elif not backup_title.empty():
		# PlayerData._send_notification("Welcome back!")
		_restore_title()
		return
	else:
		var current_title : String = Players.get_cosmetics().title
		if MOD_ID in current_title: Players.set_cosmetic('title', 'title_none')



func _backup_title():
	var cosmetics = Players.get_cosmetics()
	backup_title = cosmetics.title


func _restore_title():
	Players.set_cosmetic('title', backup_title)
	backup_title = ''


func _get_next_title() -> String:
	var titles = ['title0', 'title1', 'title2', 'title3']
	var current_title = Players.get_cosmetics().title
	var next_title = 'title' + str(int(current_title[-1]) + 1)
	if not next_title in titles: next_title = 'title0'
	return next_title
