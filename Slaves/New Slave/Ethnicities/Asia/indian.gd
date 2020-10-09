
static func traits():
	return {
		name = name(),
		language = "Hindi",
		skin_color = skin_color(),         # pale, white, tanned, yellow, olive, brown, black
		tissue_color = "dark",             # pink, dark
		hair_color_natural = hair_color(), # black, dark_brown, brown, light_brown, blond, red, grey
		hair_type = "straight",            # straight, wavy, curly, short, none
		eye_color = "brown",
		body_type = null,
		height = str(math.gaussian(152,10)) + " cm",
		weight = str(math.gaussian(53,8)) + " kg",
		breast_size = chest(),
		penis_size = penis()}

static func skin_color():
	var skin_colors = load('res://Slaves/New Slave/colors.gd').skin
	var roll = (dice.roll(10)*10) + dice.roll(10) # 0-99
	var choice
	if roll <= 8:
		choice = skin_colors['tanned']
	elif roll <= 26:
		choice = skin_colors['brown']
	else:
		choice = skin_colors['olive']
	return choice[dice.roll(choice.size())]

static func hair_color():
	var hair_colors = load('res://Slaves/New Slave/colors.gd').hair_natural
	var roll = (dice.roll(10)*10) + dice.roll(10) # 0-99
	var choice
	if roll <= 8:
		choice = hair_colors['light_brown']
	elif roll <= 22:
		choice = hair_colors['brown']
	elif roll <= 38:
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
	var first_names = ["Aadhira", "Aadhya", "Aaloka", "Aanya", "Aaradhya", "Aashi", "Aashirya", "Adhira", "Adhita", "Ahalya", "Aktu", "Akuti", "Alisha", "Alka", "Alpana", "Ana", "Ananya", "Anaya", "Anicha", "Anika", "Anindita", "Anisha", "Anishaa", "Annapurna", "Anshu", "Anshula", "Anupa", "Anura", "Aradhya", "Avika", "Avnita", "Ayush", "Barkha", "Bela", "Bhakti", "Bhamini", "Bijal", "Brinda", "Chaitalee", "Chaitali", "Chameli", "Champa", "Charita", "Charu", "Chhaya", "Dyuti", "Harini", "Harsha", "Harshika", "Hemanga", "Hemangi", "Hena", "Henna", "Ila", "Ina", "Indira", "Jyotis", "Jyotsnapriya", "Kahaani", "Kalka", "Kalya", "Lily", "Lipi", "Lipika", "Lola", "Lopa", "Lorena", "Madhu", "Madhumalati", "Madhur", "Madhuri", "Mahak", "Manjula", "Manjusri", "Maruthini", "Maya", "Meena", "Meeta", "Minati", "Mini", "Mira", "Mita", "Muthammani", "Myra", "Nalika", "Navya", "Neena", "Netra", "Niharika", "Nihira", "Nikhita", "Nikk", "Nila", "Nima", "Nimeesha", "Nina", "Nirali", "Niranjana", "Nirmala", "Nirmayi", "Nirupama", "Nisha", "Nishi", "Nishikanta", "Nishita", "Nishithini", "Nishtha", "Niti", "Nitya", "Nityapriya", "Nivedita", "Niyati", "Noopur", "Noori", "Pari", "Parni", "Parnika", "Parvati", "Parveen", "Pavana", "Pia", "Pooja", "Poonam", "Poorbi", "Poorna", "Priya", "Puja", "Raaya", "Rajasi", "Raji", "Rajkumari", "Rajvi", "Raka", "Ramani", "Ramanika", "Rambha", "Rasika", "Ridhi", "Rishika", "Saanvi", "Sanvi", "Sarakshi", "Sargam", "Sarika", "Sati", "Satvinder", "Satya", "Savita", "Shalaka", "Shanaya", "Shital", "Shoni", "Shreya", "Shubhi", "Shuchi", "Shweta", "Shyama", "Siddhima", "Supriya", "Sushma", "Susmita", "Suvarnarekha", "Svadhi", "Tanaya", "Tanu", "Tanuja", "Tia", "Toshale", "Triya", "Udita", "Ulka", "Uma", "Urja", "Urmi", "Urvi", "Ushma", "Ushmil", "Vibha", "Vidya", "Vilina", "Vinita", "Vishaka", "Wakeeta", "Yana", "Yashila", "Yashoda", "Yatee", "Yojana", "Yoshita", "Yukta", "Yukti"]
	var last_names = ["Ahmed", "Alam", "Ali", "Ansari", "Babu", "Bag", "Bai", "Bala", "Bano", "Barman", "Basumatary", "Begam", "Begum", "Bewa", "Bibi", "Biswas", "Chahan", "Chand", "Chandra", "Chaudhari", "Chaudhary", "Das", "Deshmukh", "Devi", "Dey", "Dutta", "Gandhi", "Gayakwad", "Ghosh", "Gogoi", "Gupta", "Halder", "Hansda", "Hembram", "Islam", "Jadhav", "Jahan", "Jain", "Jena", "Jha", "Kadam", "Kamble", "Kaur", "Khan", "Khatoon", "Khatun", "Koli", "Kumar", "Kumari", "Lal", "Mahato", "Maheswaran", "Mahto", "Malik", "Mandal", "Marandi", "Menon", "Miya", "Mohammad", "Mohammed", "Mondal", "Munda", "Murmu", "Naik", "Nair", "Nayak", "Oraon", "Pal", "Panda", "Pandey", "Paramar", "Patal", "Patel", "Patil", "Paul", "Pir", "Pradhan", "Prasad", "Rai", "Raj", "Rajput", "Ram", "Rana", "Rani", "Rath", "Rathod", "Raut", "Ray", "Reddy", "Roy", "Sah", "Sahoo", "Sahu", "Sangma", "Sarkar", "Shaikh", "Sharma", "Sheikh", "Shek", "Shinde", "Singh", "Sinh", "Solank", "Solanki", "Soren", "Thakor", "Thampan", "Thampi", "Tudu", "Vaghel", "Varmna", "Vasav", "Wakil", "Yadav"]
	var roll1 = floor(rand_range(0,first_names.size()))
	var roll2 = floor(rand_range(0,last_names.size()))
	return(first_names[roll1] + " " + last_names[roll2])
