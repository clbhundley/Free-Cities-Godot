extends Node

func _level():
	var _slave = get_parent().get_parent()
	var level = 0
	level += _slave.health
	level += _slave.intelligence
	level += _slave.devotion
	level += _slave.trust
	level += _slave.face*10
#	if _slave.figure < -50 or _slave.figure > 50:
#		level -= 10
#	elif _slave.figure < -95 or _slave.figure > 95:
#		level -= 20
	level += _slave.libido
	level += _slave.male_attraction
	level += _slave.female_attraction
	level += _slave.sexual_skill
	level += _slave.oral_skill
	level += _slave.anal_skill
	level += _slave.vaginal_skill
	level += _slave.penis_skill
	level += _slave.anal_skill
	level += _slave.prostitution_skill
	level += _slave.entertainment_skill
	level += _slave.combat_skill
	return(floor(level))

#func _health():
#	var text
#	if _slave.health <= 0:
#		text = "[color=#860000]Deceased[/color]"
#	elif _slave.health < 10:
#		text = "[color=#c80000]Near death[/color]"
#	elif _slave.health < 20:
#		text = "[color=#c85f00]Extremely unhealthy[/color]"
#	elif _slave.health < 30:
#		text = "[color=#c88c00]Very unhealthy[/color]"
#	elif _slave.health < 40:
#		text = "[color=#c8a500]Unhealthy[/color]"
#	elif _slave.health < 50:
#		text = "[color=#7a8c00]Somewhat unhealthy[/color]"
#	elif _slave.health < 60:
#		text = "[color=#5a8c00]Healthy[/color]"
#	elif _slave.health < 80:
#		text = "[color=#3c8c00]Very healthy[/color]"
#	elif _slave.health < 100:
#		text = "[color=#288c00]Extremely healthy[/color]"
#	elif _slave.health < 110:
#		text = "[color=#0e8c00]Perfectly healthy[/color]"
#	elif _slave.health >= 110:
#		text = "[color=#008c28]Unnaturally healthy[/color]"
#	return(text)

#func _fatigue():
#	var text
#	if _slave.fatigue <= 0:
#		text = "[color=#c80000]Completely exhausted[/color]"
#	elif _slave.fatigue < 10:
#		text = "[color=#c85f00]Exhausted[/color]"
#	elif _slave.fatigue < 20:
#		text = "[color=#c88c00]Very tired[/color]"
#	elif _slave.fatigue < 30:
#		text = "[color=#c8a500]Tired[/color]"
#	elif _slave.fatigue < 40:
#		text = "[color=#7a8c00]Drowsy[/color]"
#	elif _slave.fatigue < 50:
#		text = "[color=#5a8c00]Awake[/color]"
#	elif _slave.fatigue < 60:
#		text = "[color=#3c8c00]Fresh[/color]"
#	elif _slave.fatigue < 80:
#		text = "[color=#288c00]Energetic[/color]"
#	elif _slave.fatigue < 100:
#		text = "[color=#0e8c00]Very energetic[/color]"
#	elif _slave.fatigue >= 100:
#		text = "[color=#008c28]Extremely energetic[/color]"
#	return(text)

func _intelligence():
	var _slave = get_parent().get_parent()
	
	var text
	if _slave.intelligence < 25:
		text = "[color=#d70000]Vegetable[/color]"
	elif _slave.intelligence < 50:
		text = "[color=#d74b00]Handicapped[/color]"
	elif _slave.intelligence < 75:
		text = "[color=#c89600]Slow[/color]"
	elif _slave.intelligence < 125:
		text = "[color=#ffffff]Average intelligence[/color]"
	elif _slave.intelligence < 150:
		text = "[color=#00aa0a]Sharp[/color]"
	elif _slave.intelligence < 175:
		text = "[color=#00afb4]Superior intelligence[/color]"
	elif _slave.intelligence >= 175:
		text = "[color=aqua]Exceptional intelligence[/color]"
	return(text)

