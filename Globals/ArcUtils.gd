extends Node

func get_arcology():
	return get_tree().get_root().get_node("Game/Arcology")

func get_structure():
	return get_tree().get_root().get_node("Game/Arcology/Structure")

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
