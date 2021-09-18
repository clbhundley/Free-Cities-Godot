extends Control

var title:String
var price_data:String

var interval = 1
var zoom = 0

enum Intervals {
	DAY = 1
	WEEK = 7
	WEEK_4 = 28
	QUARTER = 91
	YEAR = 364
}

func _ready():
	get_tree().get_root().connect('size_changed',self,'draw_chart')
	time.connect('day',self,'draw_chart')
	draw_chart()

func draw_chart():
	yield(time,"time_updated")
	var width = $Bottom.get_size().x
	var height = $Side.get_size().y
	var h_separator = 30 - zoom
	var v_separator = round(height/12)
	var visible_frames = floor(width/h_separator)
	price_data = "user://Data/Slot %s/Slaves/Price History.a32"%data.save_slot
	var prices = averaged_data_array(price_data,visible_frames)
	var sorted = prices.duplicate()
	sorted.sort()
	var top = v_separator
	var bot = v_separator * 11
	var v_range = bot - top
	if prices.empty():
		$InsufficientData.show()
		return
	var min_v = sorted.front()
	var max_v = sorted.back()
	var spread = max_v - min_v
	title = "Average Price of Slaves"
	$Title/Name.set_text(title+":")
	$Title/Price.set_text(str(prices.front()))
	set_bottom_nubs(visible_frames,h_separator)
	set_side_nubs(prices,max_v,spread,v_separator,height)
	for point in get_tree().get_nodes_in_group('Points'):
		remove_child(point)
		point.queue_free()
	var index:int
	for value in prices:
		graph(value,min_v,top,spread,v_range,h_positions[index],height)
		index += 1
	var points:Array
	for point in get_tree().get_nodes_in_group('Points'):
		points.append(point)
	var lines:Array
	for point in points:
		var pos_x = point.get_position().x+3
		var pos_y = point.get_position().y+3
		var adjusted_pos = Vector2(pos_x,pos_y)
		lines.append(adjusted_pos)
	$Line2D.set_points(lines)
	$Settings.raise()
	$Title.raise()

func graph(value,min_v,top,spread,v_range,h_pos,height):
	var position
	if spread == 0:
		position = 0
	else:
		position = (value-min_v)/spread
	var v_pos = height-((position*v_range)+top)
	var point = $Point.duplicate()
	point.show()
	point.add_to_group('Points')
	point.set_position(Vector2(h_pos-1,v_pos))
	point.get_node('Label').set_text(str(value))
	add_child(point)

func set_side_nubs(array,max_v,spread,v_separator,height):
	var nub = $Side/Nub
	var label = $Side/Nub/Label
	var value = max_v
	var distance = spread/10
	var position = 0
	for _nub in $Side.get_children():
		$Side.remove_child(_nub)
		_nub.queue_free()
	for ticks in 11:
		position += v_separator
		nub.set_position(Vector2(0,position))
		label.set_text(str(value))
		value -= distance
		$Side.add_child(nub.duplicate())

var h_positions = []
func set_bottom_nubs(visible_frames,h_separator):
	var position = 10
	var nub = $Bottom/Nub
	var label_top = $Bottom/Nub/LabelTop
	var label_bot = $Bottom/Nub/LabelBot
	for _nub in $Bottom.get_children():
		$Bottom.remove_child(_nub)
		_nub.queue_free()
	for frame in visible_frames:
		position -= h_separator
		nub.set_position(Vector2(position,0))
		match interval:
			Intervals.DAY:
				var day = time.day - frame
				var week = time.week - floor(frame/7)
				var quarter = time.quarter + floor(week/13)
				label_top.set_text(_day(day))
				if quarter == 0 and week == 0 and day%7 == 0:
					label_bot.set_text(str(time.year))
				elif day%7 == 0:
					label_bot.set_text("Q"+_quarter(quarter)+",W"+_week(week))
				else:
					label_bot.set_text("")
			Intervals.WEEK:
				var week = time.week - frame
				var quarter = time.quarter + floor(week/13)
				var year = time.year + floor(quarter/4)
				if week%2 == 0:
					label_top.set_text("W"+_week(week))
				else:
					label_top.set_text("")
				if week%13 == 0:
					label_bot.set_text("Q"+_quarter(quarter)+","+str(year))
				else:
					label_bot.set_text("")
			Intervals.WEEK_4:
				var offset = time_offset()/7
				var week = time.week - (frame*4) - offset
				var quarter = time.quarter + floor(float(week)/12)
				var year = time.year + floor(quarter/4)
				if frame%3 == 0:
					label_top.set_text("Q"+_quarter(quarter)+",W"+_week(week))
				else:
					label_top.set_text("")
				if int(quarter)%4 == 0 and frame%3 == 0:
					label_bot.set_text(str(year))
				else:
					label_bot.set_text("")
			Intervals.QUARTER:
				var quarter = time.quarter - frame
				var year = time.year + floor(quarter/4)
				label_bot.set_text("")
				if quarter%4 == 0:
					label_top.set_text(str(year))
				else:
					label_top.set_text("")
			Intervals.YEAR:
				var year = time.year - frame
				label_bot.set_text("")
				if frame%3 == 0:
					label_top.set_text(str(year))
				else:
					label_top.set_text("")
		$Bottom.add_child(nub.duplicate())
	h_positions.clear()
	for _nub in $Bottom.get_children():
		h_positions.append(_nub.get_position().x)

func averaged_data_array(path,visible_frames):
	var prices_raw:Array
	var prices_averaged:Array
	var selection = visible_frames*interval
	var buffer := 4 #32/8
	var file = File.new()
	file.open(path,file.READ)
	var file_size = file.get_len()
	if file_size/buffer < selection:
		selection = file_size/buffer
	for i in selection:
		file.seek_end(-(i+1)*buffer)
		var value = float(file.get_32())/1000000
		prices_raw.append(value)
	file.close()
	var offset:int = time_offset()
	for frame in visible_frames:
		var prices:Array
		if frame == 0 and offset:
			for price in offset:
				if (frame*interval)+price < prices_raw.size():
					prices.append(prices_raw[(frame*interval)+price])
		else:
			for price in interval:
				if (frame*interval)+price+offset < prices_raw.size():
					prices.append(prices_raw[(frame*interval)+price+offset])
		var average_price = 0
		for price in prices:
			average_price += price
		if average_price:
			average_price /= prices.size()
			prices_averaged.append(average_price)
	return prices_averaged

func time_offset():
	match interval:
		Intervals.DAY:
			return 0
		Intervals.WEEK:
			return time.day%7
		Intervals.WEEK_4:
			return (time.day+(time.week*7)+(time.quarter*7))%28
		Intervals.QUARTER:
			return (time.day+(time.week*7))%91
		Intervals.YEAR:
			return (time.day+(time.week*7)+(time.quarter*91))%364

func _day(value):
	match posmod(value,7):
		0:
			return "S"
		1:
			return "M"
		2:
			return "T"
		3:
			return "W"
		4:
			return "T"
		5:
			return "F"
		6:
			return "S"

func _week(value):
	return str(posmod(value,13)+1)

func _quarter(value):
	return str(posmod(value,4)+1)
