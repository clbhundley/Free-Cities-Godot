extends Node

func generate(size):
	var build = [penthouse(),fill_top(),fill_bot(),t2(),t1(),t0()]
	for i in size - build.size():
		build.insert(i+2,fill())
	for terra in build.size():
		build[terra].name = "Terra "+str(build.size()-1-terra)
		build[0].name = "Penthouse"
	return build

#	for i in build:
#		print("----------------- ",i.name," -----------------")
#		for x in i.get_children():
#			if x.get('owned') != null:
#				print(x.name, " - owned: ",x.owned)
#			elif x.name == "Inner" or x.name == "Outer":
#				for z in x.get_children():
#					if z.get('owned') != null:
#						print(z.name," - owned: ",z.owned)
#					else:
#						print(z.name)
#			else:
#				print(x.name)

func penthouse():
	var terra = get_node('../Library/Terras/Penthouse').duplicate()
	var layout = [
	"master_suite_a",
	"master_suite_b",
	"head_girl_suite_a",
	"head_girl_suite_b",
	"slave_dormitory_a",
	"slave_dormitory_b",
	"slave_bedroom",
	"slave_bedroom",
	"nutrition_system",
	"remote_surgery",
	"body_mod_studio",
	"salon"]
	var index = 0
	for sector in terra.get_node("Inner").get_children():
		get_parent().swap(sector,get_node('../Library/Sectors/%s'%layout[index]).duplicate())
		index += 1
	return terra

func fill_top():
	var layout_1 = [{"park_a":1}, {"residential_standard":1}, {"commercial_standard":1}, {"residential_luxury":6}, {"commercial_luxury":2}]
	var layout_2 = [{"park_a":1}, {"residential_standard":2}, {"residential_luxury":6}, {"commercial_luxury":2}]
	var layout_3 = [{"park_a":2}, {"residential_standard":1}, {"residential_luxury":5}, {"commercial_luxury":2}]
	var layout_4 = [{"park_a":2}, {"residential_luxury":6}, {"commercial_luxury":2}]
	var layout_5 = [{"park_a":2}, {"residential_luxury":7}, {"commercial_luxury":1}]
	var layout_6 = [{"park_a":1}, {"residential_luxury":7}, {"commercial_luxury":3}]
	var layouts = [layout_1, layout_2, layout_3, layout_4, layout_5, layout_6]
	var composition = layouts[dice.roll(6)]
	var terra = get_node('../Library/Terras/Fill').duplicate()
	var ring = terra.get_node("Inner")
	for sector in composition:
		for amount in sector.values()[0]:
			ring = place(ring, sector.keys()[0])
	terra = assign_ownership(terra)
	return terra

func fill():
	var layout_1 = [{"park_a":1}, {"residential_standard":8}, {"commercial_standard":2}]
	var layout_2 = [{"park_a":1}, {"residential_standard":7}, {"commercial_standard":3}]
	var layout_3 = [{"park_a":2}, {"residential_standard":6}, {"commercial_standard":2}]
	var layout_4 = [{"park_a":2}, {"residential_standard":7}, {"commercial_standard":1}]
	var layout_5 = [{"residential_standard":9}, {"commercial_standard":3}]
	var layout_6 = [{"residential_standard":8}, {"commercial_standard":4}]
	var layouts = [layout_1, layout_2, layout_3, layout_4, layout_5, layout_6]
	var composition = layouts[dice.roll(6)]
	var terra = get_node('../Library/Terras/Fill').duplicate()
	var ring = terra.get_node("Inner")
	for sector in composition:
		for amount in sector.values()[0]:
			ring = place(ring, sector.keys()[0])
	terra = assign_ownership(terra)
	return terra

func fill_bot():
	var layout_1 = [{"residential_standard":3}, {"commercial_standard":1}, {"residential_dense":6}, {"commercial_dense":2}]
	var layout_2 = [{"park_a":1}, {"residential_standard":1}, {"commercial_standard":1}, {"residential_dense":6}, {"commercial_dense":2}]
	var layout_3 = [{"park_a":1}, {"residential_standard":2}, {"residential_dense":6}, {"commercial_dense":2}]
	var layout_4 = [{"park_a":1}, {"residential_dense":7}, {"commercial_dense":3}]
	var layout_5 = [{"park_a":2}, {"residential_standard":1}, {"residential_dense":5}, {"commercial_dense":2}]
	var layout_6 = [{"park_a":2}, {"residential_dense":6}, {"commercial_dense":2}]
	var layouts = [layout_1, layout_2, layout_3, layout_4, layout_5, layout_6]
	var composition = layouts[dice.roll(6)]
	var terra = get_node('../Library/Terras/Fill').duplicate()
	var ring = terra.get_node("Inner")
	for sector in composition:
		for amount in sector.values()[0]:
			ring = place(ring, sector.keys()[0])
	terra = assign_ownership(terra)
	return terra

