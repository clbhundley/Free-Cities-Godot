extends Control

func _ready():
	get_tree().get_root().connect('size_changed',self,'resize')

func _on_New_Game_pressed():
	$NewGame.show()

func _on_Load_Game_pressed():
	$Saves.show()

func _on_Options_pressed():
	$Options.show()

func _on_Exit_pressed():
	get_tree().quit()

func _on_NewGame_Back_pressed():
	$NewGame.hide()

func _input(event):
	if event.is_action_pressed('ui_back') or event.is_action_pressed('ui_cancel'):
		for node in [$Saves, $Options, $NewGame]:
			if node.is_visible_in_tree():
				node.hide()

func resize():
	var adjusted_scale = display.scale * 20
	$Label.get('custom_fonts/font').size = max(16,adjusted_scale)
