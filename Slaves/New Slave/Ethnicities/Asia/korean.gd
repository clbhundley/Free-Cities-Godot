
static func traits(gender):
	return {
		name = name(gender),
		language = "Korean",
		skin_color = skin_color(),         # pale, white, tanned, yellow, olive, brown, black
		tissue_color = "pink",             # pink, dark
		hair_color_natural = hair_color(), # black, dark_brown, brown, light_brown, blond, red, grey
		hair_type = "straight",            # straight, wavy, curly, short, none
		eye_color = "brown",
		body_type = null,
		height = str(math.gaussian(157,8)) + " cm",
		weight = str(math.gaussian(57,8)) + " kg",
		breast_size = chest(),
		penis_size = penis()}

static func skin_color():
	var skin_colors = load('res://Slaves/New Slave/colors.gd').skin
	var roll = (dice.roll(10)*10) + dice.roll(10) # 0-99
	var choice
	if roll <= 24:
		choice = skin_colors['pale']
	elif roll <= 38:
		choice = skin_colors['white']
	else:
		choice = skin_colors['yellow']
	return choice[dice.roll(choice.size())]

static func hair_color():
	var hair_colors = load('res://Slaves/New Slave/colors.gd').hair_natural
	var roll = (dice.roll(10)*10) + dice.roll(10) # 0-99
	var choice
	if roll <= 6:
		choice = hair_colors['blond']
	elif roll <= 14:
		choice = hair_colors['light_brown']
	elif roll <= 22:
		choice = hair_colors['brown']
	elif roll <= 42:
		choice = hair_colors['dark_brown']
	else:
		choice = hair_colors['black']
	return choice[dice.roll(choice.size())]

static func chest():
	return {
	'breast_size':2,
	'breast_variation':2,
	'chest_size':math.gaussian(28,3)}

static func penis():
	return abs(math.gaussian(2,1))

static func name(gender):
	var first_names
	if ["Male","Trans Male"].has(gender):
		first_names = first_names_male
	else:
		first_names = first_names_female
	var roll1 = floor(rand_range(0,first_names.size()))
	var roll2 = floor(rand_range(0,last_names.size()))
	return(first_names[roll1] + " " + last_names[roll2])

const first_names_male = [
	"Bora",
	"Chul",
	"Eun",
	"Gi",
	"Gun",
	"Gyeong",
	"Haneul",
	"Hoon",
	"Hwan",
	"Hyeon",
	"Hyuk",
	"Hyun",
	"Iseul",
	"Jae",
	"Jeong",
	"Joon",
	"Ki",
	"Kwan",
	"Kwang",
	"Kyung",
	"Myeong",
	"Myung",
	"Ok",
	"Seok",
	"Seong",
	"Suk",
	"Sung",
	"Uk",
	"Wook",
	"Yeong",
	"Young"]

const first_names_female = [
	"Bora", 
	"Chae-Won", 
	"Duri", 
	"Eun", 
	"Eun-Jeong", 
	"Eun-Ji", 
	"Eun-Jung", 
	"Eun-Seo", 
	"Eun-Yeong", 
	"Eun-Young", 
	"Gyeong", 
	"Gyeong-Hui", 
	"Gyeong-Ja", 
	"Gyeong-Suk", 
	"Ha-Yoon", 
	"Ha-Yun", 
	"Hana", 
	"Haneul", 
	"Hwan", 
	"Hye-Jin", 
	"Hyeon", 
	"Hyeon-Jeong", 
	"Hyeon-Ju", 
	"Hyun", 
	"Hyun-Joo", 
	"Hyun-Jung", 
	"Iseul", 
	"Jeon", 
	"Jeong-Hui", 
	"Jeong-Suk", 
	"Ji", "Ji-Ah", 
	"Ji-Eun", 
	"Ji-Hu", 
	"Ji-Hye", 
	"Ji-Min", 
	"Ji-U", 
	"Ji-Woo", 
	"Ji-Yeong", 
	"Ji-Young", 
	"Ji-Yu", 
	"Jong", 
	"Joo-Won", 
	"Ju-Won", 
	"Jun", 
	"Jung", 
	"Jung-Hee", 
	"Jung-Sook", 
	"Kyung", 
	"Kyung-Hee", 
	"Kyung-Ja", 
	"Kyung-Sook", 
	"Mei-Hui", 
	"Mei-Ling", 
	"Mi-Gyeong", 
	"Mi-Kyung", 
	"Mi-Suk", 
	"Min", 
	"Min-Ji", 
	"Min-Jun", 
	"Min-Seo", 
	"Min-Su", 
	"Myeong", 
	"Myeong-Suk", 
	"Myung", 
	"Nari", 
	"Sang", 
	"Seo-Hyeon", 
	"Seo-Hyun", 
	"Seo-Yeon", 
	"Seo-Yoon", 
	"Seo-Yun", 
	"Seong", 
	"Seong-Hyeon", 
	"Seong-Min", 
	"Seung", 
	"Shu-Fen", 
	"Shu-Hui", 
	"Soo-Jin", 
	"Su-Bin", 
	"Su-Jin", 
	"Suk-Ja", 
	"Sung", 
	"Sung-Hyun", 
	"Sung-Min", 
	"Ya-Ting", 
	"Yeong", 
	"Yeong-Hui", 
	"Yeong-Ja", 
	"Yeong-Suk", 
	"Yong", 
	"Yoon-Seo", 
	"Young", 
	"Young-Hee", 
	"Young-Ja", 
	"Young-Sook"]

const last_names = [
	"Ahn", 
	"An", 
	"Baek", 
	"Ban", 
	"Bang", 
	"Byun", 
	"Cha", 
	"Chae", 
	"Chang", 
	"Chin", 
	"Cho", 
	"Choe", 
	"Choi", 
	"Chon", 
	"Chun", 
	"Chung", 
	"Eom", 
	"Gil", 
	"Go", 
	"Gu", 
	"Gwon", 
	"Ha", 
	"Ham", 
	"Han", 
	"Hong", 
	"Hur", 
	"Hwang", 
	"Hyon", 
	"Hyun", 
	"Im", 
	"Jang", 
	"Jee", 
	"Jeon", 
	"Jeong", 
	"Ji", 
	"Jin", 
	"Jo", 
	"Jong", 
	"Joo", 
	"Ju", 
	"Jun", 
	"Jung", 
	"Kang", 
	"Ki", 
	"Kil", 
	"Kim", 
	"Ko", 
	"Koh", 
	"Koo", 
	"Ku", 
	"Kwak", 
	"Kweon", 
	"Kwon", 
	"Lee", 
	"Li", 
	"Lim", 
	"Ma", 
	"Maeng", 
	"Min", 
	"Mun", 
	"Na", 
	"Nam", 
	"Noh", 
	"O", 
	"Oh", 
	"Paik", 
	"Pak", 
	"Park", 
	"Rhee", 
	"Rho", 
	"Ri", 
	"Ro", 
	"Roh", 
	"Ryang", 
	"Ryoo", 
	"Ryu", 
	"Seo", 
	"Seong", 
	"Shim", 
	"Shin", 
	"Shon", 
	"Sim", 
	"Sin", 
	"Sohn", 
	"Son", 
	"Song", 
	"Su", 
	"Suh", 
	"Suk", 
	"Sun", 
	"Sung", 
	"Wang", 
	"Won", 
	"Woo", 
	"Yang", 
	"Yeo", 
	"Yi", 
	"Yim", 
	"Yoo", 
	"Yoon", 
	"Youn", 
	"Yu", 
	"Yun", 
	"Zhang"]
