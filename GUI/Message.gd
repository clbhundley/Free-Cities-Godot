extends NinePatchRect

func _ready():
	get_tree().get_root().connect('size_changed',self,'resize')

func dialogue(string,instant:=false):
	if instant:
		$Text.set_text("")
		$Text.parse_bbcode(string)
		yield(get_tree(),"idle_frame")
		for node in get_parent().get_children():
			node.resize()
		return
	var half_stop = [",", ";", "-"]
	var full_stop = [".", "!", "?"]
	while not string.empty():
		var character = string[0]
		string.erase(0,1)
		$Text.add_text(character)
		for node in get_parent().get_children():
			node.resize()
		if character != " " and character.c_escape() != "\n".c_escape():
			if is_visible_in_tree():
				$Audio.play()
		if half_stop.has(character):
			$Timer.wait_time = 0.1
		elif full_stop.has(character):
			$Timer.wait_time = 0.2
		else:
			$Timer.wait_time = 0.02
		$Timer.start()
		yield($Timer,"timeout")

func read(filepath):
	var text
	var file = File.new()
	file.open(filepath,File.READ)
	text = file.get_as_text()
	file.close()
	dialogue(text)

func _on_Close_pressed():
	get_node("../../").remove_message(get_index())

func _on_toggled(button_pressed):
	if button_pressed:
		$ExtensionPanel.show()
		animate_outline('modulate',Color('ffffff'),Color('ff7200'),0.4)
		get_node("../../../NaviActionButton").pressed = false
		get_node("../../../NaviPanel")._on_NaviActionButton_toggled(false)
		for message in get_parent().get_children():
			if message != self and message.get_node("Button").pressed:
				message.get_node("Button").pressed = false
				message._on_toggled(false)
				message._on_mouse_exited()
	else:
		$ExtensionPanel.hide()
		animate_outline('modulate',Color('ff7200'),Color('ffffff'),0.4)

func _on_mouse_entered():
	if not $Button.pressed:
		animate_outline('self_modulate',Color('00ffffff'),Color('ffffff'))

func _on_mouse_exited():
	if not $Button.pressed:
		animate_outline('self_modulate',Color('ffffff'),Color('00ffffff'))

func animate_outline(property,start,end,length=0.2):
	$Outline/Tween.interpolate_property(
		$Outline,
		property,
		start,
		end,
		length,
		Tween.TRANS_EXPO,
		Tween.EASE_OUT)
	$Outline/Tween.start()

func resize():
	if not is_visible_in_tree():
		return
	yield(get_tree(),"idle_frame")
	if rect_size.y > rect_min_size.y:
		animate_message('rect_size:y',rect_size.y,rect_min_size.y)
	animate_message(
		'rect_min_size:y',
		rect_min_size.y,
		$Text.get_content_height() + 25)

func reposition():
	var tween = get_node("../../Tween")
	var index = get_position_in_parent()
	if index != 0:
		var next_msg = get_parent().get_child(index-1)
		var next_msg_begin = next_msg.rect_position.y - 10 - rect_size.y
		animate_message(
			'rect_position:y',
			rect_position.y,
			next_msg_begin,
			tween)
	else:
		var base_msg = get_node("../../Message")
		var msg_begin = base_msg.rect_position.y + base_msg.rect_size.y
		animate_message(
			'rect_position:y',
			rect_position.y,
			msg_begin - rect_size.y,
			tween)
	_on_Tween_step()

func _on_Tween_step(object=null, key=null, elapsed=null, value=null):
	var index = get_position_in_parent()
	if index != 0:
		var next_msg_begin = get_parent().get_child(index-1).rect_position.y
		rect_position.y = next_msg_begin - 10 - rect_size.y
	else:
		var base_msg = get_node("../../Message")
		var msg_begin = base_msg.rect_position.y + base_msg.rect_size.y
		rect_position.y = msg_begin - rect_size.y

func _on_Tween_all_completed():
	if rect_size.y > rect_min_size.y:
		animate_message('rect_size:y',rect_size.y,rect_min_size.y)
	_on_Tween_step()

func animate_message(property,start,end,tween=$Tween):
	tween.interpolate_property(
		self,
		property,
		start,
		end,
		0.2,
		Tween.TRANS_EXPO,
		Tween.EASE_OUT)
	tween.start()
