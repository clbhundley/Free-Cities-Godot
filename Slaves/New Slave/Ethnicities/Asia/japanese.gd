
static func traits(gender):
	return {
		name = name(gender),
		language = "Japanese",
		skin_color = skin_color(),         # pale, white, tanned, yellow, olive, brown, black
		tissue_color = "dark",             # pink, dark
		hair_color_natural = hair_color(), # black, dark_brown, brown, light_brown, blond, red, grey
		hair_type = "straight",            # straight, wavy, curly, short, none
		eye_color = "brown",
		body_type = null,
		height = str(math.gaussian(158,8)) + " cm",
		weight = str(math.gaussian(52,8)) + " kg",
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
	"Aito",
	"Akio",
	"Akira",
	"Daichi",
	"Daiki",
	"Daisuke",
	"Eiichi",
	"Eiji",
	"Eito",
	"Fumihiro",
	"Giichi",
	"Hansuke",
	"Haruki",
	"Hibiki",
	"Hideo",
	"Hikaru",
	"Hiroaki",
	"Hirohito",
	"Hiroki",
	"Hiromichi",
	"Hiromitsu",
	"Hironori",
	"Hiroshi",
	"Hiroto",
	"Hiroyuki",
	"Hisao",
	"hisashi",
	"Hisato",
	"Hitomu",
	"Hitoshi",
	"hyousuke",
	"Ichiro",
	"Ikki",
	"Isao",
	"Itsuki",
	"Itsuo",
	"Izumi",
	"Katsumi",
	"kazue",
	"Kazumi",
	"Kenzou",
	"Kyoshi",
	"Kobe",
	"Koji",
	"Kosuke",
	"Kouichi",
	"Kousuke",
	"Mitsue",
	"Naoki",
	"Naoyuki",
	"Naozumi",
	"Natsuo",
	"Noritaka",
	"Raiden",
	"Reiji",
	"Ren",
	"Riichi",
	"Saburo",
	"Sachihiro",
	"Seiichi",
	"Shinsuke",
	"Shusuke",
	"Sora",
	"Souji",
	"Subaru",
	"Tadaaki",
	"Tadashi",
	"Taichi",
	"Takahiro",
	"Tatsuo",
	"Tatsuya",
	"Tetsu",
	"Tomiichi",
	"Tomo",
	"Tomohiro",
	"Tomomi",
	"Toshiro",
	"Tsubasa",
	"Tsukiya",
	"Yamato",
	"Yasahiro",
	"Yasuhiro",
	"Yo",
	"Yokuto",
	"Yoshi",
	"Yoshiaki",
	"Yoshimi",
	"Yoshio",
	"Yosuke",
	"Yousuke",
	"Yukio"]

const first_names_female = [
	"Ai", 
	"Aika", 
	"Aiko", 
	"Aimi", 
	"Aina", 
	"Airi", 
	"Akane", 
	"Akari", 
	"Akemi", 
	"Aki", 
	"Akiko", 
	"Akira", 
	"Ami", 
	"Anna", 
	"Aoi", 
	"Asuka", 
	"Atsuko", 
	"Aya", 
	"Ayaka", 
	"Ayako", 
	"Ayame", 
	"Ayane", 
	"Ayano", 
	"Ayumi", 
	"Chidori", 
	"Chie", 
	"Chihiro", 
	"Chika", 
	"Chikako", 
	"Chinatsu", 
	"Chiyo", 
	"Chiyoko", 
	"Cho", 
	"Chou", 
	"Chouko", 
	"Emi", 
	"Erika", 
	"Etsuko", 
	"Futaba", 
	"Fuuka", 
	"Hana", 
	"Hanae", 
	"Hanako", 
	"Haru", 
	"Haruka", 
	"Haruko", 
	"Haruna", 
	"Hibiki", 
	"Hikari", 
	"Hikaru", 
	"Hina", 
	"Hinata", 
	"Hiroko", 
	"Hitomi", 
	"Honoka", 
	"Hoshi", 
	"Hoshiko", 
	"Hotaru", 
	"Izumi", 
	"Junko", 
	"Kaede", 
	"Kana", 
	"Kanako", 
	"Kanon", 
	"Kaori", 
	"Kaoru", 
	"Kasumi", 
	"Kazue", 
	"Kazuko", 
	"Keiko", 
	"Kiku", 
	"Kimiko", 
	"Kiyoko", 
	"Kohaku", 
	"Koharu", 
	"Kokoro", 
	"Kotone", 
	"Kumiko", 
	"Kyo", 
	"Kyou", 
	"Mai", 
	"Maki", 
	"Makoto", 
	"Mami", 
	"Manami", 
	"Mao", 
	"Mari", 
	"Mariko", 
	"Marina", 
	"Masami", 
	"Masuyo", 
	"Mayu", 
	"Megumi", 
	"Mei", 
	"Michi", 
	"Michiko", 
	"Midori", 
	"Miho", 
	"Mika", 
	"Miki", 
	"Miku", 
	"Minako", 
	"Minami", 
	"Minato", 
	"Minoru", 
	"Mio", 
	"Misaki", 
	"Mitsuko", 
	"Mitsuru", 
	"Miu", 
	"Miyako", 
	"Miyu", 
	"Mizuki", 
	"Moe", 
	"Momoka", 
	"Momoko", 
	"Moriko", 
	"Nana", 
	"Nanako", 
	"Nanami", 
	"Nao", 
	"Naoko", 
	"Naomi", 
	"Naoto", 
	"Natsuki", 
	"Natsuko", 
	"Natsumi", 
	"Noa", 
	"Noriko", 
	"Ran", 
	"Rei", 
	"Ren", 
	"Riko", 
	"Rin", 
	"Rina", 
	"Rio", 
	"Risa", 
	"Sachiko", 
	"Sadayo", 
	"Sae", 
	"Saeko", 
	"Saki", 
	"Sakura", 
	"Sakurako", 
	"Satomi", 
	"Saya", 
	"Sayaka", 
	"Sayuri", 
	"Setsuko", 
	"Shiho", 
	"Shinju", 
	"Shinobu", 
	"Shiori", 
	"Shizuka", 
	"Shun", 
	"Sora", 
	"Sumiko", 
	"Suzu", 
	"Suzume", 
	"Takako", 
	"Takara", 
	"Tamiko", 
	"Tomiko", 
	"Tomoko", 
	"Tomomi", 
	"Tsubaki", 
	"Tsubame", 
	"Tsubasa", 
	"Tsukiko", 
	"Ulala", 
	"Ume", 
	"Umeko", 
	"Wakana", 
	"Yasu", 
	"Yoko", 
	"Yoshi", 
	"Yoshiko", 
	"Youko", 
	"Yua", 
	"Yui", 
	"Yuina", 
	"Yuka", 
	"Yukari", 
	"Yuki", 
	"Yukiko", 
	"Yukino", 
	"Yuko", 
	"Yumi", 
	"Yumiko", 
	"Yuri", 
	"Yuu", 
	"Yuuka", 
	"Yuuki", 
	"Yuuko", 
	"Yuuna", 
	"Yuzuki"]

