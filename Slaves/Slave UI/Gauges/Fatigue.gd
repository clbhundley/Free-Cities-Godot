extends TextureProgress

onready var _slave = owner.owner

func set_gauge():
	value = _slave.fatigue
	$Value.set_text(str(round(_slave.fatigue))+"%")
	tint_progress = match_color()

func match_color():
	var fatigue_stages = {
		10:'eaeded',
		20:'d5dbdb',
		30:'c0caca',
		40:'abb8b8',
		50:'97a7a7',
		60:'829595',
		70:'6d8383',
		80:'587272',
		90:'436060',
		100:'2f4f4f'}
	for stage in fatigue_stages:
		if clamp(_slave.fatigue,0,100) <= stage:
			return Color(fatigue_stages[stage])
