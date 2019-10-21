
static func traits():
	return {
		name = name(),
		language = "Mandarin",
		skin_color = skin_color(),  # pale, white, fair, yellow, tanned, olive, brown, dark_brown, black
		tissue_color = "dark",  # pink, dark
		hair_type = "straight", # straight, wavy, curly, none
		hair_color = "black",
		eye_color = "brown",
		body_type = null,
		height = str(game.gaussian(155,8)) + " cm",
		weight = str(game.gaussian(57,8)) + " kg",
		breast_size = chest(),
		penis_size = penis()}

static func skin_color():
	return ['ffe39f','dec676','ceb563'][randi()%3+0]

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
	var first_names = ["Ah", "Ai", "An", "Bai", "Bao", "Bi", "Bo", "Cai", "Chang", "Chao", "Chen", "Cheng", "Chin", "Chun", "Da", "Dan", "Fang", "Fen", "Fu", "Guanting", "Guanyu", "Guiying", "Guo", "Hai", "He", "Heng", "Hong", "Hua", "Huan", "Huang", "Hui", "Jia", "Jian", "Jiang", "Jie", "Jin", "Jing", "Jingyi", "Ju", "Juan", "Jun", "Kun", "Lan", "Lei", "Li", "Lian", "Lili", "Lim", "Lin", "Ling", "Mei", "Min", "Ming", "Mu", "Na", "Ni", "Ning", "Nuan", "Ping", "Qian", "Qing", "Qiong", "Qiu", "Rong", "Ru", "Shan", "Shi", "Shu", "Shufen", "Shui", "Shun", "Su", "Tai", "Ting", "Tingting", "Tu", "Wei", "Wen", "Wu", "Xia", "Xian", "Xiang", "Xiaomei", "Xiaoyan", "Xinyi", "Xiu", "Xiulan", "Xiuying", "Xue", "Xun", "Ya", "Yahui", "Yaling", "Yan", "Yang", "Yating", "Yawen", "Yazhu", "Yi", "Yijun", "Yin", "Ying", "Yong", "Yu", "Yun", "Zan", "Zedong", "Zhen", "Zheng", "Zhi", "Zhihao", "Zhong", "Zhou"]
	var last_names = ["Bai", "Bi", "Cai", "Cao", "Chang", "Chao", "Cheng", "Cheung", "Chu", "Cui", "Dai", "Deng", "Ding", "Dong", "Du", "Fan", "Fang", "Feng", "Fu", "Gao", "Ge", "Gong", "Gu", "Guan", "Guo", "Han", "Hao", "He", "Ho", "Hong", "Hou", "Hu", "Hua", "Huang", "Ji", "Jia", "Jiang", "Jin", "Kuang", "Lam", "Lau", "Lei", "Li", "Lian", "Liang", "Liao", "Lin", "Ling", "Liu", "Lu", "Luo", "Ma", "Mao", "Meng", "Miao", "Ni", "Ouyang", "Pan", "Peng", "Qi", "Qian", "Qin", "Qiu", "Rao", "Ren", "Ruan", "Shang", "Shao", "Shen", "Shi", "Song", "Su", "Sun", "Tan", "Tang", "Tao", "Tian", "Ting", "Tong", "Wan", "Wang", "Wei", "Wen", "Weng", "Wu", "Xi", "Xia", "Xiang", "Xiao", "Xie", "Xiong", "Xu", "Xue", "Yan", "Yang", "Yao", "Ye", "Yi", "Yin", "Yu", "Yuan", "Yun", "Zeng", "Zhang", "Zhao", "Zheng", "Zhong", "Zhou", "Zhu", "Zhuang", "Zou"]
	var roll1 = floor(rand_range(0,first_names.size()))
	var roll2 = floor(rand_range(0,last_names.size()))
	return(first_names[roll1] + " " + last_names[roll2])
