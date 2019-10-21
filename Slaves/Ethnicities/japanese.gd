
static func traits():
	return {
		name = name(),
		language = "Japanese",
		skin_color = skin_color(),  # pale, white, fair, yellow, tanned, olive, brown, dark_brown, black
		tissue_color = "dark",  # pink, dark
		hair_type = "straight", # straight, wavy, curly, none
		hair_color = "black",
		eye_color = "brown",
		body_type = null,
		height = str(game.gaussian(158,8)) + " cm",
		weight = str(game.gaussian(52,8)) + " kg",
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
	var first_names = ["Ai", "Aika", "Aiko", "Aimi", "Aina", "Airi", "Akane", "Akari", "Akemi", "Aki", "Akiko", "Akira", "Ami", "Anna", "Aoi", "Asuka", "Atsuko", "Aya", "Ayaka", "Ayako", "Ayame", "Ayane", "Ayano", "Ayumi", "Chidori", "Chie", "Chihiro", "Chika", "Chikako", "Chinatsu", "Chiyo", "Chiyoko", "Cho", "Chou", "Chouko", "Emi", "Erika", "Etsuko", "Futaba", "Fuuka", "Hana", "Hanae", "Hanako", "Haru", "Haruka", "Haruko", "Haruna", "Hibiki", "Hikari", "Hikaru", "Hina", "Hinata", "Hiroko", "Hitomi", "Honoka", "Hoshi", "Hoshiko", "Hotaru", "Izumi", "Junko", "Kaede", "Kana", "Kanako", "Kanon", "Kaori", "Kaoru", "Kasumi", "Kazue", "Kazuko", "Keiko", "Kiku", "Kimiko", "Kiyoko", "Kohaku", "Koharu", "Kokoro", "Kotone", "Kumiko", "Kyo", "Kyou", "Mai", "Maki", "Makoto", "Mami", "Manami", "Mao", "Mari", "Mariko", "Marina", "Masami", "Masuyo", "Mayu", "Megumi", "Mei", "Michi", "Michiko", "Midori", "Miho", "Mika", "Miki", "Miku", "Minako", "Minami", "Minato", "Minoru", "Mio", "Misaki", "Mitsuko", "Mitsuru", "Miu", "Miyako", "Miyu", "Mizuki", "Moe", "Momoka", "Momoko", "Moriko", "Nana", "Nanako", "Nanami", "Nao", "Naoko", "Naomi", "Naoto", "Natsuki", "Natsuko", "Natsumi", "Noa", "Noriko", "Ran", "Rei", "Ren", "Riko", "Rin", "Rina", "Rio", "Risa", "Sachiko", "Sadayo", "Sae", "Saeko", "Saki", "Sakura", "Sakurako", "Satomi", "Saya", "Sayaka", "Sayuri", "Setsuko", "Shiho", "Shinju", "Shinobu", "Shiori", "Shizuka", "Shun", "Sora", "Sumiko", "Suzu", "Suzume", "Takako", "Takara", "Tamiko", "Tomiko", "Tomoko", "Tomomi", "Tsubaki", "Tsubame", "Tsubasa", "Tsukiko", "Ulala", "Ume", "Umeko", "Wakana", "Yasu", "Yoko", "Yoshi", "Yoshiko", "Youko", "Yua", "Yui", "Yuina", "Yuka", "Yukari", "Yuki", "Yukiko", "Yukino", "Yuko", "Yumi", "Yumiko", "Yuri", "Yuu", "Yuuka", "Yuuki", "Yuuko", "Yuuna", "Yuzuki"]
	var last_names = ["Abe", "Adachi", "Akechi", "Amada", "Amagi", "Amano", "Ando", "Aoki", "Aragaki", "Arai", "Arisato", "Ayase", "Dojima", "Ebihara", "Endo", "Fujii", "Fujita", "Fujiwara", "Fukuda", "Fukuda", "Goto", "Hara", "Harada", "Hasegawa", "Hashimoto", "Hayashi", "Honda", "Hoshi", "Ikeda", "Imai", "Inaba", "Inoue", "Iori", "Ishida", "Ishii", "Ishikawa", "Ito", "Kan", "Kaneko", "Kashiwagi", "Kato", "Kawakami", "Kawamura", "Kido", "Kikichu", "Kimura", "Kirijo", "Kirishima", "Kitagawa", "Kobayashi", "Koizumi", "Kondo", "Kos", "Kujikawa", "Kurusu", "Li", "Maeda", "Masuda", "Matsuda", "Matsumoto", "Matsunaga", "Mayuzumi", "Mishima", "Mishina", "Miura", "Miyamoto", "Miyazaki", "Mori", "Morita", "Mtsui", "Murakami", "Murata", "Nakagawa", "Nakajima", "Nakamura", "Nakano", "Nakayama", "Nanjo", "Narukami", "Niijima", "Nishimura", "Noda", "Ogawa", "Okada", "Okamoto", "Ono", "Ota", "Ozawa", "Saito", "Sakai", "Sakamoto", "Sakura", "Sakurai", "Sanada", "Sasaki", "Sato", "Satonaka", "Serizawa", "Shibata", "Shimada", "Shimizu", "Shirogane", "Sonomura", "Sudou", "Suou", "Suzuki", "Takagi", "Takahashi", "Takami", "Takeba", "Takeda", "Takeuchi", "Tamura", "Tanaka", "Tatsumi", "Toudou", "Uchida", "Ueda", "Ueno", "Ueseugi", "Wada", "Wang", "Watanabe", "Yamada", "Yamagishi", "Yamaguchi", "Yamamoto", "Yamashita", "Yamazaki", "Yokoyama", "Yoshida", "Yoshino", "Yuuki"]
	var roll1 = floor(rand_range(0,first_names.size()))
	var roll2 = floor(rand_range(0,last_names.size()))
	return(first_names[roll1] + " " + last_names[roll2])
