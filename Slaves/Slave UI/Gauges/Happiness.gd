extends TextureProgress

onready var _slave = owner.owner

func refresh():
	value = _slave.happiness
	$Value.set_text(str(round(_slave.happiness))+"%")
	tint_progress = match_color()

func match_color():
	var happiness_stages = {
		10:'ffffe5',
		20:'ffffcc',
		30:'ffffb2',
		40:'ffff99',
		50:'ffff7f',
		60:'ffff66',
		70:'ffff4c',
		80:'ffff32',
		90:'ffff19',
		100:'ffff00'}
	for stage in happiness_stages:
		if clamp(_slave.happiness,0,100) <= stage:
			return Color(happiness_stages[stage])
