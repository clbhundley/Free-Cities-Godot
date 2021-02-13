extends Control

onready var root = get_tree().get_root()
onready var slaves = root.get_node("Game/Slaves")
onready var _slave = owner

func _ready():
	yield(_slave,"ready")
	root.connect('size_changed',self,'resize')
	if _slave.assignment == "Resting":
		get_node("Panel/Buttons/Assignment")._select_int(0)
	elif _slave.assignment == "Prostitute":
		get_node("Panel/Buttons/Assignment")._select_int(1)
	if _slave.for_sale:
		get_node('Panel/Buttons').hide()
		get_node('Panel/Selling Buttons').show()
	for text in get_node("Stats Display").get_children():
		text.set_stats()
	get_node('Top/Name').set_text(_slave.name)
	get_node('Top/Status').set_text(_slave.assignment)
	get_node('../Scripts/Actions/'+_slave.action).display_action()
	display_location()
	set_level()
	tracking()
	resize()

func tracking():
	if not is_visible_in_tree():
		return
	var position = _slave.get_translation()
	var camera = root.get_camera()
	var projection = camera.unproject_position(position)
	set_position(projection)

func set_level():
	get_node('Top/Level').set_text(str(get_node('../Scripts/Stats')._level()))

func display_location():
	var loc = get_parent().location
	var des = get_parent().destination
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
		get_node("Location").set_text("%s: %s  >>>  %s: %s"%format)
	else:
		var string = "%s - %s"%[location_address,get_display_name(location_name,true)]
		get_node("Location").set_text(string)

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

func resize():
	if not is_visible_in_tree():
		return
	var scale_y = display.scale_y
	var scale_adjusted = scale_y*20
	game.default_font.size = max(scale_adjusted,12)
	var baseline = Vector2(450,700)
	rect_min_size = Vector2(max(baseline.x*scale_y,270),max(baseline.y*scale_y,420))
	rect_size = Vector2(max(baseline.x*scale_y,270),max(baseline.y*scale_y,420))
	#line and level using same custom font, only one resize needed
	get_node("Top/Level").get('custom_fonts/font').size = max(scale_adjusted*2,24)
	get_node("Top/Line").get('custom_fonts/font').size = max(scale_adjusted*2,24)
	get_node("Top/Name").get('custom_fonts/font').size = max(scale_adjusted*1.5,18)
	get_node("Top/Status").get('custom_fonts/font').size = max(scale_adjusted,12)
	get_node("Stats Display/Basic").get('custom_fonts/normal_font').size = clamp(scale_adjusted,12,20)
	get_node("Gauges/Upper/Health/Value").get('custom_fonts/font').size = scale_adjusted*1.2
	tracking()
