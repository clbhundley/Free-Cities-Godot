extends Control

onready var newslave = preload("res://Slaves/New Slave/new slave.tscn").instance()


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_Back_pressed():
	get_tree().change_scene("res://game.tscn")


func _on_Generate_Slave_pressed():
	newslave.default()
	get_node("RichTextLabel").set_text("check console")