func _devotion():
	var _slave = get_parent().get_parent()
	
	var text
	if _slave.devotion < -95:
		text = "[color=#9400d3]Utterly hateful[/color]"
	elif _slave.devotion < -50:
		text = "[color=#9400d3]Hateful[/color]"
	elif _slave.devotion < -20:
		text = "[color=#ba55d3]Resistant[/color]"
	elif _slave.devotion < 20:
		text = "[color=#c8c800]Ambivalent[/color]"
	elif _slave.devotion < 50:
		text = "[color=#ff69b4]Accepting[/color]"
	elif _slave.devotion < 95:
		text = "[color=#ff1493]Devoted[/color]"
	elif _slave.devotion >= 95:
		text = "[color=fuchsia]Worshipful[/color]"
	return(text)

func _trust():
	var _slave = get_parent().get_parent()
	
	var text
	if _slave.trust < -95:
		text = "[color=#daa520]Abjectly terrified[/color]"
	elif _slave.trust < -50:
		text = "[color=#daa520]Terrified[/color]"
	elif _slave.trust < -20:
		text = "[color=#dab700]Frightened[/color]"
	elif _slave.trust < 20:
		text = "[color=#c8c800]Fearful[/color]"
	elif _slave.trust < 50:
		text = "[color=#66cdaa]Careful[/color]"
	elif _slave.trust < 95:
		text = "[color=#3cb371]Trusting[/color]"
	elif _slave.trust >= 95:
		text = "[color=#2e8b57]Absolute trust[/color]"
	return(text)

func _face():
	var _slave = get_parent().get_parent()
	
	var text
	if _slave.face <= 0:
		text = "[color=#c80000]Hideous[/color]"
	elif _slave.face < 2:
		text = "[color=#c88c00]Ugly[/color]"
	elif _slave.face < 6:
		text = "[color=#ffffff]Average face[/color]"
	elif _slave.face <= 8:
		text = "[color=#3c8c00]Pretty[/color]"
	elif _slave.face > 8:
		text = "[color=#008c28]Beautiful[/color]"
	return (text)

func _figure():
	var _slave = get_parent().get_parent()
	if _slave.figure == "Emaciated":
		return "[color=#c80000]Emaciated[/color]"
	elif _slave.figure == "Skinny":
		return "[color=#c8a500]Skinny[/color]"
	elif _slave.figure == "Muscular":
		return "[color=#3c8c00]Muscular[/color]"
	elif _slave.figure == "Average weight":
		return "[color=#ffffff]Average weight[/color]"
	elif _slave.figure == "Plush":
		return "[color=#3c8c00]Plush[/color]"
	elif _slave.figure == "Fat":
		return "[color=#c8a500]Fat[/color]"
	elif _slave.figure == "Overweight":
		return "[color=#c80000]Overweight[/color]"

func _libido():
	var _slave = get_parent().get_parent()
	
	var text
	if _slave.libido < 25:
		text = "[color=#ff4500]Frigid[/color]"
	elif _slave.libido < 50:
		text = "[color=#ffa500]Repressed[/color]"
	elif _slave.libido < 75:
		text = "[color=#ffd100]Chaste[/color]"
	elif _slave.libido < 125:
		text = "[color=#ffbbdd]Average libido[/color]"
	elif _slave.libido < 150:
		text = "[color=#ff69b4]Lustful[/color]"
	elif _slave.libido < 175:
		text = "[color=#ff1493]Sex addict[/color]"
	elif _slave.libido >= 175:
		text = "[color=fuchsia]Nympho[/color]"
	return(text)

func _male_attraction():
	var _slave = get_parent().get_parent()
	
	var text
	if _slave.male_attraction <= -100:
		text = "[color=#ff0000]Hates men[/color]"
	elif _slave.male_attraction < -75:
		text = "[color=#ff4500]Disgusted by men[/color]"
	elif _slave.male_attraction < -50:
		text = "[color=#ffa500]Dislikes men[/color]"
	elif _slave.male_attraction < -25:
		text = "[color=#ffd100]Turned off by men[/color]"
	elif _slave.male_attraction <= 0:
		text = "[color=#ffffff]No feelings towards men[/color]"
	elif _slave.male_attraction < 25:
		text = "[color=#ffbbdd]Likes men[/color]"
	elif _slave.male_attraction < 50:
		text = "[color=#ff69b4]Attracted to men[/color]"
	elif _slave.male_attraction < 75:
		text = "[color=#ff1493]Aroused by men[/color]"
	elif _slave.male_attraction >= 75:
		text = "[color=fuchsia]Passionate about men[/color]"
	return(text)

