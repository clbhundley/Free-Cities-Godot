extends Panel

onready var dock = get_node("../Dock")
onready var action_button = dock.get_node("ActionButton")
var arrow_left_icon = load("res://GUI/Textures/arrow_left.svg")
var arrow_right_icon = load("res://GUI/Textures/arrow_right.svg")

var is_open = false
var is_hidden = false

var force = false
func open():
	self.show()
	if is_hidden or get_node("../Dock").mode == "PurchaseSlave":
		rect_size.x = get_node("../Dock").margin_right + 30
	is_open = true
	is_hidden = false
	action_button.set_text("Close")
	action_button.icon = arrow_left_icon
	$Tween.interpolate_property(
		self,
		'rect_position',
		Vector2(-460,0),
		Vector2(0,0),
		0.8,
		Tween.TRANS_EXPO,
		Tween.EASE_OUT)
	$Tween.start()

func close():
	is_open = false
	action_button.icon = arrow_right_icon
	action_button.set_text(dock.action_button_text)
	$Tween.interpolate_property(
		self,
		'rect_position',
		Vector2(0,0),
		Vector2(-460,0),
		0.8,
		Tween.TRANS_EXPO,
		Tween.EASE_OUT)
	$Tween.start()
	if is_hidden:
		$Tween.interpolate_property(
			self,
			'rect_size:x',
			rect_size.x,
			460,
			0.8,
			Tween.TRANS_EXPO,
			Tween.EASE_OUT)
		$Tween.start()

func change_content(current,new,animation=true):
	var direction = [0,-460]
	var duration = 0.3
	var content = [current,new]
	if not animation:
		duration = 0
	for index in content.size():
		for margin in ['margin_left','margin_right']:
			$Tween.interpolate_property(
				content[index],
				margin,
				direction[index],
				direction[index-1],
				duration,
				Tween.TRANS_EXPO,
				Tween.EASE_IN_OUT)
	$Tween.start()
	new.show()
