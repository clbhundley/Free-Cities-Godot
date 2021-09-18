extends Spatial

func market_directory(market_name):
	return "user://Data/Slot %s/Slaves/Markets/%s"%[data.save_slot,market_name]

func retrieve_index(market_name):
	var index:String = "user://Data/Slot %s/Slaves/Index.json"%data.save_slot
	var index_data = data.json_parse(index)
	if index_data is Dictionary and index_data['markets'].has(market_name):
		var market = index_data['markets'][market_name]
		if market.has('last delivery'):
			set('last_delivery',market['last delivery'])
		if market.has('next delivery'):
			set('next_delivery',market['next delivery'])
		if market.has('next depletion'):
			set('next_depletion',market['next depletion'])

func update_index(market_name):
	var index:String = "user://Data/Slot %s/Slaves/Index.json"%data.save_slot
	var index_data = data.json_parse(index)
	if not index_data is Dictionary:
		index_data = {}
	if not index_data.has('markets'):
		index_data['markets'] = {}
	if not index_data['markets'].has(market_name):
		index_data['markets'][market_name] = {}
	var market = index_data['markets'][market_name]
	market['last delivery'] = get('last_delivery')
	market['next delivery'] = get('next_delivery')
	market['next depletion'] = get('next_depletion')
	var file = File.new()
	file.open(index,File.WRITE)
	file.store_line(JSON.print(index_data," "))
	file.close()

func create_new_slave(market_name,preset=null):
	var new_slave = game.slaves.get_node('New Slave')
	var _slave = new_slave.new(preset,true)
	var slave_file = market_directory(market_name)+"/%s.json"%_slave.name
	var file = File.new()
	file.open(slave_file,File.WRITE)
	file.store_line(JSON.print(_slave._data(true)," "))
	file.close()
	_slave.queue_free()

var signals = ['second','minute','hour','day','week','quarter','year']

func advance_delivery(market):
	if time.is_due(get('next_delivery')):
		disconnect_all_signals(market,'advance_delivery')
		market.delivery()
		return
	var unit_remaining:String
	var current_time = time.get_timestamp()
	for time_unit in signals:
		if current_time[time_unit] < get('next_delivery')[time_unit]:
			unit_remaining = time_unit
	if unit_remaining:
		if not time.is_connected(unit_remaining,market,'advance_delivery'):
			time.connect(unit_remaining,market,'advance_delivery',[market])

func advance_depletion(market):
	if time.is_due(get('next_depletion')):
		disconnect_all_signals(market,'advance_depletion')
		market.depletion()
		return
	var unit_remaining:String
	var current_time = time.get_timestamp()
	for time_unit in signals:
		if current_time[time_unit] < get('next_depletion')[time_unit]:
			unit_remaining = time_unit
	if unit_remaining:
		if not time.is_connected(unit_remaining,market,'advance_depletion'):
			time.connect(unit_remaining,market,'advance_depletion',[market])

func disconnect_all_signals(market:Node,method:String):
	for time_unit in signals:
		if time.is_connected(time_unit,market,method):
			time.disconnect(time_unit,market,method)
