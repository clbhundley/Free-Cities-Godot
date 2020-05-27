extends Node

var save_slot # currently active save slot
var config = ConfigFile.new()

# add proper error handling for these functions!

func check_config():
	var file = config.load('user://config.cfg')
	if file == OK:
		return
	else:
		config.set_value("confirmation", "skip", false)
		config.save('user://config.cfg')

func check_dir(path,directory_name):
	var dir = Directory.new()
	if not dir.dir_exists(path):
		dir.open(path.get_base_dir())
		dir.make_dir(directory_name)

func list_files(path):
	var files = []
	var dir = Directory.new()
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

func json_parse(path):
	var file = File.new()
	if file.file_exists(path):
		file.open(path,File.READ)
		var _data = file.get_as_text()
		file.close()
		var parsed = JSON.parse(_data)
		return parsed.result

func check_save():
	pass
	#check folder structure
	#check index
	#check arcology
	#check player
	#check slaves available
		#check km
		#check neighboring
	#check slaves owned

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
		year = time.year}

func quick_save(): # !repurpose this function!
	var file = File.new()
	var index = 'user://Data/Slot %s/Index.json'%save_slot
	file.open(index,File.WRITE)
	file.store_line(to_json(index()))
	file.close()

func save_game(slot):
	var file = File.new()
	check_dir('user://Data/Slot %s',"Slot %s"%slot)
#	check_dir('user://Data/Slot %s/Finance'%slot,"Finance")
#	check_dir('user://Data/Slot %s/Market'%slot,"Market")
	check_dir('user://Data/Slot %s/Slaves'%slot,"Slaves")
	check_dir('user://Data/Slot %s/Slaves/Owned'%slot,"Owned")
	check_dir('user://Data/Slot %s/Slaves/Available'%slot,"Available")
	check_dir("user://Data/Slot %s/Slaves/Available/Kidnappers' Market"%slot,"Kidnappers' Market")
	check_dir('user://Data/Slot %s/Slaves/Available/Neighboring Arcologies'%slot,"Neighboring Arcologies")
	file.open('user://Data/Slot %s/Index.json'%slot,File.WRITE)
	file.store_line(to_json(index()))
	file.close()
	
	var arcology_data
	if get_tree().get_root().get_node('Game/Arcology'):
		arcology_data = get_tree().get_root().get_node('Game/Arcology')._save()
	file.open('user://Data/Slot %s/Arcology.json'%slot,File.WRITE)
	file.store_line(to_json(arcology_data))
	file.close()
	
#	var finance_data
#	if get_tree().get_root().get_node('Game/Finance'):
#		finance_data = get_tree().get_root().get_node('Game/Finance')._save()
#	file.open('user://Data/Slot %s/Finance/Index.json'%slot,File.WRITE)
#	file.store_line(to_json(finance_data))
#	file.close()
	
	var owned_slaves = []
	if get_tree().get_root().get_node('Game/Slaves/Slider/HBoxContainer'):
		for _slave in get_tree().get_root().get_node('Game/Slaves/Slider/HBoxContainer').get_children():
			owned_slaves.append(_slave._save())
	for i in owned_slaves:
		file.open('user://Data/Slot %s/Slaves/Owned/'%slot+i['core']['name']+'.json',File.WRITE)
		file.store_line(to_json(i))
		file.close()
	var kidnappers_slaves = []
	if get_tree().get_root().get_node('Game/Slaves/Kidnappers Market/Slider/HBoxContainer'):
		for _slave in get_tree().get_root().get_node('Game/Slaves/Kidnappers Market/Slider/HBoxContainer').get_children():
			kidnappers_slaves.append(_slave._save())
	for i in kidnappers_slaves:
		file.open("user://Data/Slot %s/Slaves/Available/Kidnappers' Market/"%slot+i['core']['name']+'.json',File.WRITE)
		file.store_line(to_json(i))
		file.close()
	var neighboring_slaves = []
	if get_tree().get_root().get_node('Game/Slaves/Neighboring Arcologies/Slider/HBoxContainer'):
		for _slave in get_tree().get_root().get_node('Game/Slaves/Neighboring Arcologies/Slider/HBoxContainer').get_children():
			neighboring_slaves.append(_slave._save())
	for i in neighboring_slaves:
		file.open('user://Data/Slot %s/Slaves/Available/Neighboring Arcologies/'%slot+i['core']['name']+'.json',File.WRITE)
		file.store_line(to_json(i))
		file.close()
	
	var player_data = {money = game.money}
	file.open('user://Data/Slot %s/Player.json'%slot,File.WRITE)
	file.store_line(to_json(player_data))
	file.close()

func load_game(slot,write=false):
	#var finance = json_parse('user://Data/Slot %s/Finance/Index.json'%slot)
	var arcology = json_parse('user://Data/Slot %s/Arcology.json'%slot)
	var player = json_parse('user://Data/Slot %s/Player.json'%slot)
	var index = json_parse('user://Data/Slot %s/Index.json'%slot)
	
	
	#move to check save function
	if not arcology:
		#print("MISSING ARCOLOGY")
		print("ARCOLOGY SAVE DATA NOT YET IMPLEMENTED")
		return
	if not arcology['location']:
		print("MISSING ARCOLOGY LOCATION")
		return
	if not arcology['name']:
		print("MISSING ARCOLOGY NAME")
		return
