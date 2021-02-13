extends Control

func _ready():
	get_tree().get_root().connect('size_changed',self,'resize')

func resize():
	var adjusted_scale = display.scale * 20
	$Label.get('custom_fonts/font').size = max(16,adjusted_scale)
