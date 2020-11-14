extends Control

#RPG style dialogue
#not currently in use

var halted
var counter = 0

func say(string):
	halted = false
	$Text.push_align(0)
	while not string.empty() and not halted:
		var c = string[0]
		string.erase(0,1)
		$Text.add_text(c)
		if not c == " " and counter == 1:
			$Audio.play()
		if c == ",":
			$Timer.wait_time = 0.1
		elif c == "." or c == "!" or c == "?":
			$Timer.wait_time = 0.2
		else:
			$Timer.wait_time = 0.03
		$Timer.start()
		yield($Timer,"timeout")
		if counter == 0:
			counter = 1
		else:
			counter = 0
	$Text.newline()

func read(file):
	var text
	var f = File.new()
	f.open(file,File.READ)
	text = f.get_as_text()
	f.close()
	$Text.add_text(text)
	say(text)

func halt():
	halted = true
