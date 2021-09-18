extends Button

func _on_TotalWeeks_pressed():
	animate_end_week_buttons(self,false)
	animate_end_week_buttons($HBox,true)
	$Timer.start()
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	for button in $HBox.get_children():
		button.mouse_filter = Control.MOUSE_FILTER_STOP

func _on_Timer_timeout():
	animate_end_week_buttons(self,true)
	animate_end_week_buttons($HBox,false)
	mouse_filter = Control.MOUSE_FILTER_STOP
	for button in $HBox.get_children():
		button.mouse_filter = Control.MOUSE_FILTER_IGNORE

var starting_time_scale

var starting_hour
func _on_EndDay_pressed():
	begin_time_skip()
	for hour in 24:
		yield(get_tree(),"idle_frame")
		$ProgressBar.set_value(float(hour)/(24-starting_hour))
		SlaveUtils.update_owned_slaves()
		yield(get_tree(),"idle_frame")
		for minute in 60:
			time.tick()
			if time.hour == 0:
				if time.minute == 0:
					$ProgressBar.set_value(1)
					end_time_skip()
					return
		yield(get_tree(),"idle_frame")

var starting_day
func _on_EndWeek_pressed():
	begin_time_skip()
	for day in 7:
		yield(get_tree(),"idle_frame")
		$ProgressBar.set_value(float(day)/(7-starting_day))
		SlaveUtils.update_owned_slaves()
		yield(get_tree(),"idle_frame")
		for minute in 1440:
			time.tick()
			if time.day == 0:
				if time.hour == 0:
					if time.minute == 0:
						$ProgressBar.set_value(1)
						end_time_skip()
						return
		yield(get_tree(),"idle_frame")

func begin_time_skip():
	game.stopwatch(true)
	get_tree().get_root().set_disable_input(true)
	$ProgressBar.set_modulate("ffffff")
	$HBox.hide()
	$Timer.stop()
	yield(get_tree(),"idle_frame")
	starting_time_scale = time.scale
	starting_hour = time.hour
	starting_day = time.day
	time.fast_forward = true
	time.scale = 60
	for _slave in SlaveUtils.get_owned_slaves().get_children():
		_slave.ui.set_refresh_mode('none')

func end_time_skip():
	game.stopwatch(false)
	time.scale = starting_time_scale
	for _slave in SlaveUtils.get_owned_slaves().get_children():
		_slave.ui.set_refresh_mode(get_slave_ui_refresh_mode())
	yield(get_tree(),"idle_frame")
	SlaveUtils.update_owned_slaves()
	SlaveUtils.uptate_examine_slave()
	game.gui.get_node("SidePanel").refresh_all()
	$ProgressBar.set_modulate("00ffffff")
	$HBox.show()
	$HBox.set_modulate("00ffffff")
	set_self_modulate("ffffff")
	get_tree().get_root().set_disable_input(false)
	mouse_filter = Control.MOUSE_FILTER_STOP
	for button in $HBox.get_children():
		button.mouse_filter = Control.MOUSE_FILTER_IGNORE
	for _slave in SlaveUtils.get_owned_slaves().get_children():
		_slave.get_node("UI/StatsDisplay").refresh_all()
	time.fast_forward = false
	time.emit_signal("ff_end")

func animate_end_week_buttons(node,opening:bool):
	var mode
	var initial
	var final
	if node.name == "TotalWeeks":
		mode = "set_self_modulate"
	else:
		mode = "set_modulate"
	if opening:
		initial = Color("00ffffff")
		final = Color("ffffff")
	else:
		initial = Color("ffffff")
		final = Color("00ffffff")
	$Tween.interpolate_method(
		node,
		mode,
		initial,
		final,
		0.2,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT)
	$Tween.start()

func get_slave_ui_refresh_mode():
	var clock_speed_slider = get_node("../Controls/Sliders/ClockSpeed")
	var time_scale_slider = get_node("../Controls/Sliders/TimeScale")
	if time_scale_slider.value >= 10:
		return 'hour'
	elif clock_speed_slider.value >= 90:
		return 'minute'
	else:
		return 'timeout'
