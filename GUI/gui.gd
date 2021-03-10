extends Control

var mouse_over_gui = false

func _ready():
	activate_gui_mouse_detection()
	game.is_ready() #find a way to get rid of this
	game.update_money(0)
	game.set_bg_color(game.BG_COLOR_DEFAULT)

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
	var mouse_pos = get_global_mouse_position()
	if mouse_pos.x >= time_panel.rect_global_position.x:
		if mouse_pos.y >= time_panel.rect_global_position.y:
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
	get_node("Dock/NaviChat").say("res://GUI/intro.txt")