func _female_attraction():
	var _slave = get_parent().get_parent()
	
	var text
	if _slave.female_attraction <= -100:
		text = "[color=#ff0000]Hates women[/color]"
	elif _slave.female_attraction < -75:
		text = "[color=#ff4500]Disgusted by women[/color]"
	elif _slave.female_attraction < -50:
		text = "[color=#ffa500]Dislikes women[/color]"
	elif _slave.female_attraction < -25:
		text = "[color=#ffd100]Turned off by women[/color]"
	elif _slave.female_attraction <= 0:
		text = "[color=#ffffff]No feelings towards women[/color]"
	elif _slave.female_attraction < 25:
		text = "[color=#ffbbdd]Likes women[/color]"
	elif _slave.female_attraction < 50:
		text = "[color=ff69b4]Attracted to women[/color]"
	elif _slave.female_attraction < 75:
		text = "[color=ff1493]Aroused by women[/color]"
	elif _slave.female_attraction >= 75:
		text = "[color=fuchsia]Passionate about women[/color]"
	return(text)

func _sexual_skill():
	var _slave = get_parent().get_parent()
	
	var text
	if _slave.sexual_skill < 25:
		text = "[color=#c89600]Unskilled at sex[/color]"
	elif _slave.sexual_skill < 50:
		text = "[color=#ffffff]Basic sexual skills[/color]"
	elif _slave.sexual_skill < 150:
		text = "[color=#00aa0a]Skilled at sex[/color]"
	elif _slave.sexual_skill < 200:
		text = "[color=#00afb4]Sexual expert[/color]"
	elif _slave.sexual_skill >= 200:
		text = "[color=aqua]Sexual master[/color]"
	return(text)

func _oral_skill():
	var _slave = get_parent().get_parent()
	
	var text
	if _slave.oral_skill < 25:
		text = "[color=#c89600]Unskilled at oral[/color]"
	elif _slave.oral_skill < 50:
		text = "[color=#ffffff]Basic oral skills[/color]"
	elif _slave.oral_skill < 150:
		text = "[color=#00aa0a]Skilled at oral[/color]"
	elif _slave.oral_skill < 200:
		text = "[color=#00afb4]Oral expert[/color]"
	elif _slave.oral_skill >= 200:
		text = "[color=aqua]Oral master[/color]"
	return(text)

func _anal_skill():
	var _slave = get_parent().get_parent()
	
	var text
	if _slave.anal_skill < 25:
		text = "[color=#c89600]Unskilled at anal[/color]"
	elif _slave.anal_skill < 50:
		text = "[color=#ffffff]Basic anal skills[/color]"
	elif _slave.anal_skill < 150:
		text = "[color=#00aa0a]Skilled at anal sex[/color]"
	elif _slave.anal_skill < 200:
		text = "[color=#00afb4]Anal expert[/color]"
	elif _slave.anal_skill >= 200:
		text = "[color=aqua]Anal master[/color]"
	return(text)

func _vaginal_skill():
	var _slave = get_parent().get_parent()
	
	var text
	if _slave.vaginal_skill < 25:
		text = "[color=#c89600]Unskilled at vaginal[/color]"
	elif _slave.vaginal_skill < 50:
		text = "[color=#ffffff]Basic vaginal skills[/color]"
	elif _slave.vaginal_skill < 150:
		text = "[color=#00aa0a]Skilled at vaginal sex[/color]"
	elif _slave.vaginal_skill < 200:
		text = "[color=#00afb4]Vaginal expert[/color]"
	elif _slave.vaginal_skill >= 200:
		text = "[color=aqua]Vaginal master[/color]"
	return(text)

func _penis_skill():
	var _slave = get_parent().get_parent()
	
	var text
	if _slave.penis_skill < 25:
		text = "[color=#c89600]Unskilled stud[/color]"
	elif _slave.penis_skill < 50:
		text = "[color=#ffffff]Basic stud[/color]"
	elif _slave.penis_skill < 150:
		text = "[color=#00aa0a]Skilled stud[/color]"
	elif _slave.penis_skill < 200:
		text = "[color=#00afb4]Expert stud[/color]"
	elif _slave.penis_skill >= 200:
		text = "[color=aqua]Master stud[/color]"
	return(text)

