extends Node

var queue_save

var default_font = preload('res://Fonts/Rubik-Light.tres')

var money = abs(math.gaussian(20000,2000))

const desktop_quit = MainLoop.NOTIFICATION_WM_QUIT_REQUEST
const android_quit = MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST
var limiter = false #prevents malfunction due to multiple quit requests from windows
func _notification(event):
	if limiter:
		return
	if event == desktop_quit or event == android_quit:
		if get_tree().get_current_scene().get_name() == "Main Menu":
			return
		limiter = true
		data.save_game(data.save_slot)

func _ready():
	randomize()
	data.check_dir('user://Data',"Data")
	data.check_config()
	data.set_autosave()
	display.check_display()

func is_ready():
	if queue_save:
		queue_save = false
		data.save_game(data.save_slot)
		for nodes in get_tree().get_root().get_node('Game/GUI/Pause Menu/Saves/Panel/Slots').get_children():
			nodes._ready()

func update_money(value):
	var label = get_tree().get_root().get_node('Game/GUI/Money/Capital')
	var player_data = 'user://Data/Slot %s/Player.json'%data.save_slot
	var file = File.new()
	money += value
	label.set_text("¤"+str(money))
	file.open(player_data,File.WRITE)
	file.store_line(to_json({money = money}))
	file.close()
