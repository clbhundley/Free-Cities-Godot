extends "res://GUI/GUI Input.gd"

var mouse_over_gui = false

func _ready():
	activate_gui_mouse_detection()
	game.is_ready() #find a way to get rid of this
	game.update_money(0)
	game.set_bg_color(game.BG_COLOR_DEFAULT)
	#print("TEST TIMESTAMP ",time.get_timestamp())
	#print("TEST TIME ",time.get_reversed_time(0,0,0,0,1,0,0))
	#print("")
	#print("start to end ",time.get_total_time(example_time_1,example_time_2))
	#print("start to current ",time.get_total_time(example_time_1,current_time))
	#print("")
	#print(JSON.print(time.get_reversed_time(0,0,0,0,13)," "))


#FORWARD WEEK - 13
#FINAL WEEK - 0
#REMAINDER : 1
#WEEKS PREGNANT: 25
#current time: {day:4, hour:4, minute:40, quarter:0, second:58, week:0, year:2119}
#WEEKS FORWRARD: 12
#Kyung-Ja Gu Female {babies:1, conception:{day:0, hour:16, minute:11, quarter:3, second:3, week:1, year:2118}, due:{day:3, hour:6, minute:31, quarter:1, second:23, week:0, year:2119}, max_belly_size:56}
#TOTAL TIME {days:2, hours:14, minutes:20, quarters:1, seconds:20, weeks:12, years:0}



var example_time_1 = {
	"year":2118,
	"quarter":3,
	"week":1,
	"day":0,
	"hour":16,
	"minute":11,
	"second":3}

var current_time = {
	"day":4, 
	"hour":4, 
	"minute":40, 
	"quarter":0, 
	"second":58, 
	"week":0, 
	"year":2119}

var example_time_2 = {
	"year":2119,
	"quarter":1,
	"week":0,
	"day":3,
	"hour":6,
	"minute":31,
	"second":23}

func mouse_over_ui_panel():
	if mouse_over_side_panel() or mouse_over_time_panel():
		return true

func mouse_over_side_panel():
	if not $SidePanel.is_open and not $NaviChatBackground.is_visible_in_tree():
		return
	if get_global_mouse_position() <= $SidePanel.rect_size:
		return true

func mouse_over_time_panel():
	var time_panel = $Navigation/Time/TimePanel/MouseDetection
	if not time_panel.is_visible_in_tree():
		return
	var mouse_detection = [time_panel]
	for node in time_panel.get_children():
		mouse_detection.append(node)
	var current_mouse_pos = get_global_mouse_position()
	for node in mouse_detection:
		if current_mouse_pos.x >= node.rect_global_position.x:
			if current_mouse_pos.y >= node.rect_global_position.y:
				return true

func mouse_entered_gui():
	mouse_over_gui = true

func mouse_exited_gui():
	mouse_over_gui = false

func activate_gui_mouse_detection():
	var gui_intercept_mouse = []
	for node in get_tree().get_nodes_in_group("Intercept Mouse"):
		gui_intercept_mouse.append(node)
		for child in node.get_children():
			gui_intercept_mouse.append(child)
			for grandchild in child.get_children():
				gui_intercept_mouse.append(grandchild)
	for node in gui_intercept_mouse:
		if node.is_class("Control"):
			node.connect('mouse_entered',self,'mouse_entered_gui')
			node.connect('mouse_exited',self,'mouse_exited_gui')

func _on_Timer_timeout():
	return
	NAVI.read("res://GUI/intro.txt")
