extends Node

var save_slot
var config = ConfigFile.new()
var autosave_interval

func set_autosave():
	if not config.has_section_key("autosave", "interval"):
		config.set_value("autosave", "interval", 2)
		config.save('user://config.cfg')
	var config_value = config.get_value("autosave", "interval")
	if config_value == 0:
		autosave_interval = 0
	elif config_value == 1:
		autosave_interval = 1
	elif config_value == 2:
		autosave_interval = 5
	elif config_value == 3:
		autosave_interval = 10
	elif config_value == 4:
		autosave_interval = 15
	elif config_value == 5:
		autosave_interval = 30
	elif config_value == 6:
		autosave_interval = 60
	if get_tree().get_current_scene().get_name() == "Main Menu":
		return
	var timer = get_tree().get_root().get_node('Game/Autosave')
	if autosave_interval == 0:
		timer.stop()
	else:
		timer.wait_time = autosave_interval * 60
		timer.start()

func autosave():
	get_tree().set_pause(true)
	save_game(save_slot)
	get_tree().set_pause(false)

func check_config():
	var file = config.load('user://config.cfg')
	if file == OK:
		return
	else:
		config.set_value("confirmation", "skip", false)
		config.save('user://config.cfg')

func list_contents(path:String):
	var dir = Directory.new()
	if not dir.dir_exists(path):
		return
	var files = []
	dir.open(path)
	dir.list_dir_begin()
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(file)
	dir.list_dir_end()
	return files

func create_directory(path):
	var dir = Directory.new()
	if not dir.dir_exists(path):
		dir.make_dir_recursive(path)

func copy_directory(source_path:String,destination_path:String):
	var dir = Directory.new()
	create_directory(destination_path)
	for item in list_contents(source_path):
		var source_item = source_path+"/"+item
		var destination_item = destination_path+"/"+item
		if dir.file_exists(source_item):
			dir.copy(source_item,destination_item)
		elif dir.dir_exists(source_item):
			copy_directory(source_item,destination_item)

func delete(path:String):
	var dir = Directory.new()
	if !dir.file_exists(path) and !dir.dir_exists(path):
		return
	if dir.dir_exists(path):
		for item in list_contents(path):
			var item_path = path+"/"+item
			if dir.file_exists(item_path):
				dir.remove(item_path)
			elif dir.dir_exists(item_path):
				delete(item_path)
	dir.remove(path)

func json_parse(path:String):
	var file = File.new()
	if file.file_exists(path):
		file.open(path,File.READ)
		var _data = file.get_as_text()
		file.close()
		var parsed = JSON.parse(_data)
		return parsed.result

func obj_to_dict(object):
	var properties_full = object.get_property_list()
	var property_list = []
	for index in properties_full.size():
		property_list.append(properties_full[index].name)
	var slice = property_list.find('Script Variables') + 1
	var properties = {}
	for index in range(slice,property_list.size()):
		properties[property_list[index]] = object.get(property_list[index])
	var nodes = []
	for item in properties:
		if typeof(properties[item]) == TYPE_OBJECT:
			if properties[item].is_class("Node"):
				nodes.append(item)
			else:
				properties[item] = obj_to_dict(properties[item])
	for item in nodes:
		properties.erase(item)
	return properties

func dict_to_obj(dictionary,object):
	for item in dictionary:
		if item in object:
			if dictionary[item] is Dictionary and object[item] is Object:
				dict_to_obj(dictionary[item],object[item])
			else:
				object[item] = dictionary[item]

func check_save(arcology,player,index):
	#check folder structure
	#check index
	#check arcology
	#check player
	#check slaves available
		#check km
		#check neighboring
	#check slaves owned
	var OK = true
	if not index:
		print("MISSING INDEX")
		OK = false
	if not player:
		print("MISSING PLAYER")
		OK = false
	if player:
		if not player.has('money'):
			print("MISSING PLAYER MONEY")
			OK = false
	if not arcology:
		print("MISSING ARCOLOGY")
		OK = false
	if arcology:
		if not arcology.has('name'):
			print("MISSING ARCOLOGY NAME")
			OK = false
		if not arcology.has('location'):
			print("MISSING ARCOLOGY LOCATION")
			OK = false
		if not arcology.has('structure'):
			print("MISSING ARCOLOGY STRUCTURE")
			OK = false
	return OK

func index():
	var dt = OS.get_datetime()
	return {
		os_date = str(dt['month']) +"/"+ str(dt['day']) +"/"+ str(dt['year']),
		os_time = str(dt['hour']) +":"+ str(dt['minute']),
		second = time.second,
		minute = time.minute,
		hour = time.hour,
		day = time.day,
		week = time.week,
		quarter = time.quarter,
		year = time.year,
		total_weeks = time.total_weeks}

func save_game(slot):
	var file = File.new()
	var data_slot = 'user://Data/Slot %s'%slot
