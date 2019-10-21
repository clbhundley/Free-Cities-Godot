
static func traits():
	return {
		name = name(),
		language = "Korean",
		skin_color = skin_color(),  # pale, white, fair, yellow, tanned, olive, brown, dark_brown, black
		tissue_color = "pink",  # pink, dark
		hair_type = "straight", # straight, wavy, curly, none
		hair_color = "black",
		eye_color = "brown",
		body_type = null,
		height = str(game.gaussian(157,8)) + " cm",
		weight = str(game.gaussian(57,8)) + " kg",
		breast_size = chest(),
		penis_size = penis()}

static func skin_color():
	return ['ffdbac','ebcba2','e1bb97','fff0df','e6d4c1','ffe0bd','f1c27d','d8b075','dba961'][randi()%9+0]

static func chest():
	return {
	'breast_size':2,
	'breast_variation':2,
	'chest_size':game.gaussian(28,3)}

static func penis():
	var size = game.gaussian(2,1)
	if size < 0:
		size = 0
	return size

static func name():
	var first_names = ["Bora", "Chae-Won", "Duri", "Eun", "Eun-Jeong", "Eun-Ji", "Eun-Jung", "Eun-Seo", "Eun-Yeong", "Eun-Young", "Gyeong", "Gyeong-Hui", "Gyeong-Ja", "Gyeong-Suk", "Ha-Yoon", "Ha-Yun", "Hana", "Haneul", "Hwan", "Hye-Jin", "Hyeon", "Hyeon-Jeong", "Hyeon-Ju", "Hyun", "Hyun-Joo", "Hyun-Jung", "Iseul", "Jeon", "Jeong-Hui", "Jeong-Suk", "Ji", "Ji-Ah", "Ji-Eun", "Ji-Hu", "Ji-Hye", "Ji-Min", "Ji-U", "Ji-Woo", "Ji-Yeong", "Ji-Young", "Ji-Yu", "Jong", "Joo-Won", "Ju-Won", "Jun", "Jung", "Jung-Hee", "Jung-Sook", "Kyung", "Kyung-Hee", "Kyung-Ja", "Kyung-Sook", "Mei-Hui", "Mei-Ling", "Mi-Gyeong", "Mi-Kyung", "Mi-Suk", "Min", "Min-Ji", "Min-Jun", "Min-Seo", "Min-Su", "Myeong", "Myeong-Suk", "Myung", "Nari", "Sang", "Seo-Hyeon", "Seo-Hyun", "Seo-Yeon", "Seo-Yoon", "Seo-Yun", "Seong", "Seong-Hyeon", "Seong-Min", "Seung", "Shu-Fen", "Shu-Hui", "Soo-Jin", "Su-Bin", "Su-Jin", "Suk-Ja", "Sung", "Sung-Hyun", "Sung-Min", "Ya-Ting", "Yeong", "Yeong-Hui", "Yeong-Ja", "Yeong-Suk", "Yong", "Yoon-Seo", "Young", "Young-Hee", "Young-Ja", "Young-Sook"]
	var last_names = ["Ahn", "An", "Baek", "Ban", "Bang", "Byun", "Cha", "Chae", "Chang", "Chin", "Cho", "Choe", "Choi", "Chon", "Chun", "Chung", "Eom", "Gil", "Go", "Gu", "Gwon", "Ha", "Ham", "Han", "Hong", "Hur", "Hwang", "Hyon", "Hyun", "Im", "Jang", "Jee", "Jeon", "Jeong", "Ji", "Jin", "Jo", "Jong", "Joo", "Ju", "Jun", "Jung", "Kang", "Ki", "Kil", "Kim", "Ko", "Koh", "Koo", "Ku", "Kwak", "Kweon", "Kwon", "Lee", "Li", "Lim", "Ma", "Maeng", "Min", "Mun", "Na", "Nam", "Noh", "O", "Oh", "Paik", "Pak", "Park", "Rhee", "Rho", "Ri", "Ro", "Roh", "Ryang", "Ryoo", "Ryu", "Seo", "Seong", "Shim", "Shin", "Shon", "Sim", "Sin", "Sohn", "Son", "Song", "Su", "Suh", "Suk", "Sun", "Sung", "Wang", "Won", "Woo", "Yang", "Yeo", "Yi", "Yim", "Yoo", "Yoon", "Youn", "Yu", "Yun", "Zhang"]
	var roll1 = floor(rand_range(0,first_names.size()))
	var roll2 = floor(rand_range(0,last_names.size()))
	return(first_names[roll1] + " " + last_names[roll2])
