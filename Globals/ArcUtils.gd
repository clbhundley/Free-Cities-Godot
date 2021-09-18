extends Node

func get_structure():
	return get_tree().get_root().get_node("Game/Arcology/Structure")

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

func arcology_ownership_percent(structure):
	var sectors = []
	var owned_buildings = []
	for terra in structure.get_children():
		if terra.name != "Penthouse" and terra.name != "Basement":
			for ring in terra.get_children():
				for sector in ring.get_children():
					sectors.append(sector)
					var building = ArcUtils.get_building(sector)
					if building.owned:
						if not owned_buildings.has(building):
							owned_buildings.append(building)
	var owned_buildings_total_area = 0
	for i in owned_buildings:
		if i.get("size"):
			owned_buildings_total_area += i.size
		else:
			owned_buildings_total_area += 1
	var percent = stepify(float(owned_buildings_total_area)/float(sectors.size())*100,0.1)
	return percent

func swap_sectors(old,new):
	new.get_node('Collision').translation[2] = round(old.get_node('Collision').translation[2])
	new.get_node('Mesh').translation[2] = round(old.get_node('Mesh').translation[2])
	new.rotation_degrees[1] = round(old.rotation_degrees[1])
	game.arcology.connect_sector_signals(new)
	for children in old.get_children():
		children.queue_free()
	old.queue_free()
	old.replace_by(new)

func get_building_display_name(building):
	if "park_large" in building.name:
		return "Park - Large"
	elif "park" in building.name:
		return "Park"
	elif "residential" in building.name:
		return "res"

func get_building_size(building):
	if building.get("size"):
		return building.size
	return 1

func get_neighbors(sector):
	var parent = sector.get_parent()
	var building_size = get_building_size(get_building(sector))
	var primary = []
	var secondary = []
	var tertiary = []
	var neighbors = [primary,secondary,tertiary]
	var index = get_building(sector).get_index()
	var left_primary = get_building(parent.get_child((index+building_size)%12))
	var left_secondary = get_building(parent.get_child((index+building_size+1)%12))
	var left_tertiary = get_building(parent.get_child((index+building_size+2)%12))
	var right_primary = get_building(parent.get_child((index+11)%12))
	var right_secondary = get_building(parent.get_child((index+10)%12))
	var right_tertiary = get_building(parent.get_child((index+9)%12))
	check_and_add(left_primary,"primary",neighbors)
	check_and_add(left_secondary,"secondary",neighbors)
	check_and_add(left_tertiary,"tertiary",neighbors)
	if parent.get_parent().get_children().size() > 1:
		var opposite_ring = parent.get_parent().get_child(abs(parent.get_index()-1))
		for section in building_size:
			var middle = get_building(opposite_ring.get_child((index+section+12)%12))
			check_and_add(middle,"primary",neighbors)
		var middle_left_secondary = get_building(opposite_ring.get_child((index+building_size)%12))
		var middle_left_tertiary = get_building(opposite_ring.get_child((index+building_size+1)%12))
		var middle_right_secondary = get_building(opposite_ring.get_child((index+11)%12))
		var middle_right_tertiary = get_building(opposite_ring.get_child((index+10)%12))
		check_and_add(middle_left_secondary,"secondary",neighbors)
		check_and_add(middle_left_tertiary,"tertiary",neighbors)
		check_and_add(middle_right_secondary,"secondary",neighbors)
		check_and_add(middle_right_tertiary,"tertiary",neighbors)
	check_and_add(right_primary,"primary",neighbors)
	check_and_add(right_secondary,"secondary",neighbors)
	check_and_add(right_tertiary,"tertiary",neighbors)
	return {primary=primary, secondary=secondary, tertiary=tertiary}

func check_and_add(building,mode,neighbors):
	var primary = neighbors[0]
	var secondary = neighbors[1]
	var tertiary = neighbors[2]
	match mode:
		"primary":
			if not primary.has(building):
				primary.append(building)
		"secondary":
			if not primary.has(building):
				secondary.append(building)
		"tertiary":
			if not primary.has(building) and not secondary.has(building):
				tertiary.append(building)

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
		terra = game.arcology.size - enumerate.find(terra) - 1
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

func to_address(terra_index,ring_index,sector_index):
	var enumerate = ["X","A","B","C","D","E","F","G","H","I","J","K","L"]
	if terra_index == 0:
		terra_index = "P"
	else:
		terra_index = enumerate[game.arcology.size - terra_index - 1]
	if ring_index == 1:
		sector_index += 13
	else:
		sector_index += 1
	return terra_index + str(sector_index)

func get_nutrition_system(): # arcology globals file?
	var penthouse = get_structure().get_child(0).get_child(0).get_children()
	for sector in penthouse:
		if "nutrition" in sector.name:
			return ArcUtils.to_address(0,0,sector.get_position_in_parent())
