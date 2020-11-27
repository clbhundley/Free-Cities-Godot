extends Node

func get_arcology():
	return get_tree().get_root().get_node("Game/Arcology")

func get_structure():
	return get_tree().get_root().get_node("Game/Arcology/Structure")

func get_neighbors2(sector):
	var primary = get_neighbors(sector)
	var secondary = []
	for adjacent in primary:
		for neighbor in get_neighbors(adjacent):
			if not primary.has(neighbor):
				secondary.append(neighbor)
	var tertiary = []
	for adjacent in secondary:
		for neighbor in get_neighbors(adjacent):
			if not primary.has(neighbor) and not secondary.has(neighbor):
				tertiary.append(neighbor)
	return {primary=primary, secondary=secondary, tertiary=tertiary}

func get_neighbors(sector):
	var parent = sector.get_parent()
	var building_size = 1
	var primary = []
	var secondary = []
	var tertiary = []
	var index = get_building(sector).get_index()
	if parent.get_child(index).get("size"):
		building_size = parent.get_child(index).size
	var left_primary = get_building(parent.get_child((index+building_size)%12))
	var left_secondary = get_building(parent.get_child((index+building_size+1)%12))
	var left_tertiary = get_building(parent.get_child((index+building_size+2)%12))
	var right_primary = get_building(parent.get_child((index+11)%12))
	var right_secondary = get_building(parent.get_child((index+10)%12))
	var right_tertiary = get_building(parent.get_child((index+9)%12))
	if not primary.has(left_primary):
		primary.append(left_primary)
	if not primary.has(left_secondary):
		secondary.append(left_secondary)
	if not primary.has(left_tertiary) and not secondary.has(left_tertiary):
		tertiary.append(left_tertiary)
	if parent.get_parent().get_children().size() > 1:
		var opposite_ring = parent.get_parent().get_child(abs(parent.get_index()-1))
		for section in building_size:
			var middle = get_building(opposite_ring.get_child((index+section+12)%12))
			if not primary.has(middle):
				primary.append(middle)
		var middle_left_secondary = get_building(opposite_ring.get_child((index+building_size)%12))
		var middle_left_tertiary = get_building(opposite_ring.get_child((index+building_size+1)%12))
		var middle_right_secondary = get_building(opposite_ring.get_child((index+11)%12))
		var middle_right_tertiary = get_building(opposite_ring.get_child((index+10)%12))
		if not primary.has(middle_left_secondary):
			secondary.append(middle_left_secondary)
		if not primary.has(middle_left_tertiary) and not secondary.has(middle_left_tertiary):
			tertiary.append(middle_left_tertiary)
		if not primary.has(middle_right_secondary):
			secondary.append(middle_right_secondary)
		if not primary.has(middle_right_tertiary) and not secondary.has(middle_right_tertiary):
			tertiary.append(middle_right_tertiary)
	if not primary.has(right_primary):
		primary.append(right_primary)
	if not primary.has(right_secondary):
		secondary.append(right_secondary)
	if not primary.has(right_tertiary) and not secondary.has(right_tertiary):
		tertiary.append(right_tertiary)
	return {primary=primary, secondary=secondary, tertiary=tertiary}

func get_building(sector):
	if sector_name(sector.name).ends_with("_b"):
		return sector.get_parent().get_child((sector.get_index()+11)%12)
	elif sector_name(sector.name).ends_with("_c"):
		return sector.get_parent().get_child((sector.get_index()+10)%12)
	return sector

func sector_name(input):
	if "@" in input:
		var s = input.split("@")
		return s[1]
	else:
		return input

func swap_sectors(old,new):
	new.get_node('Collision').translation[2] = round(old.get_node('Collision').translation[2])
	new.get_node('Mesh').translation[2] = round(old.get_node('Mesh').translation[2])
	new.rotation_degrees[1] = round(old.rotation_degrees[1])
	get_arcology().connect_sector_signals(new)
	for children in old.get_children():
		children.queue_free()
	old.queue_free()
	old.replace_by(new)

func parse_address(address):
	if not address:
		return
	var sector = int(address)
	var terra = address.replace(sector,"")
	terra = terra[0].to_upper()
	var parsed_address = terra + str(sector)
	if terra == "P":
		terra = 0
	else:
		var enumerate = ["X","A","B","C","D","E","F","G","H","I","J","K","L"]
		terra = get_arcology().size - enumerate.find(terra) - 1
	var ring
	if sector > 12:
		sector -= 13
		ring = 1
	else:
		sector -= 1
		ring = 0
	var sector_name = get_structure().get_child(terra).get_child(ring).get_child(sector).name
	return {
		"address":parsed_address,
		"name":sector_name,
		"terra":terra,
		"sector":sector,
		"ring":ring}

func to_address(terra,ring,sector):
	var enumerate = ["X","A","B","C","D","E","F","G","H","I","J","K","L"]
	if terra == 0:
		terra = "P"
	else:
		terra = enumerate[get_arcology().size - terra - 1]
	if ring == 1:
		sector += 13
	else:
		sector += 1
	return terra + str(sector)

func get_nutrition_system(): # arcology globals file?
	var penthouse = get_structure().get_child(0).get_child(0).get_children()
	for sector in penthouse:
		if "nutrition" in sector.name:
			return ArcUtils.to_address(0,0,sector.get_position_in_parent())