#	check_dir('user://Data/Slot %s/Finance'%slot,"Finance")
#	check_dir('user://Data/Slot %s/Market'%slot,"Market")
#	create_directory(data_slot+'/Slaves/Owned')
#	create_directory(data_slot+'/Slaves/Markets/Kidnappers Market')
#	create_directory(data_slot+'/Slaves/Markets/Neighboring Arcologies')

	create_directory(data_slot)

	file.open(data_slot+'/Index.json',File.WRITE)
	file.store_line(JSON.print(index()," "))
	file.close()

	var player_data = {money = game.money}
	file.open(data_slot+'/Player.json',File.WRITE)
	file.store_line(JSON.print(player_data," "))
	file.close()

	var arcology_data = game.arcology._data()
	file.open(data_slot+'/Arcology.json',File.WRITE)
	file.store_line(JSON.print(arcology_data," "))
	file.close()

#	var finance_data
#	if get_tree().get_root().get_node('Game/Finance'):
#		finance_data = get_tree().get_root().get_node('Game/Finance')._save()
#	file.open('user://Data/Slot %s/Finance/Index.json'%slot,File.WRITE)
#	file.store_line(to_json(finance_data))
#	file.close()

	create_directory(data_slot+'/Slaves/Owned')
	var owned_slaves = game.slaves.get_node('Collections/Owned')
	var file_path = data_slot+'/Slaves/Owned/%s.json'
	for _slave in owned_slaves.get_children():
		file.open(file_path%_slave.name,File.WRITE)
		file.store_line(JSON.print(_slave._data()," "))
		file.close()

#	var kidnappers_market = collections.get_node('Kidnappers Market')
#	slave_file_path = slaves_path+"/Available/Kidnappers Market/%s.json"
#	if active_collection != 'Kidnappers Market':
#		slaves.load_collection('Kidnappers Market')
#	for _slave in kidnappers_market.get_children():
#		file.open(slave_file_path%_slave.name,File.WRITE)
#		file.store_line(JSON.print(_slave._data()," "))
#		file.close()
#	if active_collection != 'Kidnappers Market':
#		slaves.unload_collection('Kidnappers Market')

#	var neighboring_arcologies = collections.get_node('Neighboring Arcologies')
#	slave_file_path = slaves_path+"/Available/Neighboring Arcologies/%s.json"
#	if active_collection != 'Neighboring Arcologies':
#		slaves.load_collection('Neighboring Arcologies')
#	for _slave in neighboring_arcologies.get_children():
#		file.open(slave_file_path%_slave.name,File.WRITE)
#		file.store_line(JSON.print(_slave._data()," "))
#		file.close()
#	if active_collection != 'Neighboring Arcologies':
#		slaves.unload_collection('Neighboring Arcologies')

func load_game(slot,write=false):
	var data_slot = 'user://Data/Slot %s'%slot
	var index = json_parse(data_slot+'/Index.json')
	var player = json_parse(data_slot+'/Player.json')
	var arcology = json_parse(data_slot+'/Arcology.json')
	#var finance = json_parse('user://Data/Slot %s/Finance/Index.json'%slot)

	if not index or not player or not arcology:
		return

	if not check_save(arcology,player,index):
		print("FAILED TO LOAD GAME IN SLOT ",slot)
		return

	var _data = {
		arcology = arcology,
		player = player,
		index = index}
		#finance = finance}

	if write:
		time.second = _data['index']['second']
		time.minute = _data['index']['minute']
		time.hour = _data['index']['hour']
		time.day = _data['index']['day']
		time.week = _data['index']['week']
		time.quarter = _data['index']['quarter']
		time.year = _data['index']['year']
		time.total_weeks = _data['index']['total_weeks']
		
		var current_scene = get_tree().get_current_scene()
		var main_scene = load('res://Game.tscn').instance()
		current_scene.set_name("queued")
		current_scene.queue_free()
		get_tree().get_root().add_child(main_scene)
		get_tree().set_current_scene(main_scene)
		get_tree().set_pause(false)

		game.set_bg_color(game.BG_COLOR_DEFAULT)
		game.gui.get_node('Navigation/Time').update_time()
		game.money = _data['player']['money']
		game.update_money(0)                                                    #refresh money display

		game.arcology.location = _data['arcology']['name']
		game.arcology.location = _data['arcology']['location']
		game.arcology._load(_data['arcology']['structure'])

#		get_tree().get_root().get_node('Game/Finance').capital = _data['finance']['capital']
#		get_tree().get_root().get_node('Game/Finance').income = _data['finance']['income']
#		get_tree().get_root().get_node('Game/Finance').expenses = _data['finance']['expenses']

		var owned_slaves = game.slaves.get_node('Collections/Owned')
		for _slave in owned_slaves.get_children():
			owned_slaves.remove_child(_slave)
			_slave.queue_free()
		for file in list_contents(data_slot+'/Slaves/Owned'):
			var slave_data = json_parse(data_slot+'/Slaves/Owned/%s'%file)
			var _slave = load('res://Slaves/Slave.tscn').instance()
			_slave.name = file.get_basename()
			_slave._load(slave_data)
			owned_slaves.add_child(_slave,true)
		game.slaves.update_collection(owned_slaves)
		game.slaves.set_active_collection("Owned")
		game.gui.get_node("SidePanel/ManageSlaves").refresh()
	return(_data)
