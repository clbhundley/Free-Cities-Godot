extends Node

var gui:Node
var clock:Node
var slaves:Node
var arcology:Node

var queue_save

var default_font = preload('res://Fonts/Rubik-Light.tres')

func reset():
	randomize()
	money = abs(math.gaussian(20000,2000))
	time.second = randi()%60
	time.minute = randi()%60
	time.hour = randi()%24
	time.day = randi()%7
	time.week = 0
	time.quarter = 0
	time.year = 2119
	time.total_weeks = 1

func _ready():
	randomize()
	bg_color = ProjectSettings.get('rendering/environment/default_clear_color')
	data.create_directory('user://Data')
	data.check_config()
	data.set_autosave()
	display.check_display()

func is_ready(): # called from GUI scene - needs refinement
	if queue_save:
		queue_save = false
		data.save_game(data.save_slot)
		gui.get_node("Pause Menu/Saves").refresh()

var money = 0
func update_money(value):
	money += value
	var label = gui.get_node("Money/Capital")
	label.set_text("¤" + str(money))
	if sign(money) == -1:
		label.set_self_modulate("ff0000")
	else:
		label.set_self_modulate("ffffff")

var bg_color
const BG_COLOR_DEFAULT = '204659'
const BG_COLOR_DEEP = '323150'
const BG_COLOR_PLUMB = '403150'
const BG_COLOR_ABYSS = '001013'
func set_bg_color(new_color):
	var tween = get_tree().get_root().get_node("Game/GUI/Tween")
	tween.interpolate_method(
	VisualServer,
	'set_default_clear_color',
	bg_color,
	Color(new_color),
	0.3,
	Tween.TRANS_QUART,
	Tween.EASE_OUT)
	tween.start()
	bg_color = Color(new_color)

func popup_is_visible():
	for popup in get_tree().get_nodes_in_group("Popups"):
		if popup.is_visible_in_tree():
			return true

const DESKTOP_QUIT = MainLoop.NOTIFICATION_WM_QUIT_REQUEST
const ANDROID_QUIT = MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST
var limiter = false #prevents malfunction due to multiple quit events in Windows
func _notification(event):
	if limiter:
		return
	if event == DESKTOP_QUIT or event == ANDROID_QUIT:
		if get_tree().get_current_scene().get_name() == "Main Menu":
			return
		limiter = true
		data.save_game(data.save_slot)
		for popup in get_tree().get_nodes_in_group("Popups"):
			if popup.is_visible_in_tree():
				popup.hide()

var msec_start
func stopwatch(activate):
	if activate:
		msec_start = OS.get_ticks_msec()
	else:
		print(float(OS.get_ticks_msec()-msec_start)/1000," seconds")
