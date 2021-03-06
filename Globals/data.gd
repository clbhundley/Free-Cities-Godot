extends Node

var save_slot # currently active save slot
var config = ConfigFile.new()
var autosave_interval

# add proper error handling for these functions!

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

func quick_save(): #!needs repurpose!
	var file = File.new()
	var index = 'user://Data/Slot %s/Index.json'%save_slot
	file.open(index,File.WRITE)
	file.store_line(JSON.print(index()," "))
	file.close()

func save_game(slot): #only used on new game creation?
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
	file.store_line(JSON.print(index()," "))
	file.close()
	
	var player_data = {money = game.money}
	file.open('user://Data/Slot %s/Player.json'%slot,File.WRITE)
	file.store_line(JSON.print(player_data," "))
	file.close()
	
	var arcology_data
	if get_tree().get_root().get_node('Game/Arcology'):
		arcology_data = get_tree().get_root().get_node('Game/Arcology')._data()
	file.open('user://Data/Slot %s/Arcology.json'%slot,File.WRITE)
	file.store_line(JSON.print(arcology_data," "))
	file.close()
	
#	var finance_data
#	if get_tree().get_root().get_node('Game/Finance'):
#		finance_data = get_tree().get_root().get_node('Game/Finance')._save()
#	file.open('user://Data/Slot %s/Finance/Index.json'%slot,File.WRITE)
#	file.store_line(to_json(finance_data))
#	file.close()
	
	var owned_slaves = get_tree().get_root().get_node('Game/Slaves/Collections/Owned')
	if owned_slaves:
		for _slave in owned_slaves.get_children():
			file.open('user://Data/Slot %s/Slaves/Owned/%s.json'%[slot,_slave.name],File.WRITE)
			file.store_line(JSON.print(_slave._data()," "))
			file.close()
	
	var kidnappers_market = get_tree().get_root().get_node('Game/Slaves/Collections/Kidnappers Market')
	if kidnappers_market:
		for _slave in kidnappers_market.get_children():
			file.open("user://Data/Slot %s/Slaves/Available/Kidnappers' Market/%s.json"%[slot,_slave.name],File.WRITE)
			file.store_line(JSON.print(_slave._data()," "))
			file.close()
	
	var neighboring_arcologies = get_tree().get_root().get_node('Game/Slaves/Collections/Neighboring Arcologies')
	if neighboring_arcologies:
		for _slave in neighboring_arcologies.get_children():
			file.open('user://Data/Slot %s/Slaves/Available/Neighboring Arcologies/%s.json'%[slot,_slave.name],File.WRITE)
			file.store_line(JSON.print(_slave._data()," "))
			file.close()

func load_game(slot,write=false):
	var index = json_parse('user://Data/Slot %s/Index.json'%slot)
	var player = json_parse('user://Data/Slot %s/Player.json'%slot)
	var arcology = json_parse('user://Data/Slot %s/Arcology.json'%slot)
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
		time.total_weeks = _data['index']['total_weeks']
		get_tree().get_root().get_node('Game/GUI/Navigation/Time').update_time()
		
		game.money = _data['player']['money']
		game.update_money(0)                                                    #refresh money display
		
		get_tree().get_root().get_node('Game/Arcology').location = _data['arcology']['name']
		get_tree().get_root().get_node('Game/Arcology').location = _data['arcology']['location']
		get_tree().get_root().get_node('Game/Arcology')._load(_data['arcology']['structure'])
		
#		get_tree().get_root().get_node('Game/Finance').capital = _data['finance']['capital']
#		get_tree().get_root().get_node('Game/Finance').income = _data['finance']['income']
#		get_tree().get_root().get_node('Game/Finance').expenses = _data['finance']['expenses']
		
		var slaves = get_tree().get_root().get_node('Game/Slaves')
		var side_panel = game.get_gui().get_node("SidePanel")
		
		var owned_slaves = slaves.get_node('Collections/Owned')
		for child in owned_slaves.get_children():
			owned_slaves.remove_child(child)
			child.queue_free()
		for file in list_files('user://Data/Slot %s/Slaves/Owned'%slot):
			var slave_data = json_parse('user://Data/Slot %s/Slaves/Owned/%s'%[slot,file])
			var _slave = load('res://Slaves/Slave.tscn').instance()
			_slave.name = file.get_basename()
			_slave._load(slave_data)
			owned_slaves.add_child(_slave,true)
		slaves.update_collection(owned_slaves)
		side_panel.get_node("ManageSlaves").update()
		
		var kidnappers_market = slaves.get_node('Collections/Kidnappers Market')
		for child in kidnappers_market.get_children():
			kidnappers_market.remove_child(child)
			child.queue_free()
		for file in list_files("user://Data/Slot %s/Slaves/Available/Kidnappers' Market"%slot):
			var slave_data = json_parse("user://Data/Slot %s/Slaves/Available/Kidnappers' Market/%s"%[slot,file])
			var _slave = load('res://Slaves/Slave.tscn').instance()
			_slave.name = file.get_basename()
			_slave._load(slave_data)
			kidnappers_market.add_child(_slave,true)
		slaves.update_collection(kidnappers_market)
		side_panel.get_node("KidnappersMarket").update()
		
		var neighboring_arcologies = slaves.get_node('Collections/Neighboring Arcologies')
		for child in neighboring_arcologies.get_children():
			neighboring_arcologies.remove_child(child)
			child.queue_free()
		for file in list_files('user://Data/Slot %s/Slaves/Available/Neighboring Arcologies'%slot):
			var slave_data = json_parse('user://Data/Slot %s/Slaves/Available/Neighboring Arcologies/%s'%[slot,file])
			if slave_data: #why check if slave data exists here?
				var _slave = load('res://Slaves/Slave.tscn').instance()
				_slave.name = file.get_basename()
				_slave._load(slave_data)
				neighboring_arcologies.add_child(_slave,true)
			slaves.update_collection(neighboring_arcologies)
			side_panel.get_node("NeighboringArcologies").update()
		
		slaves.set_active_collection("Owned")
		game.set_bg_color(game.BG_COLOR_DEFAULT)
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