const last_names = [
	"Abe", 
	"Adachi", 
	"Akechi", 
	"Amada", 
	"Amagi", 
	"Amano", 
	"Ando", 
	"Aoki", 
	"Aragaki", 
	"Arai", 
	"Arisato", 
	"Ayase", 
	"Dojima", 
	"Ebihara", 
	"Endo", 
	"Fujii", 
	"Fujita", 
	"Fujiwara", 
	"Fukuda", 
	"Fukuda", 
	"Goto", 
	"Hara", 
	"Harada", 
	"Hasegawa", 
	"Hashimoto", 
	"Hayashi", 
	"Honda", 
	"Hoshi", 
	"Ikeda", 
	"Imai", 
	"Inaba", 
	"Inoue", 
	"Iori", 
	"Ishida", 
	"Ishii", 
	"Ishikawa", 
	"Ito", 
	"Kan", 
	"Kaneko", 
	"Kashiwagi", 
	"Kato", 
	"Kawakami", 
	"Kawamura", 
	"Kido", 
	"Kikichu", 
	"Kimura", 
	"Kirijo", 
	"Kirishima", 
	"Kitagawa", 
	"Kobayashi", 
	"Koizumi", 
	"Kondo", 
	"Kos", 
	"Kujikawa", 
	"Kurusu", 
	"Li", 
	"Maeda", 
	"Masuda", 
	"Matsuda", 
	"Matsumoto", 
	"Matsunaga", 
	"Mayuzumi", 
	"Mishima", 
	"Mishina", 
	"Miura", 
	"Miyamoto", 
	"Miyazaki", 
	"Mori", 
	"Morita", 
	"Mtsui", 
	"Murakami", 
	"Murata", 
	"Nakagawa", 
	"Nakajima", 
	"Nakamura", 
	"Nakano", 
	"Nakayama", 
	"Nanjo", 
	"Narukami", 
	"Niijima", 
	"Nishimura", 
	"Noda", 
	"Ogawa", 
	"Okada", 
	"Okamoto", 
	"Ono", 
	"Ota", 
	"Ozawa", 
	"Saito", 
	"Sakai", 
	"Sakamoto", 
	"Sakura", 
	"Sakurai", 
	"Sanada", 
	"Sasaki", 
	"Sato", 
	"Satonaka", 
	"Serizawa", 
	"Shibata", 
	"Shimada", 
	"Shimizu", 
	"Shirogane", 
	"Sonomura", 
	"Sudou", 
	"Suou", 
	"Suzuki", 
	"Takagi", 
	"Takahashi", 
	"Takami", 
	"Takeba", 
	"Takeda", 
	"Takeuchi", 
	"Tamura", 
	"Tanaka", 
	"Tatsumi", 
	"Toudou", 
	"Uchida", 
	"Ueda", 
	"Ueno", 
	"Ueseugi", 
	"Wada", 
	"Wang", 
	"Watanabe", 
	"Yamada", 
	"Yamagishi", 
	"Yamaguchi", 
	"Yamamoto", 
	"Yamashita", 
	"Yamazaki", 
	"Yokoyama", 
	"Yoshida", 
	"Yoshino", 
	"Yuuki"]
