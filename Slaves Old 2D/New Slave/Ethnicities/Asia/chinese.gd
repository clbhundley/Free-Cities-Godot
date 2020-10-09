
static func traits():
	return {
		name = name(),
		language = "Mandarin",
		skin_color = skin_color(),         # pale, white, tanned, yellow, olive, brown, black
		tissue_color = "dark",             # pink, dark
		hair_color_natural = hair_color(), # black, dark_brown, brown, light_brown, blond, red, grey
		hair_type = "straight",            # straight, wavy, curly, short, none
		eye_color = "brown",
		body_type = null,
		height = str(math.gaussian(155,8)) + " cm",
		weight = str(math.gaussian(57,8)) + " kg",
		breast_size = chest(),
		penis_size = penis()}

static func skin_color():
	var skin_colors = load('res://Slaves/New Slave/colors.gd').skin
	var roll = (dice.roll(10)*10) + dice.roll(10) # 0-99
	var choice
	if roll <= 4:
		choice = skin_colors['white']
	elif roll <= 28:
		choice = skin_colors['pale']
	else:
		choice = skin_colors['yellow']
	return choice[dice.roll(choice.size())]

static func hair_color():
	var hair_colors = load('res://Slaves/New Slave/colors.gd').hair_natural
	var roll = (dice.roll(10)*10) + dice.roll(10) # 0-99
	var choice
	if roll <= 3:
		choice = hair_colors['blond']
	elif roll <= 8:
		choice = hair_colors['light_brown']
	elif roll <= 12:
		choice = hair_colors['brown']
	elif roll <= 22:
		choice = hair_colors['dark_brown']
	else:
		choice = hair_colors['black']
	return choice[dice.roll(choice.size())]

# static func hair_style():

static func chest():
	return {
	'breast_size':2,
	'breast_variation':2,
	'chest_size':math.gaussian(28,3)}

static func penis():
	return abs(math.gaussian(2,1))

static func name():
	var first_names = ["Ah", "Ai", "An", "Bai", "Bao", "Bi", "Bo", "Cai", "Chang", "Chao", "Chen", "Cheng", "Chin", "Chun", "Da", "Dan", "Fang", "Fen", "Fu", "Guanting", "Guanyu", "Guiying", "Guo", "Hai", "He", "Heng", "Hong", "Hua", "Huan", "Huang", "Hui", "Jia", "Jian", "Jiang", "Jie", "Jin", "Jing", "Jingyi", "Ju", "Juan", "Jun", "Kun", "Lan", "Lei", "Li", "Lian", "Lili", "Lim", "Lin", "Ling", "Mei", "Min", "Ming", "Mu", "Na", "Ni", "Ning", "Nuan", "Ping", "Qian", "Qing", "Qiong", "Qiu", "Rong", "Ru", "Shan", "Shi", "Shu", "Shufen", "Shui", "Shun", "Su", "Tai", "Ting", "Tingting", "Tu", "Wei", "Wen", "Wu", "Xia", "Xian", "Xiang", "Xiaomei", "Xiaoyan", "Xinyi", "Xiu", "Xiulan", "Xiuying", "Xue", "Xun", "Ya", "Yahui", "Yaling", "Yan", "Yang", "Yating", "Yawen", "Yazhu", "Yi", "Yijun", "Yin", "Ying", "Yong", "Yu", "Yun", "Zan", "Zedong", "Zhen", "Zheng", "Zhi", "Zhihao", "Zhong", "Zhou"]
	var last_names = ["Bai", "Bi", "Cai", "Cao", "Chang", "Chao", "Cheng", "Cheung", "Chu", "Cui", "Dai", "Deng", "Ding", "Dong", "Du", "Fan", "Fang", "Feng", "Fu", "Gao", "Ge", "Gong", "Gu", "Guan", "Guo", "Han", "Hao", "He", "Ho", "Hong", "Hou", "Hu", "Hua", "Huang", "Ji", "Jia", "Jiang", "Jin", "Kuang", "Lam", "Lau", "Lei", "Li", "Lian", "Liang", "Liao", "Lin", "Ling", "Liu", "Lu", "Luo", "Ma", "Mao", "Meng", "Miao", "Ni", "Ouyang", "Pan", "Peng", "Qi", "Qian", "Qin", "Qiu", "Rao", "Ren", "Ruan", "Shang", "Shao", "Shen", "Shi", "Song", "Su", "Sun", "Tan", "Tang", "Tao", "Tian", "Ting", "Tong", "Wan", "Wang", "Wei", "Wen", "Weng", "Wu", "Xi", "Xia", "Xiang", "Xiao", "Xie", "Xiong", "Xu", "Xue", "Yan", "Yang", "Yao", "Ye", "Yi", "Yin", "Yu", "Yuan", "Yun", "Zeng", "Zhang", "Zhao", "Zheng", "Zhong", "Zhou", "Zhu", "Zhuang", "Zou"]
	var roll1 = floor(rand_range(0,first_names.size()))
	var roll2 = floor(rand_range(0,last_names.size()))
	return(first_names[roll1] + " " + last_names[roll2])