func _prostitution_skill():
	var _slave = get_parent().get_parent()
	
	var text
	if _slave.prostitution_skill < 25:
		text = "[color=#c89600]Unskilled at prostitution[/color]"
	elif _slave.prostitution_skill < 50:
		text = "[color=#ffffff]Basic prostitution skills[/color]"
	elif _slave.prostitution_skill < 150:
		text = "[color=#00aa0a]Skilled prostitute[/color]"
	elif _slave.prostitution_skill < 200:
		text = "[color=#00afb4]Expert prostitute[/color]"
	elif _slave.prostitution_skill >= 200:
		text = "[color=aqua]Masterful prostitute[/color]"
	return(text)

func _entertainment_skill():
	var _slave = get_parent().get_parent()
	
	var text
	if _slave.entertainment_skill < 25:
		text = "[color=#c89600]Unskilled at entertainment[/color]"
	elif _slave.entertainment_skill < 50:
		text = "[color=#ffffff]Basic entertainment skills[/color]"
	elif _slave.entertainment_skill < 150:
		text = "[color=#00aa0a]Skilled entertainer[/color]"
	elif _slave.entertainment_skill < 200:
		text = "[color=#00afb4]Expert entertainer[/color]"
	elif _slave.entertainment_skill >= 200:
		text = "[color=aqua]Masterful entertainer[/color]"
	return(text)

func _combat_skill():
	var _slave = get_parent().get_parent()
	
	var text
	if _slave.combat_skill < 25:
		text = "[color=#c89600]Unskilled at combat[/color]"
	elif _slave.combat_skill < 50:
		text = "[color=#ffffff]Basic combat skills[/color]"
	elif _slave.combat_skill < 150:
		text = "[color=#00aa0a]Skilled fighter[/color]"
	elif _slave.combat_skill < 200:
		text = "[color=#00afb4]Expert fighter[/color]"
	elif _slave.combat_skill >= 200:
		text = "[color=aqua]Masterful fighter[/color]"
	return(text)


