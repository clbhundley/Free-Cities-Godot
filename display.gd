extends Control

var view
var width
var height
var area
var scale
var scale1
var scale2

func _ready():
	get_tree().get_root().connect('size_changed', self, 'resize')
	check_display()

func check_display():
	if not game.config.has_section_key("display", "mode"):
		game.config.set_value("display", "mode", "windowed")
		game.config.save('user://config.cfg')
	if not game.config.has_section_key("display", "msaa"):
		game.config.set_value("display", "msaa", 3)
		game.config.save('user://config.cfg')
	if game.config.get_value("display", "mode") == "windowed":
		set_windowed()
	elif game.config.get_value("display", "mode") == "fullscreen":
		set_fullscreen()
	set_msaa(game.config.get_value("display", "msaa"))

func set_fullscreen():
	game.config.set_value("display", "mode", "fullscreen")
	game.config.save('user://config.cfg')
	OS.set_window_fullscreen(true)
	resize()
	
func set_windowed():
	game.config.set_value("display", "mode", "windowed")
	game.config.save('user://config.cfg')
	OS.set_window_fullscreen(false)
	OS.set_window_maximized(true)
	resize()

func set_msaa(ID):
	game.config.set_value("display", "msaa", ID)
	game.config.save('user://config.cfg')
	get_viewport().msaa = ID

func resize():
	view = get_tree().get_root().get_size()
	width = view[0]
	height = view[1]
	area = width*height
	scale = area/(1920*1080)
	if area < 1600000:
		scale1 = scale * 1.15
		if scale1 < 0.4:
			scale1 = 0.4
		scale2 = scale
		if scale2 < 0.6:
			scale2 = 0.6
	else:
		scale1 = 1
		scale2 = 1
	print("screen size: ",view)
