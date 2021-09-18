extends TextureProgress

onready var _slave = owner.owner

func refresh():
	value = _slave.bathroom
	$Value.set_text(str(round(_slave.bathroom))+"%")
	tint_progress = match_color()

func match_color():
	var bathroom_stages = {
		10:'ccccf5',
		20:'b2b2f0',
		30:'9999eb',
		40:'7f7fe6',
		50:'6666e1',
		60:'4c4cdc',
		70:'3232d7',
		80:'1919d2',
		90:'0000cd',
		100:'0000ff'}
	for stage in bathroom_stages:
		if clamp(_slave.bathroom,0,100) <= stage:
			return Color(bathroom_stages[stage])

#var bathroom_stages_orig = {
#	10:'e5e5fa',
#	20:'ccccf5',
#	30:'b2b2f0',
#	40:'9999eb',
#	50:'7f7fe6',
#	60:'6666e1',
#	70:'4c4cdc',
#	80:'3232d7',
#	90:'1919d2',
#	100:'0000cd',
#	110:'0000ff'}
