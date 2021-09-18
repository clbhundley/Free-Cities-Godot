extends Node

var genitals_male_adjustment:float
var masculinity:float setget set_masculinity
var weight:float setget set_weight
var weight_round:float setget set_weight_round
var weight_pear:float setget set_weight_pear
var weight_fat:float setget set_weight_fat
var body_size:float setget set_body_size
var waist_size:float
var butt_size:float
var bodybuilder:float
var voluptuous:float
var pregnant:float
var breasts_growth:float
var breasts_implants:float
var breasts_small:float
var breasts_gone:float
var testicles_size:float
var penis_length:float
var penis_thickness:float
var penis_micro:float

func reset():
	masculinity = 0
	genitals_male_adjustment = 0
	weight = 0
	weight_round = 0
	weight_pear = 0
	weight_fat = 0
	waist_size = 0
	butt_size = 0
	body_size = 0
	bodybuilder = 0
	voluptuous = 0
	pregnant = 0
	breasts_growth = 0
	breasts_implants = 0
	breasts_small = 0
	breasts_gone = 0
	testicles_size = 0
	penis_length = 0
	penis_thickness = 0
	penis_micro = 0

func set_default_values(_slave):
	reset()
	self.weight = clamp(math.gaussian(75,28),20,100)/100
	if weight == 1:
		distribute_fat()
	waist_size = clamp(math.gaussian(75,8),50,100)/100
	if randi()%3 == 0:
		butt_size = clamp(math.gaussian(0,5),0,20)/100
	if randi()%4 == 0:
		distribute_body_size()
	if randi()%4 == 0:
		distribute_muscles()
	
	if _slave.gender == "Female" or _slave.gender == "Trans male":
		genitals_male_adjustment = 0
	else:
		genitals_male_adjustment = 1
		penis_length = clamp(math.gaussian(16,9),10,50)/100
		penis_thickness = clamp(math.gaussian(35,5),20,60)/100
		testicles_size = clamp(math.gaussian(25,7),10,50)/100
	
	if _slave.gender == "Male":
		self.masculinity = clamp(math.gaussian(97,4),90,100)/100
	elif _slave.gender == "Trans male":
		self.masculinity = clamp(math.gaussian(80,10),70,100)/100
	elif _slave.gender == "Female":
		distribute_breast_growth()
		if randi()%4 == 0:
			breasts_implants = clamp(math.gaussian(12,12),0,55)/100
		if randi()%4 == 0:
			voluptuous = clamp(math.gaussian(20,15),0,55)/100
	elif _slave.gender == "Trans female":
		self.masculinity = clamp(math.gaussian(50,24),30,90)/100
		distribute_trans_breasts()
		if randi()%4 == 0:
			breasts_implants = clamp(math.gaussian(12,12),0,45)/100
		if randi()%6 == 0:
			voluptuous = clamp(math.gaussian(15,10),0,35)/100

func distribute_breast_growth():
	if randi()%12 <= 4:
		breasts_growth = clamp(math.gaussian(10,12),0,35)/100
	elif randi()%12 <= 8:
		breasts_growth = clamp(math.gaussian(30,12),10,60)/100
	elif randi()%12 <= 11:
		if randi()%2 == 0:
			breasts_small = clamp(math.gaussian(60,12),30,90)/100
		else:
			breasts_growth = clamp(math.gaussian(60,12),30,90)/100

func distribute_trans_breasts():
	if randi()%12 <= 4:
		breasts_small = clamp(math.gaussian(50,22),0,100)/100
	elif randi()%12 <= 8:
		self.breasts_gone = clamp(math.gaussian(70,12),50,100)/100
	elif randi()%12 <= 11:
		self.breasts_growth = clamp(math.gaussian(10,12),0,35)/100

func distribute_fat():
	var average_fat = clamp(math.gaussian(35,25),0,80)/100
	var fat_type = ["weight_round","weight_fat","weight_pear"]
	fat_type.shuffle()
	var fat_combination = randi()%3
	if fat_combination == 0:
		set(fat_type[0],average_fat)
	elif fat_combination == 1:
		var split = math.random_split_2(average_fat)
		set(fat_type[0],split[0])
		set(fat_type[1],split[1])
	elif fat_combination == 2:
		var split = math.random_split_3(average_fat)
		set(fat_type[0],split[0])
		set(fat_type[1],split[1])
		set(fat_type[2],split[2])

func distribute_body_size():
	if randi()%12 <= 5:
		self.body_size = clamp(math.gaussian(10,12),0,30)/100
	elif randi()%12 <= 9:
		self.body_size = clamp(math.gaussian(30,12),10,60)/100
	elif randi()%12 <= 11:
		self.body_size = clamp(math.gaussian(60,12),30,90)/100

func distribute_muscles():
	if randi()%12 <= 5:
		bodybuilder = clamp(math.gaussian(10,12),0,30)/100
	elif randi()%12 <= 9:
		bodybuilder = clamp(math.gaussian(30,12),10,60)/100
	elif randi()%12 <= 11:
		bodybuilder = clamp(math.gaussian(60,12),30,90)/100

func reset_weight(value):
	if value > 0:
		set_weight(1)

func set_weight(value):
	if value < 1:
		set_weight_fat(0)
		set_weight_pear(0)
		set_weight_round(0)
	weight = clamp(value,0,1)

func set_weight_round(value):
	reset_weight(value)
	weight_round = clamp(value,0,1)

func set_weight_pear(value):
	reset_weight(value)
	weight_pear = clamp(value,0,1)

func set_weight_fat(value):
	reset_weight(value)
	weight_fat = clamp(value,0,1)

func set_body_size(value):
	if masculinity > 0:
		breasts_small = masculinity
	body_size = clamp(value,0,1)

func set_masculinity(value):
	set_weight_fat(weight_fat)
	masculinity = value
