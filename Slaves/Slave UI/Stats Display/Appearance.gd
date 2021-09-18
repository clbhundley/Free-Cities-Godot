extends VBoxContainer

onready var _slave = owner.owner

func refresh():
	var pregnancy_text = pregnancy_text()
	if pregnancy_text:
		$Line1.set_bbcode(pregnancy_text)
	else:
		$Line1.set_bbcode("")
	
	var face_text = _slave.stats._face()
	var weight_text
	if _slave.flags.has('weight'):
		weight_text = _slave.flags['weight']
	if face_text and weight_text:
		$Line2.set_bbcode(face_text+", "+weight_text)
	elif face_text:
		$Line2.set_bbcode(face_text)
	elif weight_text:
		$Line2.set_bbcode(weight_text)
	else:
		$Line2.set_bbcode("")
	
	var body_text
	if _slave.flags.has('body'):
		body_text = _slave.flags['body']
	var physique_text
	if _slave.flags.has('physique'):
		physique_text = _slave.flags['physique']
	if body_text and physique_text:
		$Line3.set_bbcode(body_text+", "+physique_text)
	elif body_text:
		$Line3.set_bbcode(body_text)
	elif physique_text:
		$Line3.set_bbcode(physique_text)
	else:
		$Line3.set_bbcode("")
	
	if _slave.flags.has('gender'):
		$Line4.set_bbcode(_slave.flags['gender'])
	else:
		$Line4.set_bbcode("")
	
	if _slave.voice != "normal":
		var voice_string = _slave.voice
		voice_string[0] = voice_string[0].capitalize()
		if voice_string != "Mute":
			voice_string += "voice"
		$Line5.set_bbcode(voice_string)
	else:
		$Line5.set_bbcode("")
	
	for line in get_children():
		if line.bbcode_text.empty():
			line.hide()

func pregnancy_text():
	var weeks_pregnant = SlaveUtils.get_weeks_pregnant(_slave)
	if _slave.pregnancy and weeks_pregnant > 0:
		var babies = _slave.pregnancy['babies']
		if babies > 1:
			babies = " ("+str(babies)+")"
		else:
			babies = ""
		var weeks_pregnant_string = str(weeks_pregnant)
		if weeks_pregnant < 2:
			weeks_pregnant_string += " week pregnant"
		else:
			weeks_pregnant_string += " weeks pregnant"
		return "[color=#ff69b4]"+weeks_pregnant_string+babies+"[/color]"
