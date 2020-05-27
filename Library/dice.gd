extends Node

#extended PNRG for Godot
#wikipedia.org/wiki/Digital_root
#supports 2-12 faces
#if 7 or 11 faces are selected, only Godot's built-in PRNG will be used

func roll(faces):
	randomize()
	if faces == 2:
		var _seed = roll_0()
		if _seed <= 4:
			return 0
		elif _seed <= 9:
			return 1
	elif faces == 3:
		var _seed = roll_1()
		if _seed <= 3:
			return 0
		elif _seed <= 6:
			return 1
		elif _seed <= 9:
			return 2
	elif faces == 4:
		var _seed = (roll_0()*10)+roll_0()
		if _seed <= 24:
			return 0
		elif _seed <= 49:
			return 1
		elif _seed <= 74:
			return 2
		elif _seed <= 99:
			return 3
	elif faces == 5:
		var _seed = roll_0()
		if _seed <= 1:
			return 0
		elif _seed <= 3:
			return 1
		elif _seed <= 5:
			return 2
		elif _seed <= 7:
			return 3
		elif _seed <= 9:
			return 4
	elif faces == 6:
		var _seed = roll_1()
		var split = roll_0()
		var value
		if _seed <= 3:
			value = 0
		elif _seed <= 6:
			value = 1
		elif _seed <= 9:
			value = 2
		if split <= 4:
			return value
		elif split <= 9:
			value += 3
			return value
	elif faces == 7:
		return randi()%7
	elif faces == 8:
		var _seed = (roll_0()*10)+roll_0()
		var split = roll_0()
		var value
		if _seed <= 24:
			value = 0
		elif _seed <= 49:
			value = 1
		elif _seed <= 74:
			value = 2
		elif _seed <= 99:
			value = 3
		if split <= 4:
			return value
		elif split <= 9:
			value += 4
			return value
	elif faces == 9:
		return roll_1()-1
	elif faces == 10:
		return roll_0()
	elif faces == 11:
		return randi()%11
	elif faces == 12:
		var _seed = roll_1()
		var split = roll_0()
		var split2 = roll_0()
		var value
		if _seed <= 3:
			value = 0
		elif _seed <= 6:
			value = 1
		elif _seed <= 9:
			value = 2
		if split <= 4:
			value += 0
		elif split <= 9:
			value += 3
		if split2 <= 4:
			value += 0
		elif split2 <= 9:
			value += 6
		return value

func roll_0():
	var a = []
	var sum = 0
	for i in range(10):
		a.append(spin_0(i))
	while not a.empty():
		sum += a.pop_back()
	return int(str(sum).right(1))

func roll_1():
	var a = []
	var sum = 0
	for i in range(100,109):
		a.append(root(spin_1(i)))
	while not a.empty():
		sum += a.pop_back()
	return root(sum)

func spin_0(origin):
	var g = abs(math.gaussian(origin,9))
	if str(g).length() >= 2:
		return int(str(g).right(1))
	else:
		return g

func spin_1(origin):
	return abs(math.gaussian(origin,9))

func root(_seed):
	var sum = 0
	var string = str(_seed)
	while not string.empty():
		sum += int(string.left(1))
		string.erase(0,1)
	string = str(sum)
	sum = 0
	while not string.empty():
		sum += int(string.left(1))
		string.erase(0,1)
	return sum
