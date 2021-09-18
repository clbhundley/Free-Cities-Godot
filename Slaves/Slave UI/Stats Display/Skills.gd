extends VBoxContainer

onready var _slave = owner.owner

func refresh():
	$Line1.set_bbcode(_slave.stats._sexual_skill())
	
	$Line2.set_bbcode(_slave.stats._prostitution_skill())
	
	$Line3.set_bbcode(_slave.stats._entertainment_skill())
	
	var cooking_skill_text = _slave.stats._cooking_skill()
	if cooking_skill_text:
		$Line4.set_bbcode(cooking_skill_text)
	else:
		$Line4.set_bbcode("")
		$Line4.hide()

	var medical_skill_text = _slave.stats._medical_skill()
	if medical_skill_text:
		$Line5.set_bbcode(medical_skill_text)
	else:
		$Line5.set_bbcode("")
		$Line5.hide()

	var combat_skill_text = _slave.stats._combat_skill()
	if combat_skill_text:
		$Line6.set_bbcode(combat_skill_text)
	else:
		$Line6.set_bbcode("")
		$Line6.hide()

	var music_skill_text = _slave.stats._music_skill()
	if music_skill_text:
		$Line7.set_bbcode(music_skill_text)
	else:
		$Line7.set_bbcode("")
		$Line7.hide()