func t2():
	var inner_layout_1 = [{"park_large_a":2}, {"commercial_standard":6}]
	var inner_layout_2 = [{"park_large_a":3}, {"commercial_standard":3}]
	var outer_layout_1 = [{"residential_standard":12}]
	var outer_layout_2 = [{"residential_standard":11}, {"commercial_standard":1}]
	var outer_layout_3 = [{"residential_standard":10}, {"commercial_standard":2}]
	var outer_layout_4 = [{"hydroponics_a":1}, {"residential_standard":7}, {"commercial_standard":2}]
	var outer_layout_5 = [{"hydroponics_a":1}, {"residential_standard":8}, {"commercial_standard":1}]
	var outer_layout_6 = [{"hydroponics_a":1}, {"laboratory":1}, {"residential_standard":7}, {"commercial_standard":1}]
	var inner_layouts = [inner_layout_1, inner_layout_2]
	var outer_layouts = [outer_layout_1, outer_layout_2, outer_layout_3, outer_layout_4, outer_layout_5, outer_layout_6]
	var inner_composition = inner_layouts[dice.roll(2)]
	var outer_composition = outer_layouts[dice.roll(6)]
	var terra = get_node('../Library/Terras/Terra 2').duplicate()
	var inner_ring = terra.get_node('Inner')
	for sector in inner_composition:
		for amount in sector.values()[0]:
			inner_ring = place(inner_ring, sector.keys()[0])
	inner_ring = assign_ownership(inner_ring)
	var outer_ring = terra.get_node('Outer')
	for sector in outer_composition:
		for amount in sector.values()[0]:
			outer_ring = place(outer_ring, sector.keys()[0])
	outer_ring = assign_ownership(outer_ring)
	return terra

func t1():
	var inner_layout_1 = [{"hydroponics_a":2}, {"manufacturing":3}, {"laboratory":2}, {"warehouse":1}]
	var inner_layout_2 = [{"hydroponics_a":1}, {"manufacturing":4}, {"laboratory":3}, {"warehouse":2}]
	var inner_layout_3 = [{"hydroponics_a":1}, {"manufacturing":5}, {"laboratory":2}, {"warehouse":2}]
	var inner_layout_4 = [{"manufacturing":6}, {"laboratory":4}, {"warehouse":2}]
	var inner_layout_5 = [{"manufacturing":6}, {"laboratory":3}, {"warehouse":3}]
	var inner_layout_6 = [{"manufacturing":7}, {"laboratory":3}, {"warehouse":2}]
	var outer_layout_1 = [{"hydroponics_a":3}, {"laboratory":3}]
	var outer_layout_2 = [{"hydroponics_a":2}, {"laboratory":3}, {"manufacturing":3}]
	var outer_layout_3 = [{"hydroponics_a":2}, {"laboratory":2}, {"manufacturing":4}]
	var inner_layouts = [inner_layout_1, inner_layout_2, inner_layout_3, inner_layout_4, inner_layout_5, inner_layout_6]
	var outer_layouts = [outer_layout_1, outer_layout_2, outer_layout_3]
	var inner_composition = inner_layouts[dice.roll(6)]
	var outer_composition = outer_layouts[dice.roll(3)]
	var terra = get_node('../Library/Terras/Terra 1').duplicate()
	var inner_ring = terra.get_node('Inner')
	for sector in inner_composition:
		for amount in sector.values()[0]:
			inner_ring = place(inner_ring, sector.keys()[0])
	inner_ring = assign_ownership(inner_ring)
	var outer_ring = terra.get_node('Outer')
	for sector in outer_composition:
		for amount in sector.values()[0]:
			outer_ring = place(outer_ring, sector.keys()[0])
	outer_ring = assign_ownership(outer_ring)
	return terra

func t0():
	var terra = get_node('../Library/Terras/Terra 0').duplicate()
	var layout = [
	"nuclear_reactor_gen_5",
	"water_purification",
	"secure_storage",
	"drone_manufacturing",
	"thermal_exchange_condenser_a",
	"thermal_exchange_condenser_b",
	"nuclear_reactor_gen_5",
	"water_purification",
	"secure_storage",
	"drone_manufacturing",
	"thermal_exchange_condenser_a",
	"thermal_exchange_condenser_b"]
	var index = 0
	for sector in terra.get_node("Inner").get_children():
		get_parent().swap(sector,get_node('../Library/Sectors/%s'%layout[index]).duplicate())
		index += 1
	return terra

func place(terra, sector_name):
	var sector = get_sector(sector_name)
	var size = 1
	if sector.get('size') != null:
		size = sector.get('size')
	var roll = dice.roll(12)
	if size == 1:
		while not "nullsec" in terra.get_child(roll).name:
			roll = dice.roll(12)
		get_parent().swap(terra.get_child(roll),sector)
	elif size == 2:
		var empty = false
		while empty == false:
			if "nullsec" in terra.get_child(roll).name and "nullsec" in terra.get_child(loop(roll+1)).name:
				get_parent().swap(terra.get_child(roll),sector)
				get_parent().swap(terra.get_child(loop(roll+1)),get_sector(sector_name.rstrip("_a")+"_b"))
				empty = true
			else:
				roll = dice.roll(12)
	elif size == 3:
		var empty = false
		while empty == false:
			if "nullsec" in terra.get_child(roll).name and "nullsec" in terra.get_child(loop(roll+1)).name and "nullsec" in terra.get_child(loop(roll+2)).name:
				get_parent().swap(terra.get_child(roll),sector)
				get_parent().swap(terra.get_child(loop(roll+1)),get_sector(sector_name.rstrip("_a")+"_b"))
				get_parent().swap(terra.get_child(loop(roll+2)),get_sector(sector_name.rstrip("_a")+"_c"))
				empty = true
			else:
				roll = dice.roll(12)
	return terra

func assign_ownership(terra):
	var buildings = 0
	for sector in terra.get_children():
		if sector.get('owned') != null:
			buildings += 1
	var half = floor(buildings/2)
	while half > 0:
		var roll = dice.roll(12)
		var sector = terra.get_child(roll)
		if sector.get('owned') != null:
			if sector.get('owned') == false:
				terra.get_child(roll).owned = true
				half -= 1
	return terra

func get_sector(name):
	return get_node('../Library/Sectors/%s'%name).duplicate()

func loop(input):
	if input > 11:
		return (input%11)-1
	else:
		return input
