extends Node

var second
var minute
var hour
var day
var week
var quarter
var year

signal tick
signal minute
signal hour
signal day
signal week
signal quarter
signal year

func _ready():
	randomize()
	second = randi()%60
	minute = randi()%60
	hour = randi()%24
	day = randi()%7
	week = 0
	quarter = 0
	year = 2119

#"%s Q%s Week %s Day %s %s:%s:%s"%[year,quarter,week,day,hour,minute,second]
func get_timestamp():
	var dict = {
		year = year,
		quarter = quarter+1,
		week = week+1,
		day = day+1,
		hour = hour,
		minute = minute,
		second = second}
	return dict

func tick():
	emit_signal("tick")
	second += 1
	if second == 60:
		emit_signal("minute")
		second = 0
		minute += 1
	if minute == 60:
		emit_signal("hour")
		minute = 0
		hour += 1
	if hour == 24:
		emit_signal("day")
		hour = 0
		day += 1
	if day == 7:
		emit_signal("week")
		day = 0
		week += 1
	if week  == 13:
		emit_signal("quarter")
		week = 0
		quarter += 1
	if quarter == 4:
		emit_signal("year")
		quarter = 0
		year += 1
	data.quick_save()
