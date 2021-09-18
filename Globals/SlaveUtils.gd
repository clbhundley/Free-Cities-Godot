extends Node

func get_owned_slaves():
	return game.slaves.get_node("Collections/Owned")

func get_slave(slave_name):
	if get_owned_slaves().has_node(slave_name):
		return get_owned_slaves().get_node(slave_name)

func slave_count(collection):
	return game.slaves.get_node("Collections/"+collection).get_child_count()

func update_owned_slaves():
	for _slave in get_owned_slaves().get_children():
		_slave.get_node("UI/StatsDisplay").refresh_all()
		_slave.get_node("UI/Gauges").refresh_all()

func uptate_examine_slave():
	game.slaves.get_node("ExamineSlave").uptate_display()

func get_weeks_pregnant(_slave):
	if not _slave.pregnancy:
		return
	var time_pregnant = time.get_total_time(
		_slave.pregnancy['conceived'],
		time.get_timestamp())
	return time_pregnant['weeks']+time_pregnant['quarters']*13

func slaves_in_proximity(_slave):
	var slaves_in_proximity = []
	for other_slave in get_owned_slaves().get_children():
		if not other_slave == _slave:
			if other_slave.location == _slave.location:
				slaves_in_proximity.append(other_slave)
	return slaves_in_proximity

func proximity_social(_slave):
	var slaves_in_proximity = slaves_in_proximity(_slave)
	var ranked_social_affinity = []
	for other_slave in slaves_in_proximity:
		var pair = {other_slave.name:personality_affinity(_slave,other_slave)}
		ranked_social_affinity.append(pair)
	ranked_social_affinity.sort_custom(SortByValue,"sort_descending")
	return ranked_social_affinity

func proximity_dominance(_slave):
	var slaves_in_proximity = slaves_in_proximity(_slave)
	var ranked_dominance_affinity = []
	for other_slave in slaves_in_proximity:
		var pair = {other_slave.name:dominance_affinity(_slave,other_slave)}
		ranked_dominance_affinity.append(pair)
	ranked_dominance_affinity.sort_custom(SortByValue,"sort_descending")
	return ranked_dominance_affinity

func proximity_affinity(_slave):
	var slaves_in_proximity = slaves_in_proximity(_slave)
	var ranked_affinity = []
	for other_slave in slaves_in_proximity:
		var pair = {other_slave.name:affinity(_slave,other_slave)}
		ranked_affinity.append(pair)
	ranked_affinity.sort_custom(SortByValue,"sort_descending")
	return ranked_affinity

func desire(slave_a,slave_b):
	var lust = 1 + float(slave_a.arousal)/100
	var libido = float(slave_a.libido)/100
	var affinity = affinity(slave_a,slave_b)
	if affinity < 0:
		if libido < 1:
			libido = 1.0/libido
		if lust > 1:
			lust = 1.0/lust
	return int(round(lust*libido*affinity))

func affinity(slave_a,slave_b):
	var social = personality_affinity(slave_a,slave_b)
	var dominance = dominance_affinity(slave_a,slave_b)
	var orientation = orientation_affinity(slave_a,slave_b)
	if social < 0:
		social *= 1.0/orientation
	else:
		social *= orientation
	if orientation < 1:
		social -= 2*(20-(orientation*20))
	else:
		social -= 20-(orientation*20)
	dominance *= orientation
	return int(round(social+dominance))

func orientation_affinity(slave_a,slave_b):
	var male_affinity
	var male_orientation = clamp(abs(slave_a.male_attraction),0,100)
	if slave_a.male_attraction < 0:
		male_affinity = 1-(float(male_orientation)/200)
	else:
		male_affinity = 1+(float(male_orientation)/100)
	var female_affinity
	var female_orientation = clamp(abs(slave_a.female_attraction),0,100)
	if slave_a.female_attraction < 0:
		female_affinity = 1-(float(female_orientation)/200)
	else:
		female_affinity = 1+(float(female_orientation)/100)
	match slave_b.gender:
		"Male","Trans male":
			return male_affinity
		"Female","Trans female":
			return female_affinity
		_:
			return 1

func dominance_affinity(slave_a,slave_b):
	var max_dominance = min(slave_a.dominance,slave_b.submission)
	var max_submission = min(slave_a.submission,slave_b.dominance)
	var dom_compatibility = slave_a.dominance + slave_b.submission
	var sub_compatibility = slave_a.submission + slave_b.dominance
	var dom_affinity = min(dom_compatibility,max_dominance)
	var sub_affinity = min(sub_compatibility,max_submission)
	return dom_affinity + sub_affinity

func dominance_interaction(slave_a,slave_b):
	var a_mood = round(rand_range(-slave_a.submission,slave_a.dominance))
	var b_mood = round(rand_range(-slave_b.submission,slave_b.dominance))
	if a_mood > b_mood:
		return 0
	elif b_mood > a_mood:
		return 1
	else:
		if randi()%2 == 0:
			if slave_a.dominance > slave_b.dominance:
				return 0
			elif slave_b.dominance > slave_a.dominance:
				return 1
	return randi()%2

