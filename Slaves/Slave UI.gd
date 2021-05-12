extends "res://Slaves/Slave UI Input.gd"

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
	for text in $StatsDisplay.get_children():
		text.set_stats()
	$Top/Name.set_text(_slave.name)
	if _slave.health > 0:
		$Top/Status.set_text(_slave.assignment)
	_slave.action.display_action()
	display_location()
	set_level()
	tracking()
	resize()

func set_level():
	$Top/Level.set_text(str(_slave.stats._level()))

func display_location():
	var loc = _slave.location
	var des = _slave.destination
	var location_address = ArcUtils.parse_address(loc)["address"]
	var location_name = ArcUtils.parse_address(loc)["name"]
	if _slave.destination:
		var destination_address = ArcUtils.parse_address(des)["address"]
		var destination_name = ArcUtils.parse_address(des)["name"]
		var format = [
			location_address,
			get_display_name(location_name),
			destination_address,
			get_display_name(destination_name)]
		$Location.set_text("%s: %s  >>>  %s: %s"%format)
	else:
		var string = "%s - %s"%[location_address,get_display_name(location_name,true)]
		$Location.set_text(string)

func get_display_name(sector,full=false):
	var _name = ArcUtils.sector_name(sector).to_lower()
	var suffixes = ["_a","_b","_c"]
	for suffix in suffixes:
		_name = _name.trim_suffix(suffix)
	if "park" in _name:
		_name = "Public Park"
	if full:
		return _name.capitalize()
	if "residential" in _name:
		return("Residential")
	elif "commercial" in _name:
		return("Commercial")
	else:
		return _name.capitalize()

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
	$StatsDisplay/Basic.get('custom_fonts/normal_font').size = clamp(scale_adjusted,12,20)
	$Gauges/Upper/Health/Value.get('custom_fonts/font').size = scale_adjusted*1.2
	tracking()
