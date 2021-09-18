extends VBoxContainer

onready var _slave = owner.owner

func refresh():
	$Line1.set_bbcode("#Behavioral trait")
	
	$Line2.set_bbcode("#Sexual trait")
	
	$Line3.set_bbcode("#Relationships")
