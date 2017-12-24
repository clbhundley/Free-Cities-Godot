extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

# onready var creates the variable when "func _ready()" is executed.
onready var newslavecontainer = get_node("/root/Game/Control/UI/uidisplay/BuySlavePanel/NewSlaveContainer")
onready var slave_info = get_node("/root/Game/Control/UI/uidisplay/Slave Info")
onready var buyslavepanel = get_node("/root/Game/Control/UI/uidisplay/BuySlavePanel")
onready var buy_slaves = get_node("/root/Game/Control/UI/uidisplay/Buy Slaves")
onready var newslaveinfo = get_node("/root/Game/Control/UI/uidisplay/BuySlavePanel/newslaveinfo")
onready var newslaveprice = get_node("/root/Game/Control/UI/uidisplay/BuySlavePanel/newslaveprice")
onready var new_slave = get_node("/root/Game/Control/Slave Functions/New Slave")
onready var kidnappers_market = get_node("/root/Game/Control/UI/uidisplay/BuySlavePanel/Kidnappers Market")
onready var display_slaves = get_node("/root/Game/Control/Slave Functions/Display Slaves")
onready var buy_slave = get_node("/root/Game/Control/UI/uidisplay/BuySlavePanel/Buy Slave")
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
onready var slave_dict = player.slave_dict
onready var slave_list = player.slave_list


func _ready():
	update_Display()

func update_Display():
	current_week_value.set_text(str(player.week + 1))


 # NEXT WEEK BUTTON
func _on_Next_Week_pressed():
	player.next_week()
	update_Display()


 # QUIT BUTTON
func _on_QUIT_pressed():
	get_tree().change_scene("res://Scenes/MAIN_MENU.tscn")


 # NEW SLAVE BUTTON
func _on_Kidnappers_Market_pressed():
	new_slave.default_new_slave() # Get a new slave from the kidnappers' market.
	kidnappers_market.set_text("Next slave")
	newslavecontainer.show()
	newslaveinfo.show()
	newslaveprice.show()
	buy_slave.show()


 # BUY SLAVE BUTTON
func _on_Buy_Slave_pressed():
	new_slave.buy_slave()
	newslavecontainer.hide()
	newslaveinfo.hide()
	newslaveprice.hide()
	buy_slave.hide()


# FINISHED BUTTON
func _on_Finished_pressed():
	display_slaves.player_slaves()
	kidnappers_market.set_text("Kidnappers' Market")
	buyslavepanel.hide()
	finished.hide()
	buy_slaves.show()
	slave_info.show()
	slavesdisplay.show()


# INDEX OF DISPLAYED SLAVES
func _on_ButtonIndex_button_selected(i): # For the (i)ndex number of the pressed button,
	# Get the (i)ndex number of the selected slave button in the ButtonIndex node.
	# From that index number, get the corresponding index in the slave_list [array].
	# From that entry in the slave_list [array], get the corresponding key in the slaves {dictionary}.
	# Turn the value of that key into a (str)ing.
	# Display that string as text in the Slave Info node.
	slave_info.set_text(str(slave_dict[slave_list[buttonindex.get_pressed_button_index()]]))


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
	display_slaves.player_slaves()
	buyslavepanel.hide()
	finished.hide()
	tabright.show()
	tableft.hide()
	slavesdisplay.show()
	arcdisplay.hide()
	buy_slaves.show()
	slave_info.show()

func _on_Buy_Slaves_pressed():
	newslavecontainer.hide()
	newslaveinfo.hide()
	newslaveprice.hide()
	buy_slave.hide()
	kidnappers_market.set_text("Kidnappers' Market")
	buyslavepanel.show()
	finished.show()
	slave_info.hide()
	slavesdisplay.hide()

# And so it goes...