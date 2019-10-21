extends Node

var divino = preload('res://divino.gd')
var config = ConfigFile.new()
var data_slot
var queue_save

func _ready():
	randomize()
	check_config()
	check_dir('user://Data',"Data")

func is_ready():
	if queue_save:
		queue_save = false
		save_game(data_slot)
		for nodes in get_tree().get_root().get_node('Game/GUI/Pause Menu/Saves/Panel/Slots').get_children():
			nodes._ready()

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

func roll(faces): #supported inputs: 2,3,4,5,6,8,9,10,12
	return divino.dice(faces)

func gaussian(mean,deviation):
	randomize()
	var x1
	var x2
	var w
	while true:
		x1 = rand_range(0, 2) - 1
		x2 = rand_range(0, 2) - 1
		w = x1*x1 + x2*x2
		if 0 < w and w < 1:
			break
	w = sqrt(-2 * log(w)/w)
	return floor(mean + deviation * x1 * w)

func money(value):
	var f = get_tree().get_root().get_node('Game/Finance')
	f.money(value)

func time_remaining(time,total_time):
	var _sec = total_time-time
	var _min = int(_sec/60)
	var _hr = int(_min/60)
	_hr = int(_min/60)
	_min = int(_sec/60)
	return str(_hr,":",_min-_hr*60,":",_sec-_min*60)

func quick_save():
	var file = File.new()
	var path = 'user://Data/Slot %s/Index.json'%game.data_slot
	file.open(path,File.WRITE)
	file.store_line(to_json(index()))
	file.close()

func index():
	var dt = OS.get_datetime()
	return {
		os_date = str(dt['month']) +"/"+ str(dt['day']) +"/"+ str(dt['year']),
		os_time = str(dt['hour']) +":"+ str(dt['minute']),
		second = get_tree().get_root().get_node('Game').second,
		minute = get_tree().get_root().get_node('Game').minute,
		hour = get_tree().get_root().get_node('Game').hour,
		day = get_tree().get_root().get_node('Game').day,
		week = get_tree().get_root().get_node('Game').week,
		quarter = get_tree().get_root().get_node('Game').quarter,
		year = get_tree().get_root().get_node('Game').year}

func save_game(slot):
	var file = File.new()
	check_dir('user://Data/Slot %s',"Slot %s"%slot)
	check_dir('user://Data/Slot %s/Finance'%slot,"Finance")
	check_dir('user://Data/Slot %s/Market'%slot,"Market")
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
	var finance_data
	if get_tree().get_root().get_node('Game/Finance'):
		finance_data = get_tree().get_root().get_node('Game/Finance')._save()
	file.open('user://Data/Slot %s/Finance/Index.json'%slot,File.WRITE)
	file.store_line(to_json(finance_data))
	file.close()
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
	var player_data
	file.open('user://Data/Slot %s/Player.json'%slot,File.WRITE)
	file.store_line(to_json(player_data))
	file.close()

func load_game(slot,write=false):
	var index = json_parse('user://Data/Slot %s/Index.json'%slot)
	var arcology = json_parse('user://Data/Slot %s/Arcology.json'%slot)
	var finance = json_parse('user://Data/Slot %s/Finance/Index.json'%slot)
	var player = json_parse('user://Data/Slot %s/Player.json'%slot)
	var data
	if index:
		data = {
		index = index,
		arcology = arcology,
		finance = finance,
		player = player}
	if write:
		var current_scene = get_tree().get_current_scene()
		var main_scene = load('res://Game.tscn').instance()
		current_scene.set_name("queued")
		current_scene.queue_free()
		get_tree().get_root().add_child(main_scene)
		get_tree().set_current_scene(main_scene)
		get_tree().set_pause(false)
		get_tree().get_root().get_node('Game').second = data['index']['second']
		get_tree().get_root().get_node('Game').minute = data['index']['minute']
		get_tree().get_root().get_node('Game').hour = data['index']['hour']
		get_tree().get_root().get_node('Game').day = data['index']['day']
		get_tree().get_root().get_node('Game').week = data['index']['week']
		get_tree().get_root().get_node('Game').quarter = data['index']['quarter']
		get_tree().get_root().get_node('Game').year = data['index']['year']
		get_tree().get_root().get_node('Game/GUI/Time').update_time()
		get_tree().get_root().get_node('Game/Arcology').location = data['arcology']['location']
		get_tree().get_root().get_node('Game/Arcology').structure_data = data['arcology']['structure_data']
		get_tree().get_root().get_node('Game/Finance').capital = data['finance']['capital']
		get_tree().get_root().get_node('Game/Finance').income = data['finance']['income']
		get_tree().get_root().get_node('Game/Finance').expenses = data['finance']['expenses']
		money(0)
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
	return(data)

func delete_game(slot):
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
	for i in list_files('user://Data/Slot %s/Finance'%slot):
		dir.remove('user://Data/Slot %s/Finance/'%slot+i)
	for i in list_files('user://Data/Slot %s/Market'%slot):
		dir.remove('user://Data/Slot %s/Market/'%slot+i)
	for i in list_files('user://Data/Slot %s'%slot):
		dir.remove('user://Data/Slot %s/'%slot+i)
	dir.remove('user://Data/Slot %s/'%slot)

func json_parse(path):
	var file = File.new()
	if file.file_exists(path):
		file.open(path,File.READ)
		var data = file.get_as_text()
		file.close()
		var parsed = JSON.parse(data)
		return parsed.result

var second = randi()%60
var minute = randi()%60
var hour = randi()%24
var day = randi()%7
var week = 0
var quarter = 0
var year = 2119
signal minute
signal hour
signal day
signal week
func _on_Clock_timeout():
	second += 1
	if second == 60:
		emit_signal('minute')
		second = 0
		minute += 1
	if minute == 60:
		emit_signal('hour')
		minute = 0
		hour += 1
	if hour == 24:
		emit_signal('day')
		hour = 0
		day += 1
	if day == 7:
		emit_signal('week')
		day = 0
		week += 1
	if week  == 13:
		week = 0
		quarter += 1
	if quarter == 4:
		quarter = 0
		year += 1
	quick_save()
