extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

# onready var creates the variable when "func _ready()" is executed.
onready var slavesnew = {}
onready var slavelistnew = []
onready var newslavecontainer = get_node("/root/Game/Control/UI/uidisplay/BuySlavePanel/NewSlaveContainer")
onready var rand_name = null
onready var age_gen = null
onready var rand_haircolor = null
onready var slave_info = get_node("/root/Game/Control/UI/uidisplay/Slave Info")
onready var buyslavepanel = get_node("/root/Game/Control/UI/uidisplay/BuySlavePanel")
onready var buy_slaves = get_node("/root/Game/Control/UI/uidisplay/Buy Slaves")
onready var newslaveinfo = get_node("/root/Game/Control/UI/uidisplay/BuySlavePanel/newslaveinfo")
onready var generate_slave = get_node("/root/Game/Control/UI/uidisplay/BuySlavePanel/Generate Slave")
onready var add_slave = get_node("/root/Game/Control/UI/uidisplay/BuySlavePanel/Add Slave")
onready var finished = get_node("/root/Game/Control/UI/uidisplay/Finished")
onready var slavehbox = get_node("/root/Game/Control/UI/SlavesDisplay/ButtonIndex/SlaveHBox")
onready var buttonindex = get_node("/root/Game/Control/UI/SlavesDisplay/ButtonIndex")
onready var tabright = get_node("/root/Game/Control/UI/uidisplay/TabsContainer/tabright")
onready var tableft = get_node("/root/Game/Control/UI/uidisplay/TabsContainer/tableft")
onready var slavesdisplay = get_node("/root/Game/Control/UI/SlavesDisplay")
onready var arcdisplay = get_node("/root/Game/Control/UI/ArcDisplay")
onready var next_week = get_node("/root/Game/Control/UI/uidisplay/Next Week")
onready var current_week_value = get_node("/root/Game/Control/UI/uidisplay/Current Week value")
onready var player = get_node("/root/Game/Control/Player") # This identifies the Player node as variable: "player"
# These connect the variables in the Player node's script to this script.
onready var money = player.money
onready var slaves = player.slaves
onready var slavelist = player.slavelist


func _ready():
	update_Display()

func update_Display():
	current_week_value.set_text(str(player.week + 1))


 # NEXT WEEK BUTTON
func _on_Next_Week_pressed():
	player.next_week()
	update_Display()


 # BACK BUTTON
func _on_Button_Back_pressed():
	get_tree().change_scene("res://Scenes/MAIN_MENU.tscn")


 # GENERATE SLAVE BUTTON
func _on_Generate_Slave_pressed():
	# generate_slave was defined as a node on line 14
	generate_slave.Generate_Slave() # Run the Generate_Slave() function in the Generate Slave node's script


 # ADD SLAVE BUTTON
func _on_Add_Slave_pressed():
	slaves[generate_slave.rand_name] = {
		name = generate_slave.rand_name, # In this new {dictionary}, add [key] "name", with the [value] "rand_name"
		nickname = null, # If present, the nickname will be shown instead of the first and last name in the UI (Not yet implemented.)
		age = generate_slave.age_gen,
		haircolor = generate_slave.rand_haircolor
	}
	slavelist.append(generate_slave.rand_name)
	newslavecontainer.hide()
	newslaveinfo.hide()
	add_slave.hide()


# FINISHED BUTTON
func _on_Finished_pressed():
	finished.Finished()


# INDEX OF DISPLAYED SLAVES
func _on_ButtonIndex_button_selected(i): # For the (i)ndex number of the pressed button,
	# Get the (i)ndex number of the selected slave button in the ButtonIndex node.
	# From that index number, get the corresponding index in the slavelist [array].
	# From that entry in the slavelist [array], get the corresponding key in the slaves {dictionary}.
	# Turn the value of that key into a (str)ing.
	# Display that string as text in the Slave Info node.
	slave_info.set_text(str(slaves[slavelist[buttonindex.get_pressed_button_index()]]))


# UI VISIBILITY CONTROLS
func _on_ArcologyTab_pressed():
	tableft.show()
	tabright.hide()
	slavesdisplay.hide()
	arcdisplay.show()
	buy_slaves.hide()
	buyslavepanel.hide()
	finished.hide()
	slave_info.hide()

func _on_SlavesTab_pressed():
	finished.Finished()
	tabright.show()
	tableft.hide()
	slavesdisplay.show()
	arcdisplay.hide()
	buy_slaves.show()
	slave_info.show()

func _on_Buy_Slaves_pressed():
	buyslavepanel.show()
	finished.show()
	slave_info.hide()
	slavesdisplay.hide()

# And so it goes...
