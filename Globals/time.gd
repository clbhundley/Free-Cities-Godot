extends Node

signal tick
signal minute
signal hour
signal day
signal week
signal quarter
signal year

var second
var minute
var hour
var day
var week
var quarter
var year
var total_weeks = 1

signal ff_end
var fast_forward := false

var scale = 1 setget set_scale
func set_scale(value):
	scale = clamp(value,1,60)

func _ready():
	randomize()
	second = randi()%60
	minute = randi()%60
	hour = randi()%24
	day = randi()%7
	week = 0
	quarter = 0
	year = 2119

func tick():
	emit_signal("tick")
	second += 1 * scale
	if second >= 60:
		emit_signal("minute")
		second = 0
		minute += 1
	if minute >= 60:
		emit_signal("hour")
		minute = 0
		hour += 1
	if hour >= 24:
		emit_signal("day")
		hour = 0
		day += 1
	if day >= 7:
		emit_signal("week")
		day = 0
		week += 1
		total_weeks += 1
	if week  >= 13:
		emit_signal("quarter")
		week = 0
		quarter += 1
	if quarter >= 4:
		emit_signal("year")
		quarter = 0
		year += 1
	data.quick_save()

#"%s Q%s Week %s Day %s %s:%s:%s"%[year,quarter,week,day,hour,minute,second]
func get_timestamp():
	return {
		year = year,
		quarter = quarter,
		week = week,
		day = day,
		hour = hour,
		minute = minute,
		second = second}

func get_reversed_time(seconds=0,minutes=0,hours=0,days=0,weeks=0,quarters=0,years=0):
	var reversed_second = second - seconds
	var reversed_minute = minute - minutes
	var reversed_hour = hour - hours
	var reversed_day = day - days
	var reversed_week = week - weeks
	var reversed_quarter = quarter - quarters
	var reversed_year = year - years
	if reversed_second < 0:
		var remainder = int(ceil(float(abs(reversed_second))/60))
		reversed_second = (60*remainder)+reversed_second
		reversed_minute -= remainder
	if reversed_minute < 0:
		var remainder = int(ceil(float(abs(reversed_minute))/60))
		reversed_minute = (60*remainder)+reversed_minute
		reversed_hour -= remainder
	if reversed_hour < 0:
		var remainder = int(ceil(float(abs(reversed_hour))/24))
		reversed_hour = (24*remainder)+reversed_hour
		reversed_day -= remainder
	if reversed_day < 0:
		var remainder = int(ceil(float(abs(reversed_day))/7))
		reversed_day = (7*remainder)+reversed_day
		reversed_week -= remainder
	if reversed_week < 0:
		var remainder = int(ceil(float(abs(reversed_week))/13))
		reversed_week = (13*remainder)+reversed_week
		reversed_quarter -= remainder
	if reversed_quarter < 0:
		var remainder = int(ceil(float(abs(reversed_quarter))/4))
		reversed_quarter = (4*remainder)+reversed_quarter
		reversed_year -= remainder
	return {
		second = reversed_second,
		minute = reversed_minute,
		hour = reversed_hour,
		day = reversed_day,
		week = reversed_week,
		quarter = reversed_quarter,
		year = reversed_year}

func get_forward_time(seconds=0,minutes=0,hours=0,days=0,weeks=0,quarters=0,years=0):
	var forward_second = int(second + seconds)
	var forward_minute = int(minute + minutes)
	var forward_hour = int(hour + hours)
	var forward_day = int(day + days)
	var forward_week = int(week + weeks)
	var forward_quarter = int(quarter + quarters)
	var forward_year = int(year + years)
	if forward_second >= 60:
		var remainder = forward_second / 60
		forward_second = forward_second % 60
		forward_minute += remainder
	if forward_minute >= 60:
		var remainder = forward_minute / 60
		forward_minute = forward_minute % 60
		forward_hour += remainder
	if forward_hour >= 24:
		var remainder = forward_hour / 24
		forward_hour = forward_hour % 24
		forward_day += remainder
	if forward_day >= 7:
		var remainder = forward_day / 7
		forward_day = forward_day % 7
		forward_week += remainder
	if forward_week >= 13:
		var remainder = forward_week / 13
		forward_week = forward_week % 13
		forward_quarter += remainder
	if forward_quarter >= 4:
		var remainder = forward_quarter / 4
		forward_quarter = forward_quarter % 4
		forward_year += remainder
	return {
		second = forward_second,
		minute = forward_minute,
		hour = forward_hour,
		day = forward_day,
		week = forward_week,
		quarter = forward_quarter,
		year = forward_year}

func get_total_time(begin,end):
	var total_seconds = end["second"] - begin["second"]
	var total_minutes = end["minute"] - begin["minute"]
	var total_hours = end["hour"] - begin["hour"]
	var total_days = end["day"] - begin["day"]
	var total_weeks = end["week"] - begin["week"]
	var total_quarters = end["quarter"] - begin["quarter"]
	var total_years = max(end["year"] - begin["year"],0)
	if total_seconds < 0:
		total_seconds = 60 + total_seconds
		total_minutes -= 1
	if total_minutes < 0:
		total_minutes = 60 + total_minutes
		total_hours -= 1
	if total_hours < 0:
		total_hours = 24 + total_hours
		total_days -= 1
	if total_days < 0:
		total_days = 7 + total_days
		total_weeks -= 1
	if total_weeks < 0:
		total_weeks = 13 + total_weeks
		total_quarters -= 1
	if total_quarters < 0:
		total_quarters = 4 + total_quarters
		total_years -= 1
	return {
		seconds = total_seconds,
		minutes = total_minutes,
		hours = total_hours,
		days = total_days,
		weeks = total_weeks,
		quarters = total_quarters,
		years = total_years}
