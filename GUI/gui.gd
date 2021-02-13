extends Control

onready var timer = get_tree().get_root().get_node('Game/Clock')
onready var dialogue = get_node("AI Panel/Message")
onready var dialogue_text = get_node("AI Panel/Message/Text")
onready var calendar = get_node('Navigation/Time/Calendar')
onready var slider = get_node('Navigation/Time/HSlider')
onready var time_bg = get_node('Navigation/Time/Panel')
onready var feed = get_node('AI Panel/Feed')
onready var AI_panel = get_node('AI Panel')
#onready var finance = get_node('../Finance')

var mouse_over_gui = false

func _ready():
	gui_mouse_collision()
	game.is_ready() #find a way to get rid of this
	game.update_money(0)
	game.set_bg_color(game.BG_COLOR_DEFAULT)

func mouse_entered_gui():
	mouse_over_gui = true

func mouse_exited_gui():
	mouse_over_gui = false

func gui_mouse_collision():
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

func _on_Time_toggled(button_pressed):
	if button_pressed:
		slider.show()
		calendar.show()
		get_node('Navigation/Time/min_right').show()
		get_node('Navigation/Time/brackets').hide()
		get_node('Navigation/Time/Label Top').hide()
		get_node('Navigation/Time/Label Bot').hide()
		get_node('Navigation/Time/tab_right').set_self_modulate('782873c8')
		if AI_panel.is_visible_in_tree():
			feed.hide()
		else:
			time_bg.show()
	else:
		slider.hide()
		calendar.hide()
		time_bg.hide()
		get_node('Navigation/Time/min_right').hide()
		get_node('Navigation/Time/brackets').show()
		get_node('Navigation/Time/Label Top').show()
		get_node('Navigation/Time/Label Bot').show()
		get_node('Navigation/Time/tab_right').set_self_modulate('3c333a4b')
		if AI_panel.is_visible_in_tree():
			if not feed.is_visible_in_tree():
				feed.show()

func _on_AI_pressed(): #inactive
	return
	if AI_panel.is_visible_in_tree():
		AI_panel.hide()
		get_node("Dock/ActionButton").show()
		get_node('Dock/AI/min_left').hide()
		get_node('Dock/AI/ai_simple').show()
		dialogue.halt()
		get_node('Dock/AI/tab_left').set_self_modulate('3c333a4b')
#		if calendar.is_visible_in_tree():
#			feed.show()
#			if not time_bg.is_visible_in_tree():
#				time_bg.show()
	else:
		AI_panel.show()
		get_node("Dock/ActionButton").hide()
		get_node('Dock/AI/min_left').show()
		get_node('Dock/AI/ai_simple').hide()
		get_node('Dock/AI/tab_left').set_self_modulate('782873c8')
		if dialogue_text.get_total_character_count() < 45:
			dialogue_text.clear()
			dialogue.read('res://intro.txt')
		#if calendar.is_visible_in_tree():
			#feed.hide()
			
#			if time_bg.is_visible_in_tree():
#				time_bg.hide()
