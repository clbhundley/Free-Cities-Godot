class_name Entry

var key
var value
var name:String
var pair:Dictionary

func _init(key,value):
	self.key = key
	self.value = value
	name = str(key)
	pair = {key:value}

class SortByValue:
	static func sort_ascending(a,b):
		if a.value < b.value:
			return true
		return false
	static func sort_descending(a,b):
		if a.value > b.value:
			return true
		return false
