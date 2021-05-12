extends Control

var is_active

func say(text,instant:=false):
	if time.fast_forward:
		yield(time,"ff_end")
		instant = true
	if is_active:
		new_message_text(text,instant)
	else:
		new_message_text(text,instant)
		$ChatLog.show()
		show_chatline()
		animate_message(
			'modulate',
			Color('00ffffff'),
			Color('ffffff'))
		animate_message(
			'rect_position:y',
			$ChatLog.get_child(0).rect_position.y + 10,
			$ChatLog.get_child(0).rect_position.y)
		for message in $ChatLog.get_children():
			message.hide()
		$ChatLog.get_child(0).show()

func read(file):
	if is_active:
		new_message(file)
	else:
		new_message(file)
		$ChatLog.show()
		show_chatline()
		animate_message(
			'modulate',
			Color('00ffffff'),
			Color('ffffff'))
		animate_message(
			'rect_position:y',
			$ChatLog.get_child(0).rect_position.y + 10,
			$ChatLog.get_child(0).rect_position.y)
		for message in $ChatLog.get_children():
			message.hide()
		$ChatLog.get_child(0).show()

func new_message(file):
	var new_message = $Message.duplicate()
	new_message.show()
	$ChatLog.add_child(new_message)
	$ChatLog.move_child(new_message,0)
	new_message.read(file)

func new_message_text(text,instant):
	var new_message = $Message.duplicate()
	new_message.show()
	$ChatLog.add_child(new_message)
	$ChatLog.move_child(new_message,0)
	new_message.dialogue(text,instant)

func remove_message(index):
	var selected_msg = $ChatLog.get_child(index)
	yield(get_tree(),"idle_frame")
	$ChatLog.remove_child(selected_msg)
	selected_msg.queue_free()
	if not $ChatLog.get_children().empty():
		for message in $ChatLog.get_children():
			message.reposition()
	var navi_button = get_node("../NaviButton/Button")
	if not navi_button.pressed:
		deactivate()

func animate_message(property,start,end):
	$Tween.interpolate_property(
		$ChatLog.get_child(0),
		property,
		start,
		end,
		0.4,
		Tween.TRANS_QUAD,
		Tween.EASE_OUT)
	$Tween.start()

onready var navi_action_button = get_node("../NaviActionButton")
func activate():
	is_active = true
	$ChatLog.show()
	for message in $ChatLog.get_children():
		message.show()
		message.resize()
	navi_action_button.show()
	show_background()
	show_chatline()

func deactivate():
	is_active = false
	$ChatLog.hide()
	for message in $ChatLog.get_children():
		message.get_node("Button").pressed = false
		message._on_toggled(false)
		message._on_mouse_exited()
	get_node("../NaviPanel")._on_NaviActionButton_toggled(false)
	navi_action_button.pressed = false
	navi_action_button.hide()
	hide_background()
	hide_chatline()

func show_chatline():
	if $chatline.is_visible_in_tree() and not $chatline/Tween.is_active():
		return
	if $chatline/Tween.is_active():
		yield($chatline/Tween,'tween_all_completed')
	$chatline.show()
	var pos_y = $chatline.rect_position.y
	animate_chatline('rect_position:y',pos_y+10,pos_y)
	animate_chatline('self_modulate',Color('00ffffff'),Color('ffffff'))

func hide_chatline():
	if $chatline/Tween.is_active():
		$chatline.hide()
		return
	var pos_y = $chatline.rect_position.y
	animate_chatline('rect_position:y',pos_y,pos_y+10)
	animate_chatline('self_modulate',Color('ffffff'),Color('00ffffff'))
	yield($chatline/Tween,'tween_all_completed')
	$chatline.rect_position.y -= 10
	$chatline.hide()

func animate_chatline(property,start,end):
	$chatline/Tween.interpolate_property(
		$chatline,
		property,
		start,
		end,
		0.4,
		Tween.TRANS_QUAD,
		Tween.EASE_OUT)
	$chatline/Tween.start()

onready var chat_background = get_node("../../NaviChatBackground")
onready var money_backdrop = get_node("../../MoneyBackdrop")
onready var chat_background_tween = chat_background.get_node("Tween")
func show_background():
	if chat_background_tween.is_active():
		yield(chat_background_tween,'tween_all_completed')
	chat_background.show()
	money_backdrop.show()
	animate_background("show")

func hide_background():
	if chat_background_tween.is_active():
		chat_background.hide()
		money_backdrop.hide()
		return
	animate_background("hide")
	yield(chat_background_tween,'tween_all_completed')
	chat_background.hide()
	money_backdrop.hide()

func animate_background(mode):
	var visibility = ['004b5460','f04b5460']
	if mode == "hide":
		visibility.invert()
	for node in [chat_background,money_backdrop]:
		chat_background_tween.interpolate_property(
			node,
			'self_modulate',
			Color(visibility[0]),
			Color(visibility[1]),
			0.4,
			Tween.TRANS_QUAD,
			Tween.EASE_OUT)
	chat_background_tween.start()
