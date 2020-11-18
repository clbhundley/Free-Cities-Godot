extends Node

func get_arcology():
	return get_tree().get_root().get_node("Game/Arcology")

func get_structure():
	return get_tree().get_root().get_node("Game/Arcology/Structure")

func get_neighbors(sector):
	var parent = sector.get_parent()
	var index = sector.get_index()
	var sector_size = 1
	var neighbors = []
	var _name = sector_name(parent.get_child(index).name)
	if _name.ends_with("_b"):
		index = (index+11)%12
	elif _name.ends_with("_c"):
		index = (index+10)%12
	if parent.get_child(index).get("size"):
		sector_size = parent.get_child(index).size
	var left = parent.get_child((index+sector_size)%12)
	var left_name = sector_name(left.name)
	if left_name.ends_with("_b"):
		left = parent.get_child((left.get_index()+11)%12)
	elif left_name.ends_with("_c"):
		left = parent.get_child((left.get_index()+10)%12)
	var right = parent.get_child((index+11)%12)
	var right_name = sector_name(right.name)
	if right_name.ends_with("_b"):
		right = parent.get_child((right.get_index()+11)%12)
	elif right_name.ends_with("_c"):
		right = parent.get_child((right.get_index()+10)%12)
	neighbors.append(left)
	if parent.get_parent().get_children().size() > 1:
		var ring = parent.get_parent().get_child(abs(parent.get_index()-1))
		for i in sector_size:
			var middle = ring.get_child((index+i+12)%12)
			var middle_name = sector_name(middle.name)
			if middle_name.ends_with("_b"):
				middle = ring.get_child((index+i+11)%12)
			elif middle_name.ends_with("_c"):
				middle = ring.get_child((index+i+10)%12)
			neighbors.append(middle)
	neighbors.append(right)
	return neighbors

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
