
static func traits():
	return {
		name = name(),
		language = "Hindi",
		skin_color = skin_color(),  # pale, white, fair, yellow, tanned, olive, brown, dark_brown, black
		tissue_color = "dark",  # pink, dark
		hair_type = "straight", # straight, wavy, curly, none
		hair_color = "black",
		eye_color = "brown",
		body_type = null,
		height = str(math.gaussian(152,10)) + " cm",
		weight = str(math.gaussian(53,8)) + " kg",
		breast_size = chest(),
		penis_size = penis()}

static func skin_color():
	return ['eac086','da9b55','ba8040'][randi()%3+0]

static func chest():
	return {
	'breast_size':2,
	'breast_variation':2,
	'chest_size':math.gaussian(28,3)}

static func penis():
	var size = math.gaussian(2,1)
	if size < 0:
		size = 0
	return size

static func name():
	var first_names = ["Aadhira", "Aadhya", "Aaloka", "Aanya", "Aaradhya", "Aashi", "Aashirya", "Adhira", "Adhita", "Ahalya", "Aktu", "Akuti", "Alisha", "Alka", "Alpana", "Ana", "Ananya", "Anaya", "Anicha", "Anika", "Anindita", "Anisha", "Anishaa", "Annapurna", "Anshu", "Anshula", "Anupa", "Anura", "Aradhya", "Avika", "Avnita", "Ayush", "Barkha", "Bela", "Bhakti", "Bhamini", "Bijal", "Brinda", "Chaitalee", "Chaitali", "Chameli", "Champa", "Charita", "Charu", "Chhaya", "Dyuti", "Harini", "Harsha", "Harshika", "Hemanga", "Hemangi", "Hena", "Henna", "Ila", "Ina", "Indira", "Jyotis", "Jyotsnapriya", "Kahaani", "Kalka", "Kalya", "Lily", "Lipi", "Lipika", "Lola", "Lopa", "Lorena", "Madhu", "Madhumalati", "Madhur", "Madhuri", "Mahak", "Manjula", "Manjusri", "Maruthini", "Maya", "Meena", "Meeta", "Minati", "Mini", "Mira", "Mita", "Muthammani", "Myra", "Nalika", "Navya", "Neena", "Netra", "Niharika", "Nihira", "Nikhita", "Nikk", "Nila", "Nima", "Nimeesha", "Nina", "Nirali", "Niranjana", "Nirmala", "Nirmayi", "Nirupama", "Nisha", "Nishi", "Nishikanta", "Nishita", "Nishithini", "Nishtha", "Niti", "Nitya", "Nityapriya", "Nivedita", "Niyati", "Noopur", "Noori", "Pari", "Parni", "Parnika", "Parvati", "Parveen", "Pavana", "Pia", "Pooja", "Poonam", "Poorbi", "Poorna", "Priya", "Puja", "Raaya", "Rajasi", "Raji", "Rajkumari", "Rajvi", "Raka", "Ramani", "Ramanika", "Rambha", "Rasika", "Ridhi", "Rishika", "Saanvi", "Sanvi", "Sarakshi", "Sargam", "Sarika", "Sati", "Satvinder", "Satya", "Savita", "Shalaka", "Shanaya", "Shital", "Shoni", "Shreya", "Shubhi", "Shuchi", "Shweta", "Shyama", "Siddhima", "Supriya", "Sushma", "Susmita", "Suvarnarekha", "Svadhi", "Tanaya", "Tanu", "Tanuja", "Tia", "Toshale", "Triya", "Udita", "Ulka", "Uma", "Urja", "Urmi", "Urvi", "Ushma", "Ushmil", "Vibha", "Vidya", "Vilina", "Vinita", "Vishaka", "Wakeeta", "Yana", "Yashila", "Yashoda", "Yatee", "Yojana", "Yoshita", "Yukta", "Yukti"]
	var last_names = ["Ahmed", "Alam", "Ali", "Ansari", "Babu", "Bag", "Bai", "Bala", "Bano", "Barman", "Basumatary", "Begam", "Begum", "Bewa", "Bibi", "Biswas", "Chahan", "Chand", "Chandra", "Chaudhari", "Chaudhary", "Das", "Deshmukh", "Devi", "Dey", "Dutta", "Gandhi", "Gayakwad", "Ghosh", "Gogoi", "Gupta", "Halder", "Hansda", "Hembram", "Islam", "Jadhav", "Jahan", "Jain", "Jena", "Jha", "Kadam", "Kamble", "Kaur", "Khan", "Khatoon", "Khatun", "Koli", "Kumar", "Kumari", "Lal", "Mahato", "Maheswaran", "Mahto", "Malik", "Mandal", "Marandi", "Menon", "Miya", "Mohammad", "Mohammed", "Mondal", "Munda", "Murmu", "Naik", "Nair", "Nayak", "Oraon", "Pal", "Panda", "Pandey", "Paramar", "Patal", "Patel", "Patil", "Paul", "Pir", "Pradhan", "Prasad", "Rai", "Raj", "Rajput", "Ram", "Rana", "Rani", "Rath", "Rathod", "Raut", "Ray", "Reddy", "Roy", "Sah", "Sahoo", "Sahu", "Sangma", "Sarkar", "Shaikh", "Sharma", "Sheikh", "Shek", "Shinde", "Singh", "Sinh", "Solank", "Solanki", "Soren", "Thakor", "Thampan", "Thampi", "Tudu", "Vaghel", "Varmna", "Vasav", "Wakil", "Yadav"]
	var roll1 = floor(rand_range(0,first_names.size()))
	var roll2 = floor(rand_range(0,last_names.size()))
	return(first_names[roll1] + " " + last_names[roll2])