func personality_affinity(slave_a,slave_b):
	var affinity = 0
	for a_temperament in slave_a.personality:
		for b_temperament in slave_b.personality:
			affinity += _temperament_affinity(a_temperament,b_temperament)
	return affinity

# C S
# M P
func _temperament_affinity(a_temperament,b_temperament):
	match a_temperament:
		"C":
			match b_temperament:
				"S","M":
					return 1
				"P":
					return -1
		"M":
			match b_temperament:
				"C","P":
					return 1
				"S":
					return -1
		"P":
			match b_temperament:
				"S","M":
					return 1
				"C":
					return -1
		"S":
			match b_temperament:
				"C","P":
					return 1
				"M":
					return -1
	return 0

func reset_active_slaves_visibility():
	var examine_slave = game.slaves.get_node("ExamineSlave")
	if not examine_slave.active:
		return
	game.slaves.get_node("Camera").show()
	examine_slave.deactivate(false)
	for node in get_tree().get_nodes_in_group("Active Slaves"):
		if node.has_node("OmniLight"):
			node.get_node("OmniLight").hide()
#		if node.has_method("resize"):
#			node.resize(true)
		node.remove_from_group("Active Slaves")
		node.show()

func decorated_slaves_price():
	var slaves_price = game.slaves.price
	if slaves_price <= 0.6:
		return "[color=#005cff]Very Low[/color]"
	elif slaves_price <= 0.8:
		return "[color=#00cdff]Low[/color]"
	elif slaves_price <= 1.25:
		return "Average"
	elif slaves_price <= 1.5:
		return "[color=#ffdf00]High[/color]"
	elif slaves_price > 1.5:
		return "[color=#ff7000]Very High[/color]"

func sort_slaves(collection,mode,order):
	collection = game.slaves.get_node("Collections/"+collection)
	var list = []
	for _slave in collection.get_children():
		list.append(_slave)
	if mode == "Devotion":
		list.sort_custom(SortByDevotion,"sort_ascending")
	elif mode == "Level":
		list.sort_custom(SortByLevel,"sort_ascending")
	elif mode == "Assignment":
		list.sort_custom(SortByAssignment,"sort_ascending")
	elif mode == "Acquired":
		list.sort_custom(SortByAcquired,"sort_ascending")
	elif mode == "Gender":
		list.sort_custom(SortByGender,"sort_ascending")
	elif mode == "Name":
		list.sort_custom(SortByName,"sort_ascending")
	elif mode == "Age":
		list.sort_custom(SortByAge,"sort_ascending")
	if order == "Descending":
		list.invert()
	for index in list.size():
		collection.move_child(list[index],index)
	game.slaves.update_collection(collection)

class SortByValue:
	static func sort_descending(a,b):
		if a.values()[0] > b.values()[0]:
			return true
		return false

class SortByDevotion:
	static func sort_ascending(a,b):
		if a.devotion < b.devotion:
			return true
		elif a.devotion == b.devotion:
			if a.trust < b.trust:
				return true
			elif a.trust == b.trust:
				if a.name < b.name:
					return true
		return false

class SortByLevel:
	static func sort_ascending(a,b):
		if a.level < b.level:
			return true
		elif a.level == b.level:
			if a.name < b.name:
				return true
		return false

class SortByAssignment:
	static func sort_ascending(a,b):
		if a.assignment < b.assignment:
			return true
		elif a.assignment == b.assignment:
			if a.name < b.name:
				return true
		return false

class SortByAcquired:
	static func sort_ascending(a,b):
		if a.acquired['year'] < b.acquired['year']:
			return true
		elif a.acquired['year'] == b.acquired['year']:
			if a.acquired['quarter'] < b.acquired['quarter']:
				return true
			elif a.acquired['quarter'] == b.acquired['quarter']:
				if a.acquired['week'] < b.acquired['week']:
					return true
				elif a.acquired['week'] == b.acquired['week']:
					if a.acquired['day'] < b.acquired['day']:
						return true
					elif a.acquired['day'] == b.acquired['day']:
						if a.acquired['hour'] < b.acquired['hour']:
							return true
						elif a.acquired['hour'] == b.acquired['hour']:
							if a.acquired['minute'] < b.acquired['minute']:
								return true
							elif a.acquired['minute'] == b.acquired['minute']:
								if a.acquired['second'] < b.acquired['second']:
									return true
								elif a.acquired['second'] == b.acquired['second']:
									if a.name < b.name:
										return true
		return false

class SortByGender:
	static func sort_ascending(a,b):
		if a.gender < b.gender:
			return true
		elif a.gender == b.gender:
			if a.name < b.name:
				return true
		return false

class SortByName:
	static func sort_ascending(a,b):
		if a.name < b.name:
				return true
		return false

class SortByAge:
	static func sort_ascending(a,b):
		if a.age < b.age:
			return true
		elif a.age == b.age:
			if a.name < b.name:
				return true
		return false
