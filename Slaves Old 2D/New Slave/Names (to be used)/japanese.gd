extends Node

var first_names = ["Ai", "Aika", "Aiko", "Aimi", "Aina", "Airi", "Akane", "Akari", "Akemi", "Aki", "Akiko", "Akira", "Ami", "Anna", "Aoi", "Asuka", "Atsuko", "Aya", "Ayaka", "Ayako", "Ayame", "Ayane", "Ayano", "Ayumi", "Chidori", "Chie", "Chihiro", "Chika", "Chikako", "Chinatsu", "Chiyo", "Chiyoko", "Cho", "Chou", "Chouko", "Emi", "Erika", "Etsuko", "Futaba", "Fuuka", "Hana", "Hanae", "Hanako", "Haru", "Haruka", "Haruko", "Haruna", "Hibiki", "Hikari", "Hikaru", "Hina", "Hinata", "Hiroko", "Hitomi", "Honoka", "Hoshi", "Hoshiko", "Hotaru", "Izumi", "Junko", "Kaede", "Kana", "Kanako", "Kanon", "Kaori", "Kaoru", "Kasumi", "Kazue", "Kazuko", "Keiko", "Kiku", "Kimiko", "Kiyoko", "Kohaku", "Koharu", "Kokoro", "Kotone", "Kumiko", "Kyo", "Kyou", "Mai", "Maki", "Makoto", "Mami", "Manami", "Mao", "Mari", "Mariko", "Marina", "Masami", "Masuyo", "Mayu", "Megumi", "Mei", "Michi", "Michiko", "Midori", "Miho", "Mika", "Miki", "Miku", "Minako", "Minami", "Minato", "Minoru", "Mio", "Misaki", "Mitsuko", "Mitsuru", "Miu", "Miyako", "Miyu", "Mizuki", "Moe", "Momoka", "Momoko", "Moriko", "Nana", "Nanako", "Nanami", "Nao", "Naoko", "Naomi", "Naoto", "Natsuki", "Natsuko", "Natsumi", "Noa", "Noriko", "Ran", "Rei", "Ren", "Riko", "Rin", "Rina", "Rio", "Risa", "Sachiko", "Sadayo", "Sae", "Saeko", "Saki", "Sakura", "Sakurako", "Satomi", "Saya", "Sayaka", "Sayuri", "Setsuko", "Shiho", "Shinju", "Shinobu", "Shiori", "Shizuka", "Shun", "Sora", "Sumiko", "Suzu", "Suzume", "Takako", "Takara", "Tamiko", "Tomiko", "Tomoko", "Tomomi", "Tsubaki", "Tsubame", "Tsubasa", "Tsukiko", "Ulala", "Ume", "Umeko", "Wakana", "Yasu", "Yoko", "Yoshi", "Yoshiko", "Youko", "Yua", "Yui", "Yuina", "Yuka", "Yukari", "Yuki", "Yukiko", "Yukino", "Yuko", "Yumi", "Yumiko", "Yuri", "Yuu", "Yuuka", "Yuuki", "Yuuko", "Yuuna", "Yuzuki"]
var last_names = ["Abe", "Adachi", "Akechi", "Amada", "Amagi", "Amano", "Ando", "Aoki", "Aragaki", "Arai", "Arisato", "Ayase", "Dojima", "Ebihara", "Endo", "Fujii", "Fujita", "Fujiwara", "Fukuda", "Fukuda", "Goto", "Hara", "Harada", "Hasegawa", "Hashimoto", "Hayashi", "Honda", "Hoshi", "Ikeda", "Imai", "Inaba", "Inoue", "Iori", "Ishida", "Ishii", "Ishikawa", "Ito", "Kan", "Kaneko", "Kashiwagi", "Kato", "Kawakami", "Kawamura", "Kido", "Kikichu", "Kimura", "Kirijo", "Kirishima", "Kitagawa", "Kobayashi", "Koizumi", "Kondo", "Kos", "Kujikawa", "Kurusu", "Li", "Maeda", "Masuda", "Matsuda", "Matsumoto", "Matsunaga", "Mayuzumi", "Mishima", "Mishina", "Miura", "Miyamoto", "Miyazaki", "Mori", "Morita", "Mtsui", "Murakami", "Murata", "Nakagawa", "Nakajima", "Nakamura", "Nakano", "Nakayama", "Nanjo", "Narukami", "Niijima", "Nishimura", "Noda", "Ogawa", "Okada", "Okamoto", "Ono", "Ota", "Ozawa", "Saito", "Sakai", "Sakamoto", "Sakura", "Sakurai", "Sanada", "Sasaki", "Sato", "Satonaka", "Serizawa", "Shibata", "Shimada", "Shimizu", "Shirogane", "Sonomura", "Sudou", "Suou", "Suzuki", "Takagi", "Takahashi", "Takami", "Takeba", "Takeda", "Takeuchi", "Tamura", "Tanaka", "Tatsumi", "Toudou", "Uchida", "Ueda", "Ueno", "Ueseugi", "Wada", "Wang", "Watanabe", "Yamada", "Yamagishi", "Yamaguchi", "Yamamoto", "Yamashita", "Yamazaki", "Yokoyama", "Yoshida", "Yoshino", "Yuuki"]