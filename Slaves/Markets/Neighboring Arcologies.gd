extends "res://Slaves/Markets/MarketUtils.gd"

var last_delivery:Dictionary
var next_delivery:Dictionary
var next_depletion:Dictionary

func _ready():
	data.create_directory(market_directory(name))
	retrieve_index(name)
	if not last_delivery:
		delivery(true)
	advance_delivery(self)
	if not next_depletion:
		schedule_next_depletion()
	advance_depletion(self)

func market_price_modifier():
	var modifier := 600
	var slaves_in_market = get_children().size()
	if slaves_in_market > 10:
		modifier -= slaves_in_market*10
	return modifier

func delivery(initial=false):
	var delivery_amount = abs(math.gaussian(5,2))
	for _slave in delivery_amount:
		create_new_slave(name,'kidnappers market')
	if not initial:
		NAVI.say(str(delivery_amount)+" slaves delivered to "+name)
	if game.slaves.active_collection:
		if game.slaves.active_collection.name == name:
			game.slaves.set_active_collection(name)
	last_delivery = time.get_timestamp()
	schedule_next_delivery()
	advance_delivery(self)

func schedule_next_delivery():
	var second:int = randi()%60
	var minute:int = randi()%60
	var hour:int = randi()%24
	var day:int = abs(math.gaussian(1,3))
	var week:int = clamp(math.gaussian(1,2),1,2)
	var quarter:int = 0
	var year:int = 0
	next_delivery = time.get_forward_time(
		second,
		minute,
		hour,
		day,
		week,
		quarter,
		year)
	update_index(name)

func depletion():
	var available_slaves = data.list_contents(market_directory(name))
	var depletion_amount = min(available_slaves.size(),abs(math.gaussian(1,1)))
	if depletion_amount != 0:
		available_slaves.shuffle()
		for _slave in depletion_amount:
			data.delete(market_directory(name)+"/"+available_slaves[_slave])
		if game.slaves.active_collection:
			if game.slaves.active_collection.name == name:
				game.slaves.set_active_collection(name)
	schedule_next_depletion()
	advance_depletion(self)

func schedule_next_depletion():
	var second:int = randi()%60
	var minute:int = randi()%60
	var hour:int = randi()%24
	var day:int = abs(math.gaussian(2,2))
	var week:int = 0
	var quarter:int = 0
	var year:int = 0
	next_depletion = time.get_forward_time(
		second,
		minute,
		hour,
		day,
		week,
		quarter,
		year)
	update_index(name)
