extends TextureProgress

onready var _slave = owner.owner

func set_gauge():
	value = _slave.hunger
	$Value.set_text(str(round(_slave.hunger))+"%")
	tint_progress = match_color()

func match_color():
	var hunger_stages = {
		10:'ffb499',
		20:'ffa27f',
		30:'ff8f66',
		40:'ff7c4c',
		50:'ff6a32',
		60:'ff5719',
		70:'ff4500',
		80:'ff2900',
		90:'ff1700',
		100:'ff0000'}
	for stage in hunger_stages:
		if clamp(_slave.hunger,0,100) <= stage:
			return Color(hunger_stages[stage])

#	var hunger_stages_orig = {
#		10:"ffece5",
#		20:"ffd9cc",
#		30:"ffc7b2",
#		40:"ffb499",
#		50:"ffa27f",
#		60:"ff8f66",
#		70:"ff7c4c",
#		80:"ff6a32",
#		90:"ff5719",
#		100:"ff4500",
#		110:"ff2900",
#		120:"ff1700",
#		130:"ff0000"}
