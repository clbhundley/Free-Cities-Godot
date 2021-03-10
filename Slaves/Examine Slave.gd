extends Control

onready var root = get_tree().get_root()
onready var slaves = root.get_node("Game/Slaves")
onready var gui = game.get_gui()

var _slave
var previous_dock_mode
var active

#func _ready():
#	root.connect('size_changed',self,'resize')
#	#resize()

var active_input
var model_rotation = 0.0
func _input(event):
	if not is_visible_in_tree():
		return
	if not _slave:
		return
	var mouse_over_ui_panel = game.get_gui().mouse_over_ui_panel()
	if mouse_over_ui_panel and not active_input:
		return
	if Input.is_action_just_pressed("ui_accept") and not mouse_over_ui_panel:
		active_input = true
	elif event.is_action_released("ui_accept"):
		active_input = false
	if event.is_class("InputEventMouseMotion") and active_input:
		if event.button_mask&(BUTTON_MASK_LEFT):
			model_rotation += event.relative.x * 0.009
			_slave.get_node("Model").set_rotation(Vector3(0,model_rotation,0))

func activate(selected_slave):
	active = true
	root.get_node('Game/Clock').connect('timeout',self,'uptate_display')
	previous_dock_mode = game.get_gui().get_node("Dock").mode
	if previous_dock_mode == "ManageSlaves" or previous_dock_mode == "PurchaseSlaves":
		game.get_gui().get_node("Dock").set_mode("ManageSlave")
	else:
		game.get_gui().get_node("Dock").set_mode("PurchaseSlave")
	game.get_gui().get_node("Header").hide()
	for node in $Gauges.get_children():
		node._slave = selected_slave
	_slave = selected_slave
	model_rotation = 0.0
	_slave.get_node("Model").set_rotation(Vector3(0,0,0))
	$Top/Name.set_text(_slave.name)
	uptate_display()
	show()

func deactivate(reset_dock_mode=true):
	active = false
	#game.get_gui().get_node("Dock").set_mode("ManageSlaves")
	for node in get_tree().get_nodes_in_group("Active Slaves"):
		if node.has_method("resize"):
			node.resize(true)
#		if node.has_method("tracking"):
#			node.tracking(true)
	if _slave:
		root.get_node('Game/Clock').disconnect('timeout',self,'uptate_display')
		_slave.get_node("Model").set_rotation(Vector3(0,0,0))
	model_rotation = 0.0
	gui.get_node("Header").show()
	gui.get_node("Dock/ActionButton/Tag").hide()
	for node in $Gauges.get_children():
		node._slave = null
	_slave = null
	if previous_dock_mode != "ManageSlaves" and reset_dock_mode:
		gui.get_node("SidePanel").open()
	if reset_dock_mode:
		gui.get_node("Dock").set_mode(previous_dock_mode,true,false)
	hide()

func uptate_display():
	set_level()
	set_gauges()
	set_activity()
	set_stats_temp()

func set_level():
	get_node('Top/Level').set_text(str(_slave.get_level()))

func set_stats_temp():
	$"Stats Display temp".set_text(JSON.print(_slave._data()," "))

func set_stats():
	pass
#	$"Stats Display/Appearance".set_stats(_slave)
#	$"Stats Display/Basic".set_stats(_slave)
#	$"Stats Display/Sexuality".set_stats(_slave)
#	$"Stats Display/Skills".set_stats(_slave)
#	$"Stats Display/Traits".set_stats(_slave)

func set_gauges():
	$Gauges/Health._set_gauge()
	$Gauges/Happiness._set_gauge()
	$Gauges/Arousal._set_gauge()
	$Gauges/Fatigue._set_gauge()
	$Gauges/Hunger._set_gauge()
	$Gauges/Bathroom._set_gauge()

func set_activity():
	var progress_bar_max_value = _slave.get_node("UI/Activity/ProgressBar").max_value
	var progress_bar_value = _slave.get_node("UI/Activity/ProgressBar").value
	var action_text = _slave.get_node("UI/Activity/Action").get_text()
	var time_text = _slave.get_node("UI/Activity/Time").get_text()
	var location_text = _slave.get_node("UI/Location").get_text()
	$Activity/ProgressBar.max_value = progress_bar_max_value
	$Activity/ProgressBar.value = progress_bar_value
	$Activity/Action.set_text(action_text)
	$Activity/Time.set_text(time_text)
	$Location.set_text(location_text)

func _on_Back_pressed():
	model_rotation = 0.0
	_slave.get_node("Model").set_rotation(Vector3(0,0,0))
	get_viewport().get_camera().deactivate()
	game.get_gui().get_node("Dock/ActionButton/Tag").hide()
	slaves.slide_camera()
#	var gui = game.get_gui()
#	gui.get_node("Dock").resize()
#	gui.get_node("SidePanel").close()

#func resize():
#	#gui.get_node("Dock").resize()
#	return
#	if not is_visible_in_tree():
#		return
#	var scale_y = display.scale_y
#	var scale_adjusted = scale_y*20
#	#game.default_font.size = max(scale_adjusted,12)
#	var baseline = Vector2(450,700)
#	#rect_min_size = Vector2(max(baseline.x*scale_y,270),max(baseline.y*scale_y,420))
#	#rect_size = Vector2(max(baseline.x*scale_y,270),max(baseline.y*scale_y,420))
#	#line and level using same custom font, only one resize needed
#	get_node("Top/Level").get('custom_fonts/font').size = max(scale_adjusted*2,24)
#	get_node("Top/Line").get('custom_fonts/font').size = max(scale_adjusted*2,24)
#	get_node("Top/Name").get('custom_fonts/font').size = max(scale_adjusted*1.5,18)
#	#get_node("Top/Status").get('custom_fonts/font').size = max(scale_adjusted,12)
#	#get_node("Stats Display/Basic").get('custom_fonts/normal_font').size = clamp(scale_adjusted,12,20)
#	#get_node("Gauges/Health/Value").get('custom_fonts/font').size = scale_adjusted*1.2
