extends Node

func say(text:String):
	var gui = get_tree().get_root().get_node("Game/GUI")
	var navi_chat = gui.get_node("Dock/NaviChat")
	navi_chat.say(text)

func read(file):
	var gui = get_tree().get_root().get_node("Game/GUI")
	var navi_chat = gui.get_node("Dock/NaviChat")
	navi_chat.read(file)
