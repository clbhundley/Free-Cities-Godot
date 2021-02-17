extends Control

onready var clock = get_tree().get_root().get_node('Game/Clock')

func _ready():
	get_tree().get_root().connect('size_changed',self,'resize')
	get_tree().get_root().get_node('Game/Clock').connect('timeout',self,'update_time')
	update_time()
	resize()

func resize():
	return
	var scale_small = display.scale*1.6
	var scale_large = display.scale*22
	margin_left = max(-110,-110 * scale_small)
	margin_top = max(-110,-110 * scale_small)
	#use font for both
	get_node("Label Bot").get('custom_fonts/font').size = clamp(scale_large,10,16)
	get_node("Label Top").get('custom_fonts/font').size = clamp(scale_large,10,16)

func update_time():
	get_node('Label Top').set_text(hour()+":"+minute()+"\n"+day())
	get_node('Label Bot').set_text("Week "+week()+"\n"+quarter()+" "+str(time.year))
	get_node('Calendar/Date').set_text(day()+", "+quarter()+" "+str(time.year))
	get_node('Calendar/Time').set_text(hour()+":"+minute())
	for nodes in get_tree().get_nodes_in_group('Days'):
		nodes.set_modulate('28ffffff')
	for nodes in get_tree().get_nodes_in_group('Weeks'):
		nodes.set_modulate('ffffff')
	for days in get_node('Calendar/Week/'+week()).get_children():
		days.set_modulate('50ffffff')
	get_node('Calendar/Week/'+week()+'/Number').set_modulate('ff7200')
	get_node('Calendar/Week/'+week()+'/'+day()).set_modulate('ff7200')

func minute():
	if time.minute < 10:
		return str("0",time.minute)
	else:
		return str(time.minute)

func hour():
	if time.hour < 10:
		return str("0",time.hour)
	else:
		return str(time.hour)

func day():
	var days = {
		0:"Sunday",
		1:"Monday",
		2:"Tuesday",
		3:"Wednesday",
		4:"Thursday",
		5:"Friday",
		6:"Saturday"}
	return days.values()[time.day]

func week():
	return str(time.week+1)

func quarter():
	return "Q"+str(time.quarter+1)

onready var timer = get_tree().get_root().get_node('Game/Clock')
func _on_HSlider_value_changed(value):
	timer.stop()
	var t = value/100
	timer.wait_time = 1-t
	timer.start()

func animate_sml(node):
	var tween = get_node('Tween')
	var h_pos = 55
	if display.scale < 0.6:
		var s = display.scale*1.5
		h_pos *= 0.8
		$rabbit.scale = Vector2(s,s)
		$turtle.scale = Vector2(s*0.75,s*0.75)
		$play.scale = Vector2(s,s)
		$pause.scale = Vector2(s,s)
	else:
		$rabbit.scale = Vector2(1,1)
		$turtle.scale = Vector2(0.75,0.75)
		$play.scale = Vector2(1,1)
		$pause.scale = Vector2(1,1)
	tween.interpolate_property(node,'position',Vector2(h_pos,55),Vector2(h_pos,-55),1,Tween.TRANS_QUAD,Tween.EASE_OUT)
	tween.interpolate_property(node,'modulate',Color('00ffffff'),Color('ffffff'),1,Tween.TRANS_QUAD,Tween.EASE_OUT,0.2)
	tween.interpolate_property(node,'position',Vector2(h_pos,-55),Vector2(h_pos,55),1,Tween.TRANS_QUAD,Tween.EASE_IN_OUT,1)
	tween.interpolate_property(node,'modulate',Color('ffffff'),Color('00ffffff'),1,Tween.TRANS_QUAD,Tween.EASE_IN_OUT,1)
	tween.start()

func _on_mouse_entered():
	get_node('tab_right').set_self_modulate('782873c8')

func _on_mouse_exited():
	if not get_node('HSlider').is_visible_in_tree():
		get_node('tab_right').set_self_modulate('3c333a4b')