#Devotion: Ambivalent. Utterly hateful | Hateful | Resistant | Ambivalent | Accepting | Devoted | Worshipful 
#0
#
#Trust: Fearful. Abjectly terrified | Terrified | Frightened | Fearful | Careful | Trusting | Absolute trust 
#0
#
#Legal status: Slave. Slave | Indentured Servant 
#Voice: Normal. Mute | Deep | Normal | High.      English: Thick Finnish accent. Unaccented | Accent | Heavy accent | Poor 
#Age:  
#39
#      Birth week:  
#36
#      Genes: XX.  XX | XY 
#Health: Healthy. Unhealthy | Healthy | Very healthy | Extremely healthy      
#Muscles: Normal. Normal | Toned | Ripped      Waist: Ugly. Absurd | Hourglass | Feminine | Average | Unattractive | Ugly | Masculine 
#Height: Tall. 
#170
# cm      Weight: Chubby. Emaciated | Skinny | Thin | Average | Plush | Chubby | Fat 
#Prestige: None. None | Locally known | Regionally famous | World renowned 
#
#Her nationality is Finnish. Set custom nationality 
#Ethnicity: 
#white
#
#     White | Black | Latina | Asian | Middle Eastern | Amerindian | Southern European | Semitic | Malay | Indo-aryan | Pacific Islander | Mixed Race 
#Skin color: 
#pale
#
#     White | Fair | Tanned | Olive | Light brown | Brown | Black | Pale | Dark | Light | Extremely pale 
#Facial appearance: normal. Normal | Masculine | Androgynous | Cute | Sensual | Exotic 
#Facial attractiveness: Attractive. Very ugly | Ugly | Unattractive | Average | Attractive | Beautiful | Very beautiful 
#Lips: Thin. Thin | Normal | Plush | Big | Huge     Teeth: Straight. Straight | Crooked | Braces 
#Vision: Nearsighted. Normal | Nearsighted 
#
#Breasts: Healthy. 
#350
# CCs     Lactation: None. Artificial | Natural | None 
#Nipples: partially inverted. Tiny | Cute | Puffy | Inverted | Huge     Areolae: Normal. Normal | Large | Wide | Huge 
#Shoulders: Feminine. Very narrow | Narrow | Normal | Broad | Very broad 
#Hips: Broad. Very narrow | Narrow | Normal | Broad | Very broad 
#Butt: Huge. Flat | Small | Plump | Healthy | Huge | Enormous | Gigantic | Massive 
#Anus: Virgin. Anal virgin | Normal | Veteran | Gaping 
#Vagina: Normal. No vagina | Virgin | Normal | Veteran | Gaping 
#Clit: Large. Normal | Large | Huge      Labia: Normal. Normal | Large | Huge      Vaginal wetness: Dry. Dry | Normal | Excessive 
#Pregnancy: None. Ready to Drop | Advanced | Early | None | Barren 
#Penis: None. No penis | Tiny | Small | Normal | Large | Massive 
#Testicles: None. No testicles | Vestigial | Small | Normal | Large | Massive 
#
#Anal virgins cannot be given anal skills      Oral sex: Unskilled. Unskilled | Basic | Skilled | Expert 
#Vaginal sex: Basic. Unskilled | Basic | Skilled | Expert 
#Prostitution: Unskilled. Unskilled | Basic | Skilled | Expert     Entertainment: Unskilled. Unskilled | Basic | Skilled | Expert 
#Combat: Unskilled. Unskilled | Skilled 
#Intelligence: Smart. Brilliant | Very smart | Smart | Average intelligence | Stupid | Very stupid | Moronic 
#Education: Educated. Educated | Uneducated 
#Fetish: none. 
#     Unknown | None | Sub | Dom | Cumslut | Humiliation | Buttslut | Breasts | Pregnancy | Sadism | Masochism 
#Sexuality: Not known. Known 
#Behavioral Flaw: hates women. 
#     None | Arrogant | Bitchy | Odd | Men | Women | Anorexic | Gluttonous | Devout | Liberated 
#Sexual Flaw: none. 
#     None | Oral | Anal | Penetration | Repressed | Shamefast | Apathetic | Crude | Judgemental | Sexually idealistic 
#
#     Add this slave This will apply your career bonus to her: one free level of prostitution skill. 
#     Add slave without career bonus 
#    Discard this slave and continue 
#
#Archetypes:    Convenient combinations of slave attributes 
#     Irish Rose A beautiful flower from the Emerald Isle 
#     Cali Girl Tall, taut, and tan 
#     Novice Train your own and save 
#     Head Girl Prospect Inexpensive potential to become a great right hand woman 
#
#Start over by selecting a nationality: Afghan | Albanian | Algerian | American | Andorran | Argentinian | Armenian | Australian | Austrian | Bangladeshi | Belgian | Belizean | Bermudian | Bolivian | Bosnian | Brazilian | British | Bruneian | Bulgarian | Burmese | Cambodian | Cameroonian | Canadian | Chilean | Chinese | Colombian | Congolese | Costa Rican | Croatian | Cuban | Czech | Danish | Djiboutian | Dutch | Egyptian | Emirati | Estonian | Ethiopian | Filipina | Finnish | French | Gabonese | German | Ghanan | Greek | Greenlandic | Grenadian | Guatemalan | Haitian | Honduran | Hungarian | I-Kiribati | Icelandic | Indian | Indonesian | Iranian | Iraqi | Irish | Israeli | Italian | Jamaican | Japanese | Jordanian | Kazakh | Kenyan | Korean | Kosovan | Laotian | Lebanese | Libyan | Lithuanian | Luxembourgian | Macedonian | Malagasy | Malaysian | Maldivian | Malian | Maltese | Marshallese | Mexican | Micronesian | Moldovan | Monégasque | Mongolian | Montenegrin | Moroccan | Nauruan | Nepalese | a New Zealander | Nicaraguan | Nigerian | Nigerien | Norwegian | Omani | Pakistani | Panamanian | Peruvian | Polish | Portuguese | Puerto Rican | Romanian | Russian | Salvadoran | Sammarinese | Saudi | Serbian | Singaporean | Slovak | South African | Spanish | Sudanese | Swedish | Swiss | Syrian | Taiwanese | Tanzanian | Thai | Tunisian | Turkish | Tuvaluan | Ugandan | Ukrainian | Uruguayan | Uzbek | Venezuelan | Vietnamese | Yemeni | Zambian | Zimbabwean
