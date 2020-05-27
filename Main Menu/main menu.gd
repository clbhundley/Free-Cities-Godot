extends Control

onready var main = get_tree().get_nodes_in_group('Main')

func _on_New_Game_pressed():
	get_node('New Game').show()

func _on_Load_Game_pressed():
	get_node('Saves').show()

func _on_Options_pressed():
	get_node('Options').show()

func _on_Exit_pressed():
	get_tree().quit()

func _input(event):
	if event.is_action_pressed('ui_back') or event.is_action_pressed('ui_cancel'):
		if get_node('Saves').is_visible_in_tree():
			get_node('Saves').hide()
		elif get_node('Options').is_visible_in_tree():
			get_node('Options').hide()
		elif get_node('New Game').is_visible_in_tree():
			get_node('New Game').hide()

func _ready():
	get_tree().get_root().connect('size_changed',self,'resize')

func resize():
	var adjusted_scale = display.scale*20
	$Label.get('custom_fonts/font').size = max(16,adjusted_scale)
