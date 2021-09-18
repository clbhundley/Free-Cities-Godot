extends Control

onready var panel = get_node("Panel")
onready var _slave = get_parent()

func _input(event):
	if event.is_action_pressed('ui_back'):
		panel.hide()
	if is_visible_in_tree():
		if event is InputEventMouseButton:
			var mouse_pos_x = get_local_mouse_position().x
			var mouse_pos_y = get_local_mouse_position().y
			if mouse_pos_x < 0 or mouse_pos_y < 0:
				panel.hide()
			if mouse_pos_x > rect_size.x or mouse_pos_y > rect_size.y:
				panel.hide()

func _on_Top_pressed():
	panel.show()

func _on_Top_mouse_entered():
	$Top.set_modulate('ff7200')

func _on_Top_mouse_exited():
	$Top.set_modulate('ffffff')

func _on_Assignment_item_selected(ID):
	var assignments = {0:"Resting",1:"Prostitute"}
	_slave.assignment = assignments[ID]
	_slave.get_node("Assignments/"+_slave.assignment).begin()

func _on_Purchase_pressed():
	game.update_money(-_slave.market_price())
	var parent_container = get_node('../../')
	var path:String = "user://Data/Slot %s/Slaves"%data.save_slot
	match parent_container.name:
		'Owned':
			path += "/Owned/"
		'Kidnappers Market':
			path += "/Markets/Kidnappers Market/%s.json"%_slave.name
		'Neighboring Arcologies':
			path += "/Markets/Neighboring Arcologies/%s.json"%_slave.name
	Directory.new().remove(path)
	$Panel.hide()
	$Panel/Buttons.show()
	$Panel/SellingButtons.hide()
	parent_container.remove_child(_slave)
	_slave.acquired = time.get_timestamp()
	_slave.for_sale = false
	SlaveUtils.get_owned_slaves().add_child(_slave,true)
	_slave.activate()
	game.slaves.update_collection(game.slaves.active_collection)
	game.gui.get_node("SidePanel/ManageSlaves").refresh()
	game.slaves.update_header()
	var pos = SlaveUtils.slave_count(game.slaves.active_collection.name)*5+0.7
	game.slaves.max_camera_pos = pos
	if SlaveUtils.slave_count(game.slaves.active_collection.name) == 1:
		game.slaves.max_camera_pos *= 1.3
	game.slaves.clamp_camera_position()
	game.slaves.slide_camera()
	hide()

func _on_Sell_pressed():
	if SlaveUtils.slave_count("Owned") <= 1:
		return
	_slave.deactivate()
	var dir = Directory.new()
	var slave_path = "user://Data/Slot %s/Slaves/Owned/%s.json"
	dir.remove(slave_path%[data.save_slot,_slave.name])
	var buyer_price = clamp(math.gaussian_float(10,1),8,12) #change to selection
	var price = buyer_price * _slave.level * game.slaves.price
	game.update_money(price)
	get_node("../../").remove_child(_slave)
	_slave.queue_free()
	game.slaves.update_collection(game.slaves.active_collection)
	game.slaves.update_header()
	var pos = SlaveUtils.slave_count(game.slaves.active_collection.name)*5+0.7
	game.slaves.max_camera_pos = pos
	if SlaveUtils.slave_count(game.slaves.active_collection.name) == 1:
		game.slaves.max_camera_pos *= 1.3
	game.slaves.clamp_camera_position()
	game.slaves.slide_camera()

func _on_Examine_pressed():
	for node in get_tree().get_nodes_in_group("Slave UI"):
		if node.is_visible_in_tree():
			node.add_to_group("Active Slaves")
			node.hide()
	for node in get_tree().get_nodes_in_group("Slaves"):
		if node.is_visible_in_tree():
			node.add_to_group("Active Slaves")
			node.hide()
	_slave.get_node("Camera").activate()
	_slave.show()
	panel.hide()
