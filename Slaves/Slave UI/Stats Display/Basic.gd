extends VBoxContainer

onready var _slave = owner.owner

func refresh():
	var gender_text
	if _slave.gender == "Intersex":
		gender_text = "[color=aqua]Intersex[/color]"
	else:
		gender_text = _slave.gender
	$Line1.set_bbcode(str(_slave.age)+", "+_slave.ethnicity+", "+gender_text)
	
	var intelligence_text = _slave.stats._intelligence()
	if intelligence_text:
		$Line2.set_bbcode(intelligence_text)
	else:
		$Line2.set_bbcode("")
		$Line2.hide()
	
	$Line3.set_bbcode(_slave.stats._devotion()+", "+_slave.stats._trust())
