extends VBoxContainer

onready var _slave = owner.owner

func refresh():
	var libido_text = _slave.stats._libido()
	if libido_text:
		$Line1.set_bbcode(libido_text)
	else:
		$Line1.set_bbcode("")
		$Line1.hide()
	
	$Line2.set_bbcode(_slave.stats._male_attraction())
	
	$Line3.set_bbcode(_slave.stats._female_attraction())
	
	$Line4.set_bbcode("#Fetishes")
