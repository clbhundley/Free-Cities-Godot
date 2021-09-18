extends Control

var capital = abs(game.gaussian(20000,2000))
var income = 0
var expenses = 0

func _ready():
	get_tree().get_root().get_node('Game/Clock').connect('timeout',self,'second')
	game.connect('minute',self,'minute')
	money(0)

onready var index = load('res://Finance/index.gd').index
func second():
	for key in index.keys():
		store_address('user://Data/Slot %s/Market/'%game.data_slot+key+'.a32',round(abs(index[key]['origin']+market())))

func minute():
	store_address('user://Data/Slot %s/Finance/Capital.a64'%game.data_slot,capital)
	store_address('user://Data/Slot %s/Finance/Income.a64'%game.data_slot,income)
	store_address('user://Data/Slot %s/Finance/Expenses.a64'%game.data_slot,expenses)
	income = 0
	expenses = 0

func money(value):
	var label = get_tree().get_root().get_node('Game/GUI/Money/Capital')
	if value > 0:
		income += value
		capital += value
	elif value < 0:
		expenses += abs(value)
		capital -= abs(value)
	label.set_text("¤"+str(capital))
	quick_save()

onready var market_forces = get_node('Market Forces').get_children()
func market():
	var market = 0
	for force in market_forces:
		market += force.frame()
	return market

func store_address(path,value):
	var file = File.new()
	var buffer = int(path.right(path.length()-2))
	if file.file_exists(path):
		file.open(path,file.READ_WRITE)
	else:
		file.open(path,file.WRITE)
	file.seek_end()
	if buffer == 32:
		file.store_32(value)
	elif buffer == 64:
		file.store_64(value)
	file.close()

func _on_The_Open_Market_mouse_entered():
	get_node('Main/Buttons/The Open Market/Center Container/Label').set_modulate('ff7200')
	get_node('Main/Buttons/The Open Market').set_self_modulate('141a26')

func _on_The_Open_Market_mouse_exited():
	get_node('Main/Buttons/The Open Market/Center Container/Label').set_modulate('ffffff')
	get_node('Main/Buttons/The Open Market').set_self_modulate('95141a26')

func _on_The_Open_Market_pressed():
	get_tree().get_root().get_node('Game/Background').color_filter('82000d13')
	_on_The_Open_Market_mouse_exited()
	get_node('Market').show()
	get_node('Main').hide()

func quick_save():
	var file = File.new()
	var path = 'user://Data/Slot %s/Finance/Index.json'%game.data_slot
	file.open(path,File.WRITE)
	file.store_line(to_json(_save()))
	file.close()

func _save():
	return {
		capital = capital,
		income = income,
		expenses = expenses}

func reset_scene():
	get_tree().get_root().get_node('Game/Background').color_filter('82000f00')
	get_node('Market').hide()
	get_node('Main').show()
