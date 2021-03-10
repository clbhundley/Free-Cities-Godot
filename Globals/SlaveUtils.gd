extends Node

func get_slave_scene():
	return get_tree().get_root().get_node("Game/Slaves")

func get_owned_slaves():
	return  get_slave_scene().get_node("Collections/Owned")

func slave_count(collection):
	return get_slave_scene().get_node("Collections/"+collection).get_child_count()

func reset_active_slaves_visibility():
	var examine_slave = get_slave_scene().get_node("Examine Slave")
	if not examine_slave.active:
		return
	get_slave_scene().get_node("Camera").show()
	#get_slave_scene().get_node("Camera").show()
	examine_slave.deactivate(false)
	for node in get_tree().get_nodes_in_group("Active Slaves"):
		if node.has_node("OmniLight"):
			node.get_node("OmniLight").hide()
#		if node.has_method("resize"):
#			node.resize(true)
		node.remove_from_group("Active Slaves")
		node.show()

func sort_slaves(collection,mode,order):
	collection = get_slave_scene().get_node("Collections/"+collection)
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
	get_slave_scene().update_collection(collection)

class SortByDevotion:
	static func sort_ascending(a, b):
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
	static func sort_ascending(a, b):
		if a.get_level() < b.get_level():
			return true
		elif a.get_level() == b.get_level():
			if a.name < b.name:
				return true
		return false

class SortByAssignment:
	static func sort_ascending(a, b):
		if a.assignment < b.assignment:
			return true
		elif a.assignment == b.assignment:
			if a.name < b.name:
				return true
		return false

class SortByAcquired:
	static func sort_ascending(a, b):
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
	static func sort_ascending(a, b):
		if a.gender < b.gender:
			return true
		elif a.gender == b.gender:
			if a.name < b.name:
				return true
		return false

class SortByName:
	static func sort_ascending(a, b):
		if a.name < b.name:
				return true
		return false

class SortByAge:
	static func sort_ascending(a, b):
		if a.age < b.age:
			return true
		elif a.age == b.age:
			if a.name < b.name:
				return true
		return false
