extends Control


var money = 0
var slave_dict = {}
var slave_list = []
var week = 0


func next_week():
	for slave in slave_dict.values():
		assignment_report(slave)
	week += 1

func assignment_report(slave):
	# do slave stuff
	print(str(slave))
