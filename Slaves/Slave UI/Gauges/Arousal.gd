extends TextureProgress

onready var _slave = owner.owner

func refresh():
	value = _slave.arousal
	$Value.set_text(str(round(_slave.arousal))+"%")
	tint_progress = match_color()

func match_color():
	var arousal_stages = {
		10:'ffb2ff',
		20:'ff99ff',
		30:'ff7fff',
		40:'ff66ff',
		50:'ff4cff',
		60:'ff32ff',
		70:'ff19ff',
		80:'ff00ff',
		90:'ff00dd',
		100:'ff00a7'}
	for stage in arousal_stages:
		if clamp(_slave.arousal,0,100) <= stage:
			return Color(arousal_stages[stage])

#var arousal_orig = {
#	10:"ffe5ff",
#	20:"ffccff",
#	30:"ffb2ff",
#	40:"ff99ff",
#	50:"ff7fff",
#	60:"ff66ff",
#	70:"ff4cff",
#	80:"ff32ff",
#	90:"ff19ff",
#	100:"ff00ff",
#	110:"ff00dd",
#	120:"ff00a7"}
