extends Node

var config = data.config

func _ready():
	get_tree().get_root().connect('size_changed', self, 'resize')

func check_display():
	if not config.has_section_key("display", "mode"):
		config.set_value("display", "mode", "windowed")
		config.save('user://config.cfg')
	if not config.has_section_key("display", "msaa"):
		config.set_value("display", "msaa", 3)
		config.save('user://config.cfg')
	if config.get_value("display", "mode") == "windowed":
		set_windowed()
	elif config.get_value("display", "mode") == "fullscreen":
		set_fullscreen()
	set_msaa(config.get_value("display", "msaa"))

func set_fullscreen():
	config.set_value("display", "mode", "fullscreen")
	config.save('user://config.cfg')
	OS.set_window_fullscreen(true)
	resize()

func set_windowed():
	config.set_value("display", "mode", "windowed")
	config.save('user://config.cfg')
	OS.set_window_fullscreen(false)
	OS.set_window_maximized(true)
	resize()

func set_msaa(id):
	config.set_value("display", "msaa", id)
	config.save('user://config.cfg')
	get_viewport().msaa = id

var scale
var scale_w
var aspect_ratio
func resize():
	var view = get_tree().get_root().get_size()
	var width = view.x
	var height = view.y
	var area = width*height
	#var area = height
	var display_scale = area/(1920*1080)
	#var display_scale = area/(1080)
	aspect_ratio = width/height
	if area < 1803000:
		scale = max(display_scale*1.15,0.4)
	else:
		scale = 1
	print("aspect ratio: ",aspect_ratio)
	print("window size: ",view)
	
	var area_w = height
	var display_scale_w = area_w/1080
	if area_w < 1803000:
		scale_w = max(display_scale_w,0.4)
	else:
		scale_w = 1
