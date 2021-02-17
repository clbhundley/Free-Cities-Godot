extends Node

onready var slave_ui = get_parent()
onready var slaves = SlaveUtils.get_slave_scene()
onready var panel = get_node("../Panel")
onready var _slave = owner.owner

func _input(event):
	if event.is_action_pressed('ui_back'):
		panel.hide()
	if slave_ui.is_visible_in_tree():
		if event is InputEventMouseButton:
			var mouse_pos_x = slave_ui.get_local_mouse_position().x
			var mouse_pos_y = slave_ui.get_local_mouse_position().y
			if mouse_pos_x < 0 or mouse_pos_y < 0:
				panel.hide()
			if mouse_pos_x > slave_ui.rect_size.x or mouse_pos_y > slave_ui.rect_size.y:
				panel.hide()

func _on_Top_pressed():
	panel.show()

func _on_Top_mouse_entered():
	get_node("../Top").set_modulate('ff7200')

func _on_Top_mouse_exited():
	get_node("../Top").set_modulate('ffffff')

func _on_Assignment_item_selected(ID):
	var assignments = {0:"Resting",1:"Prostitute"}
	_slave.assignment = assignments[ID]
	_slave.get_node("Scripts/Assignments/"+_slave.assignment).begin()

func _on_Buy_pressed():
	var path
	var dir = Directory.new()
	var parent_container = get_node('../../../')
	#change folder names to match nodes and input _location directly here
	if parent_container.name == "Owned":
		path = 'user://Data/Slot %s/Slaves/Owned/'%data.save_slot
	elif parent_container.name == "Kidnappers Market":
		path = "user://Data/Slot %s/Slaves/Available/Kidnappers' Market/"%data.save_slot
	elif parent_container.name == "Neighboring Arcologies":
		path = 'user://Data/Slot %s/Slaves/Available/Neighboring Arcologies/'%data.save_slot
	path += _slave.name+'.json'
	dir.remove(path)
	_slave.for_sale = false
	get_node('../Panel').hide()
	get_node('../Panel/Buttons').show()
	get_node('../Panel/Selling Buttons').hide()
	parent_container.remove_child(_slave)
	_slave.acquired = time.get_timestamp()
	SlaveUtils.get_owned_slaves().add_child(_slave,true)
	slaves.update_collection(slaves.active_collection)
	game.get_gui().get_node("SidePanel/ManageSlaves").update()
	slaves.update_header()
	slaves.max_camera_pos = SlaveUtils.slave_count(slaves.active_collection.name)*5+0.7
	if SlaveUtils.slave_count(slaves.active_collection.name) == 1:
		slaves.max_camera_pos *= 1.3
	slaves.clamp_camera_position()
	slaves.slide_camera()
	slave_ui.hide()

func _on_Sell_pressed():
	var dir = Directory.new()
	if SlaveUtils.slave_count("Owned") <= 1:
		return
	dir.remove('user://Data/Slot %s/Slaves/Owned/%s.json'%[data.save_slot,_slave.name])
	game.update_money(200 * _slave.get_node('Scripts/Stats')._level())
	get_node("../../../").remove_child(_slave)
	_slave.queue_free()
	slaves.update_collection(slaves.active_collection)
	slaves.update_header()
	slaves.max_camera_pos = SlaveUtils.slave_count(slaves.active_collection.name)*5+0.7
	if SlaveUtils.slave_count(slaves.active_collection.name) == 1:
		slaves.max_camera_pos *= 1.3
	slaves.clamp_camera_position()
	slaves.slide_camera()

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
