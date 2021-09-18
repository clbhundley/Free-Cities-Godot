extends "res://Slaves/Slave UI/Slave UI Input.gd"

func _ready():
	yield(_slave,"ready")
	get_tree().get_root().connect('size_changed',self,'resize')
	if _slave.assignment == "Resting":
		$Panel/Buttons/Assignment._select_int(0)
	elif _slave.assignment == "Prostitute":
		$Panel/Buttons/Assignment._select_int(1)
	if _slave.for_sale:
		$Panel/Buttons.hide()
		$Panel/SellingButtons.show()
	$Gauges.refresh_all()
	$StatsDisplay.refresh_all()
	set_refresh_mode('timeout')
	$Top/Name.set_text(_slave.name)
	if _slave.for_sale:
		$Top/Status.set_text("¤"+str(_slave.market_price()))
	elif _slave.health > 0:
		$Top/Status.set_text(_slave.assignment)
	_slave.action.display_action()
	$Location.refresh()
	set_level()
	tracking()
	resize()

func set_refresh_mode(mode:String):
	match mode:
		'timeout':
			$Gauges.set_refresh_mode('timeout')
			$StatsDisplay.set_refresh_mode('timeout')
		'minute':
			$Gauges.set_refresh_mode('timeout')
			$StatsDisplay.set_refresh_mode('minute')
		'hour':
			$Gauges.set_refresh_mode('minute')
			$StatsDisplay.set_refresh_mode('hour')
		'none':
			$Gauges.disconnect_all_signals()
			$StatsDisplay.disconnect_all_signals()

func set_level():
	$Top/Level.set_text(str(_slave.level))

func tracking(force=false):
	if not is_visible_in_tree() and not force:
		return
	var position = _slave.get_translation()
	var camera = get_tree().get_root().get_camera()
	var projection = camera.unproject_position(position)
	set_position(projection)

func resize(force=false):
	if not is_visible_in_tree() and not force:
		return
	var scale_y = display.scale_y
	var scale_adjusted = scale_y*20
	game.default_font.size = max(scale_adjusted,12)
	var baseline = Vector2(450,700)
	rect_min_size = Vector2(max(baseline.x*scale_y,270),max(baseline.y*scale_y,420))
	rect_size = Vector2(max(baseline.x*scale_y,270),max(baseline.y*scale_y,420))
	#line and level using same custom font, only one resize needed
	$Top/Level.get('custom_fonts/font').size = max(scale_adjusted*2,24)
	$Top/Line.get('custom_fonts/font').size = max(scale_adjusted*2,24)
	$Top/Name.get('custom_fonts/font').size = max(scale_adjusted*1.5,18)
	$Top/Status.get('custom_fonts/font').size = max(scale_adjusted,12)
	$StatsDisplay/Basic/Line1.get('custom_fonts/normal_font').size = clamp(scale_adjusted,12,20)
	if rect_size < Vector2(312.5,485.1):
		$Gauges/Arousal/Title.get('custom_fonts/font').size = 13
	else:
		$Gauges/Arousal/Title.get('custom_fonts/font').size = 14
	tracking()
