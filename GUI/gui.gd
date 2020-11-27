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

func _ready():
	game.is_ready() #find a way to get rid of this
	game.update_money(0)
	game.set_bg_color(game.BG_COLOR_DEFAULT)

#func message_resize():
	#$Panel.rect_size.y = $Text.rect_size.y + 7
	#print($Text.rect_size)

func _on_AI_pressed():
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

func _input(event):
	if event.is_action_pressed('speed'):
		if slider.value < 99:
			slider.value = 99
			if not calendar.is_visible_in_tree():
				get_node('Navigation/Time').animate_sml(get_node('Navigation/Time/rabbit'))
		else:
			slider.value = 0
			if not calendar.is_visible_in_tree():
				get_node('Navigation/Time').animate_sml(get_node('Navigation/Time/turtle'))
	elif event.is_action_pressed('pause'):
		if timer.is_paused():
			timer.set_paused(false)
			if not calendar.is_visible_in_tree():
				get_node('Navigation/Time').animate_sml(get_node('Navigation/Time/play'))
		else:
			timer.set_paused(true)
			if not calendar.is_visible_in_tree():
				get_node('Navigation/Time').animate_sml(get_node('Navigation/Time/pause'))
	elif event.is_action_pressed('ui_back'):
		if AI_panel.is_visible_in_tree():
			if get_node('Navigation/Time/Button').is_pressed():
				_on_Time_toggled(false)
				get_node('Navigation/Time/Button').set_pressed(false)
			else:
				_on_AI_pressed()
		elif calendar.is_visible_in_tree():
			_on_Time_toggled(false)
			get_node('Navigation/Time/Button').set_pressed(false)
