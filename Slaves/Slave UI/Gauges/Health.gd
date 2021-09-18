extends TextureProgress

onready var _slave = owner.owner

func refresh():
	if _slave.health <= 100:
		$Excess.value = 0
		value = _slave.health
		tint_progress = match_color()
	else:
		value = 100
		$Excess.value = _slave.health
		$Excess.tint_progress = match_excess_color()
	$Value.set_text(str(round(_slave.health))+"%")

func match_color():
	var health_natural_stages = {
		10:'ff0000',
		20:'ff4500',
		30:'ffa500',
		40:'ffd100',
		50:'ffff00',
		60:'9acd32',
		70:'5bfb5b',
		80:'00ff00',
		90:'00ca00',
		100:'009e00'}
	for stage in health_natural_stages:
		if clamp(_slave.health,0,100) <= stage:
			return Color(health_natural_stages[stage])

func match_excess_color():
	var health_unnatural_stages = {
		110:'008000',
		120:'008032',
		130:'00bc6c',
		140:'00e5a4',
		150:'00e4c4',
		160:'00ffed',
		170:'00edff',
		180:'00c9ff',
		190:'00a5ff',
		200:'0096ff'}
	for stage in health_unnatural_stages:
		if clamp(_slave.health,100,200) <= stage:
			return Color(health_unnatural_stages[stage])