#	if not arcology['structure']:
#		print("MISSING ARCOLOGY STRUCTURE")
#		return
	if not player:
		print("MISSING PLAYER")
		return
	if not player['money']:
		print("MISSING PLAYER MONEY")
		return
	if not index:
		print("MISSING INDEX")
		return
	
	var _data = {
		arcology = arcology,
		player = player,
		index = index}
		#finance = finance}
	
	if write:
		var current_scene = get_tree().get_current_scene()
		var main_scene = load('res://Game.tscn').instance()
		current_scene.set_name("queued")
		current_scene.queue_free()
		get_tree().get_root().add_child(main_scene)
		get_tree().set_current_scene(main_scene)
		get_tree().set_pause(false)
		time.second = _data['index']['second']
		time.minute = _data['index']['minute']
		time.hour = _data['index']['hour']
		time.day = _data['index']['day']
		time.week = _data['index']['week']
		time.quarter = _data['index']['quarter']
		time.year = _data['index']['year']
		get_tree().get_root().get_node('Game/GUI/Time').update_time()
		
		#add arcology name
		get_tree().get_root().get_node('Game/Arcology').location = _data['arcology']['location']
		get_tree().get_root().get_node('Game/Arcology').structure_data = _data['arcology']['structure_data']
		
#		get_tree().get_root().get_node('Game/Finance').capital = _data['finance']['capital']
#		get_tree().get_root().get_node('Game/Finance').income = _data['finance']['income']
#		get_tree().get_root().get_node('Game/Finance').expenses = _data['finance']['expenses']
		
		game.money = _data['player']['money']
		game.update_money(0)
		
		var owned_slaves = get_tree().get_root().get_node('Game/Slaves/Slider/HBoxContainer')
		for child in owned_slaves.get_children():
			child.free()
		for i in list_files('user://Data/Slot %s/Slaves/Owned'%slot):
			var slave_data = json_parse('user://Data/Slot %s/Slaves/Owned/'%slot+i)
			var _slave = load('res://Slaves/Slave.tscn').instance()
			_slave._load(slave_data)
			owned_slaves.add_child(_slave,true)
		var kidnappers_market = get_tree().get_root().get_node('Game/Slaves/Kidnappers Market/Slider/HBoxContainer')
		for child in kidnappers_market.get_children():
			child.free()
		for i in list_files("user://Data/Slot %s/Slaves/Available/Kidnappers' Market"%slot):
			var slave_data = json_parse("user://Data/Slot %s/Slaves/Available/Kidnappers' Market/"%slot+i)
			var _slave = load('res://Slaves/Slave.tscn').instance()
			_slave._load(slave_data)
			kidnappers_market.add_child(_slave,true)
		var neighboring_arcologies = get_tree().get_root().get_node('Game/Slaves/Neighboring Arcologies/Slider/HBoxContainer')
		for child in neighboring_arcologies.get_children():
			child.free()
		for i in list_files('user://Data/Slot %s/Slaves/Available/Neighboring Arcologies'%slot):
			var slave_data = json_parse('user://Data/Slot %s/Slaves/Available/Neighboring Arcologies/'%slot+i)
			if slave_data:
				var _slave = load('res://Slaves/Slave.tscn').instance()
				_slave._load(slave_data)
				neighboring_arcologies.add_child(_slave,true)
	return(_data)

func delete_game(slot): #make recursive instead of listing each directory
	var dir = Directory.new()
	for i in list_files("user://Data/Slot %s/Slaves/Available/Kidnappers' Market"%slot):
		dir.remove("user://Data/Slot %s/Slaves/Available/Kidnappers' Market/"%slot+i)
	for i in list_files('user://Data/Slot %s/Slaves/Available/Neighboring Arcologies'%slot):
		dir.remove('user://Data/Slot %s/Slaves/Available/Neighboring Arcologies/'%slot+i)
	for i in list_files('user://Data/Slot %s/Slaves/Available'%slot):
		dir.remove('user://Data/Slot %s/Slaves/Available/'%slot+i)
	for i in list_files('user://Data/Slot %s/Slaves/Owned'%slot):
		dir.remove('user://Data/Slot %s/Slaves/Owned/'%slot+i)
	for i in list_files('user://Data/Slot %s/Slaves'%slot):
		dir.remove('user://Data/Slot %s/Slaves/'%slot+i)
#	for i in list_files('user://Data/Slot %s/Finance'%slot):
#		dir.remove('user://Data/Slot %s/Finance/'%slot+i)
#	for i in list_files('user://Data/Slot %s/Market'%slot):
#		dir.remove('user://Data/Slot %s/Market/'%slot+i)
	for i in list_files('user://Data/Slot %s'%slot):
		dir.remove('user://Data/Slot %s/'%slot+i)
	dir.remove('user://Data/Slot %s/'%slot)