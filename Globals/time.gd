extends Node

var second
var minute
var hour
var day
var week
var quarter
var year

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
	second += 1
	if second == 60:
		second = 0
		minute += 1
	if minute == 60:
		minute = 0
		hour += 1
	if hour == 24:
		hour = 0
		day += 1
	if day == 7:
		day = 0
		week += 1
	if week  == 13:
		week = 0
		quarter += 1
	if quarter == 4:
		quarter = 0
		year += 1
	data.quick_save()
