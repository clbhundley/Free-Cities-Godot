extends Label

onready var _slave = owner.owner

func refresh():
	if not is_visible_in_tree():
		return
	var location = _slave.location
	var destination = _slave.destination
	var location_address = ArcUtils.parse_address(location)["address"]
	var location_name = ArcUtils.parse_address(location)["name"]
	if _slave.destination:
		var destination_address = ArcUtils.parse_address(destination)["address"]
		var destination_name = ArcUtils.parse_address(destination)["name"]
		var format = [
			location_address,
			get_building_name(location_name),
			destination_address,
			get_building_name(destination_name)]
		set_text("%s: %s  >>>  %s: %s"%format)
	else:
		var building_name = get_building_name(location_name,true)
		var string = "%s - %s"%[location_address,building_name]
		set_text(string)

func get_building_name(sector,full=false):
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
