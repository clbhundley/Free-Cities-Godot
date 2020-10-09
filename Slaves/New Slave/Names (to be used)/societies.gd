extends Node

var cow_first_names = ["Anna", "Annabelle", "Annie", "Arabella", "Baby", "Bella", "Bertha", "Bessie", "Betty Sue", "Big Mac", "Blue", "BrownCow", "Candie", "Cinnamon", "Clarabelle", "Clover", "Cocoa", "Cookie", "Cowlick", "Cupcake", "Dahlia", "Daisy", "Darla", "Diamond", "Dorothy", "Ella", "Emma", "Esmeralda", "Flower", "Gertie", "Hamburger", "Heifer", "Henrietta", "Honeybun", "Jasmayne", "Jasmine", "Lee", "Lois", "Madonna", "Maggie", "Margie", "Marie", "Mary", "May", "Meg", "Minnie", "Molly", "Moo Moo", "Moscow", "Muffin", "Nettie", "Penelope", "Penny", "Pinky", "Precious", "Princess", "Rose", "Sasha", "Shelly", "Sugar", "Sunny", "Sunshine", "Sweetie", "Sweetpea", "Swiss Miss", "Waffles"]

var religious_first_names = ["Abundance", "Allegiance", "Ambition", "Amity", "Amnesty", "Ardour", "Beauty", "Belief", "Benevolence", "Blessing", "Bliss", "Charisma", "Charity", "Charm", "Chastity", "Cheer", "Clarity", "Clemency", "Comfort", "Compassion", "Concord", "Condolence", "Constance", "Constancy", "Courage", "Credence", "Desire", "Destiny", "Dignity", "Diligence", "Discretion", "Empathy", "Endurance", "Esteem", "Eternity", "Evanescence", "Faith", "Favour", "Felicity", "Fidelity", "Fortune", "Gaiety", "Generosity", "Glory", "Grace", "Gracious", "Gravitas", "Happiness", "Harmony", "Heaven", "Honesty", "Hope", "Hospitality", "Humility", "Innocent", "Integrity", "Joy", "Justice", "Kindness", "Laughter", "Love", "Loyalty", "Luck", "Mercy", "Merit", "Modesty", "Patience", "Peace", "Penance", "Perseverance", "Piety", "Pleasant", "Prosperity", "Prudence", "Purity", "Radiance", "Remembrance", "Respect", "Reverence", "Salvation", "Sanctity", "Serendipity", "Serenity", "Silence", "Sincerity", "Solace", "Solemnity", "Success", "Sympathy", "Temperance", "Thankfulness", "Tolerance", "Tranquility", "Trinity", "Truth", "Unity", "Verity", "Virtue", "Wisdom", "Wonder"]

var roman_first_names = ["Aconia", "Aelia", "Agricola", "Agrippa", "Agrippina", "Ahala", "Ahenobarba", "Alba", "Albina", "Ambusta", "Annalis", "Antistia", "Antonia", "Appia", "Aquila", "Aquilina", "Arria", "Arvina", "Asina", "Atella", "Atia", "Aula", "Aurela", "Avita", "Baebiana", "Balba", "Barba", "Barbata", "Bassa", "Bestia", "Bibacula", "Bibula", "Blaesa", "Broccha", "Bruta", "Bubulca", "Bulba", "Caeca", "Caecilia", "Caesonia", "Calida", "Calpurnia", "Calva", "Calvina", "Camilla", "Cana", "Canina", "Catilina", "Catula", "Celeris", "Celsa", "Cethega", "Cicurina", "Cincinnata", "Cinna", "Claudia", "Corda", "Cornelia", "Cornicen", "Cornuta", "Corva", "Corvina", "Cossa", "Costa", "Cotta", "Crassa", "Crassipes", "Crispa", "Crispina", "Crispina", "Curva", "Decima", "Dentata", "Dentra", "Diana", "Dives", "Dolabella", "Domitia", "Domitilla", "Drusa", "Drusilla", "Euphemia", "Eutropia", "Fabia", "Faustina", "Figula", "Fimbria", "Flacca", "Flava", "Flavia", "Flora", "Fusa", "Gaia", "Galeria", "Galla", "Gemella", "Gnaea", "Gnaea", "Graccha", "Gratidia", "Gurges", "Habita", "Helena", "Helva", "Helvia", "Herennia", "Honoria", "Hostia", "Imperiosa", "Iulla", "Julia", "Junia", "Justina", "Lactuca", "Laenas", "Laevina", "Lanata", "Laterensis", "Lentula", "Leontia", "Lepida", "Lepida", "Licina", "Licinia", "Livia", "Livilla", "Lollia", "Longa", "Lucia", "Lucilla", "Luculla", "Lupa", "Macra", "Macula", "Maecia", "Magia", "Malleola", "Mamerca", "Mania", "Manlia", "Marca", "Marcella", "Marcella", "Marcia", "Mellisa", "Merenda", "Merga", "Merula", "Messalina", "Messalla", "Metella", "Metella", "Minervina", "Munatia", "Murena", "Mus", "Musca", "Nasica", "Natta", "Nepos", "Nerva", "Nigra", "Novella", "Numeria", "Ocella", "Ocellina", "Octavia", "Orbiana", "Otacilia", "Paccia", "Pacila", "Paeta", "Pansa", "Papa", "Papianilla", "Patercula", "Paulina", "Paulla", "Pera", "Pictrix", "Placiaida", "Planca", "Plauta", "Plautia", "Plautilla", "Plotina", "Pompeia", "Popilla", "Poplicola", "Poppaea", "Porcia", "Postuma", "Potita", "Praeconina", "Praetextata", "Prisca", "Procula", "Publia", "Pulcheria", "Pulchra", "Pulla", "Pulvilla", "Quadrata", "Quinta", "Ralla", "Regilla", "Regula", "Risca", "Rufa", "Ruga", "Rulla", "Rutila", "Sabina", "Salinatrix", "Salonina", "Saturnina", "Scaeva", "Scaevola", "Scapula", "Scaura", "Scrofa", "Sempronia", "Seneca", "Servia", "Servilia", "Severa", "Severa", "Sexta", "Sila", "Silana", "Spuria", "Statilia", "Structa", "Sulla", "Sulpicia", "Sura", "Taura", "Terentia", "Theodora", "Tiberia", "Tita", "Titania", "Tranquillina", "Triaria", "Trigemina", "Tuberta", "Tubula", "Tuditana", "Tulla", "Tullia", "Turda", "Ulpia", "Urgulania", "Valeria", "Vara", "Vatia", "Verina", "Verres", "Vesta", "Vetus", "Vibia", "Vibia", "Violentilla", "Vipsania", "Vistilla", "Vitula", "Volusa"]
var roman_last_names = ["Acilia", "Aebutia", "Aelia", "Aemilia", "Anicia", "Annia", "Antistia", "Antonia", "Appuleia", "Aquillia", "Ateia", "Atilia", "Atinia", "Attia", "Aufidia", "Aurelia", "Baebia", "Caecilia", "Caedicia", "Caelia", "Calpurnia", "Caninia", "Canuleia", "Carvilia", "Cassia", "Claudia", "Clodia", "Cloelia", "Cluvia", "Coelia", "Considia", "Cornelia", "Cosconia", "Curia", "Curiatia", "Curtia", "Decia", "Decimia", "Didia", "Domitia", "Duillia", "Egnatia", "Fabia", "Fabricia", "Fannia", "Flaminia", "Flavia", "Fonteia", "Fulvia", "Fundania", "Furia", "Gabinia", "Gegania", "Genucia", "Herennia", "Horatia", "Hortensia", "Hostilia", "Icilia", "Julia", "Junia", "Juventia", "Laelia", "Laetoria", "Licinia", "Livia", "Lollia", "Lucilia", "Lucretia", "Lutatia", "Maenia", "Mallia", "Mamilia", "Manilia", "Manlia", "Marcia", "Maria", "Matiena", "Memmia", "Menenia", "Minucia", "Mucia", "Mummia", "Munatia", "Naevia", "Nautia", "Nonia", "Octavia", "Ogulnia", "Opimia", "Oppia", "Otacilia", "Papia", "Papiria", "Peducaea", "Perperna", "Petellia", "Pinaria", "Plaetoria", "Plautia", "Plotia", "Poetelia", "Pompeia", "Pomponia", "Popillia", "Porcia", "Postumia", "Publicia", "Publilia", "Pupia", "Quinctia", "Quinctilia", "Quintia", "Roscia", "Rubria", "Rutilia", "Scribonia", "Sempronia", "Sergia", "Servilia", "Sestia", "Sextia", "Sextilia", "Sicinia", "Silia", "Sulpicia", "Terentia", "Titia", "Titinia", "Trebonia", "Tremellia", "Tullia", "Valeria", "Verginia", "Veturia", "Vibia", "Villia", "Voconia", "Volcatia", "Volumnia"]

var edo_first_names = ["Adakichi", "Aihachi", "Aika", "Aikichi", "Aiko", "Aimatsu", "Akiko", "Ariko", "Asa", "Asakichi", "Asao", "Ayako", "Ayano", "Azuma", "Baicho", "Baisho", "Botan", "Charyoei", "Chieko", "Chikafuku", "Chikafumi", "Chikano", "Chikashizu", "Chikayoshi", "Chikayu", "Chikayuki", "Chisako", "Chiyo", "Chiyoe", "Chiyoha", "Chiyokichi", "Chiyoko", "Chiyoryo", "Chiyoteru", "Chiyotsuru", "Chiyowaka", "Chiyoyakko", "Chizu", "Chizuha", "Chizuru", "Cho", "Chocho", "Dango", "Danji", "Danko", "Dan’ei", "Edagiku", "Emi", "Emicho", "Emigiku", "Emiyo", "Enko", "Eriko", "Fuji", "Fujie", "Fujigiku", "Fujiha", "Fukichiyo", "Fukiha", "Fukimi", "Fukiyo", "Fukizo", "Fuku", "Fukuai", "Fukuaya", "Fukuchiyo", "Fukucho", "Fukudama", "Fukuha", "Fukuhana", "Fukuharu", "Fukuhina", "Fukuhiro", "Fukumi", "Fukumusume", "Fukunae", "Fukusato", "Fukusuke", "Fukusuzu", "Fukuteru", "Fukuya", "Fukuyo", "Fukuyoshi", "Fukuyu", "Fumi", "Fumichiyo", "Fumicho", "Fumihana", "Fumiko", "Fumino", "Fumukazu", "Fusakichi", "Fusako", "Fusao", "Hamako", "Hamayu", "Hanachiyo", "Hanaji", "Hanakichi", "Hanako", "Hanamatsu", "Hanaryo", "Hanayakko", "Harukichi", "Haruko", "Hatsu", "Hatsuko", "Hatsuyo", "Hidechiyo", "Hidecho", "Hideji", "Hidemi", "Hideryu", "Hideyakko", "Hidezuru", "Hinacho", "Hinagiku", "Hinako", "Hinazuru", "Hisa", "Hisacho", "Hisae", "Hisaei", "Hisamomo", "Hisasuzu", "Hisayo", "Hisazuru", "Ichiei", "Ichiemi", "Ichiharu", "Ichiho", "Ichika", "Ichimame", "Ichimomo", "Ichiraku", "Ichiryu", "Ichisayo", "Ichiteru", "Ichitomi", "Ichiume", "Ichiya", "Ichiyakko", "Iku", "Ikumatsu", "Imayoshi", "Ine", "Iroha", "Ishino", "Ishiyakko", "Iso", "Isoei", "Itozuru", "Kameji", "Kameko", "Kaneha", "Kanemi", "Kanoaki", "Kanoemi", "Kanoka", "Kasen", "Katsuchiyo", "Katsue", "Katsuha", "Katsuji", "Katsuna", "Katsune", "Katsuru", "Kayo", "Kichihana", "Kichiyakko", "Kichiyo", "Kichiyu", "Kiku", "Kikuka", "Kikumaru", "Kikumatsu", "Kikuno", "Kikuryo", "Kikutsuru", "Kikuya", "Kikuyakko", "Kikuyu", "Kimiei", "Kimikiku", "Kimina", "Kimitomo", "Kimiyakko", "Kin'ei", "Kin'ichi", "Kinhei", "Kinko", "Kinmatsu", "Kinroku", "Kinryo", "Kinryu", "Kinshi", "Kinsuke", "Kinu", "Kinyo", "Kitanomatsu", "Kiyo", "Koen", "Kofuku", "Kofusa", "Kogiku", "Koi", "Koiku", "Kojako", "Komagiku", "Komaji", "Komako", "Komame", "Komari", "Komaru", "Komasu", "Komomo", "Komume", "Koriki", "Korin", "Koroku", "Kosaki", "Kosaku", "Kosen", "Koshizu", "Kosome", "Kosue", "Kotaka", "Kotama", "Kotatsu", "Koteru", "Kotetsu", "Koto", "Kotobuki", "Kotoei", "Kotogiku", "Kotoha", "Kotoji", "Kotomi", "Kotono", "Kotoyo", "Kotsuma", "Koume", "Koyachiyo", "Koyakko", "Koyana", "Koyei", "Koyo", "Koyone", "Koyoshi", "Koyuka", "Koyuki", "Koyumi", "Kozakura", "Kozuru", "Kuma", "Kumakichi", "Kumano", "Kumayoshi", "Kunigiku", "Kyoka", "Kyoko", "Machi", "Mamefusa", "Mamegiku", "Mamehana", "Mameharu", "Mamehide", "Mamehiro", "Mameka", "Mamekichi", "Mameko", "Mameraku", "Mameriki", "Mameroku", "Mameryo", "Mameyakko", "Mameyo", "Mameyoshi", "Mameyu", "Maru", "Masuwaka", "Matsuko", "Matsuriki", "Matsuyakko", "Miharu", "Mineko", "Mitsu", "Mitsugiku", "Mitsuha", "Mitsuko", "Mitsuyo", "Miyagiku", "Miyo", "Miyoha", "Miyoharu", "Miyoka", "Miyozuru", "Momifuku", "Momiji", "Momochiyo", "Momoko", "Momomaru", "Momoyakko", "Momozuru", "Naka", "Naochiyo", "Naosome", "Naosono", "Narako", "Narayone", "Oimatsu", "Omine", "Omocha", "Onao", "Otomaru", "Otoyu", "Ran", "Ren", "Riki", "Rikigo", "Rikiha", "Rikiharu", "Rikihei", "Rikiji", "Rikiko", "Rikiya", "Royo", "Ryuko", "Sakae", "Sakiko", "Sakyo", "Sana", "Sanae", "Sankatsu", "Sanko", "Sanya", "Sasa", "Sato", "Satochiyo", "Satogiku", "Satoji", "Satoka", "Satokichi", "Satomi", "Satono", "Satotsuya", "Satoyu", "Satoyuki", "Satsuki", "Sayaka", "Sayoko", "Sekka", "Sen", "Shimekichi", "Shimematsu", "Shinneji", "Shizu", "Shizue", "Shizuko", "Shun", "Sodeko", "Somagiku", "Soyo", "Sue", "Sumiko", "Suzu", "Suzuhachi", "Suzuka", "Suzuko", "Takeko", "Takewaka", "Takeyakko", "Tama", "Tamagiku", "Tamakiku", "Tamako", "Tamaryo", "Tamasuke", "Tamaye", "Tamayu", "Tamazuru", "Tamiko", "Tane", "Taneji", "Taneju", "Taneko", "Tatsu", "Tatsuko", "Teruhina", "Teruji", "Teruko", "Teruyo", "Tetsu", "Toba", "Toki", "Tokiko", "Tokimatsu", "Toku", "Tome", "Tomeko", "Tomewaka", "Tomigiku", "Tomiko", "Tomimatsu", "Tomino", "Tomiryo", "Tomitae", "Tomitsuru", "Tomiwaka", "Tomiyakko", "Tomizuru", "Tomogiku", "Tomoko", "Tomoryo", "Tomowaka", "Tomoyuki", "Tonko", "Tora", "Toshifumi", "Toshihana", "Toshiko", "Toye", "Toyochiyo", "Toyofu", "Toyohina", "Toyoji", "Toyoka", "Tsunechiyo", "Tsuneko", "Tsunemomo", "Tsuneyo", "Tsuneyu", "Tsuru", "Tsurue", "Tsuruha", "Tsuruji", "Tsuruka", "Tsurumatsu", "Tsuruyo", "Tsuruyu", "Tsuta", "Tsutaji", "Tsuyachiyo", "Tsuyu", "Ume", "Umechie", "Umechiho", "Umechika", "Umechiyo", "Umegiku", "Umeha", "Umehisa", "Umeji", "Umeko", "Umematsu", "Umeo", "Umeraku", "Umeryo", "Umeryu", "Umesaya", "Umesuke", "Umesuzu", "Umewaka", "Umeyae", "Umeyakko", "Umeyu", "Uno", "Unofuku", "Unoha", "Unohide", "Unoji", "Unoka", "Unokayo", "Unokazu", "Unokiyo", "Unoko", "Unoshizu", "Unowaka", "Uta", "Utachiyo", "Utaji", "Utaka", "Utamatsu", "Utayu", "Wakaba", "Wakacho", "Wakagusa", "Wakai", "Wakaji", "Wakakimi", "Wakako", "Wakakoma", "Wakamurasaki", "Wakaroku", "Wakatsune", "Wakaume", "Wakayakko", "Wakayo", "Wakayone", "Wakazuru", "Wako", "Yachiyoko", "Yae", "Yaemi", "Yaewaka", "Yaezuru", "Yaichi", "Yasohachi", "Yasu", "Yasuku", "Yoi", "Yone", "Yonehachi", "Yoneyakko", "Yuiko", "Yukako", "Yukari", "Yukiryo", "Yukizono"]
var edo_last_names = ["Akamatsu", "Akechi", "Amago", "Asakura", "Ashikaga", "Ashina", "Azai", "Chosokabe", "Chugoku", "Date", "Gamo", "Hattori", "Hojo", "Ichijo", "Ikeda", "Imagawa", "Itami", "Ito", "Kiso", "Kodera", "Matsudaira", "Miyoshi", "Mogami", "Mori", "Murukami", "Nagao", "Oda", "Ogasawara", "Otomo", "Ouchi", "Rokkaku", "Ryuzoji", "Saika", "Saito", "Sanada", "Satake", "Shimazu", "Soma", "Suwa", "Tachibana", "Takeda", "Tokugawa", "Toyotomi", "Tsutsui", "Uesugi", "Uragami", "Wada"]

var chinese_revivalist_last_names = ["Bu", "Cao", "Chen", "Cheng", "Deng", "Ding", "Dong", "Du", "Fei", "Feng", "Fu", "Gao", "Gongsun", "Guan", "Guangqiu", "Guo", "Han", "Hao", "He", "Hu", "Huang", "Huo", "Jia", "Jiang", "Li", "Liang", "Liao", "Ling", "Liu", "Lu", "Luo", "Ma", "Man", "Meng", "Mi", "Pan", "Pang", "Qian", "Qin", "Qiu", "Quan", "Shi", "Shu", "Sima", "Song", "Sun", "Tang", "Tao", "Teng", "Tian", "Wang", "Wei", "Wen", "Wu", "Xiahou", "Xie", "Xu", "Xue", "Yang", "Yin", "Yong", "Yu", "Yue", "Zang", "Zhang", "Zhao", "Zhou", "Zhu", "Zhuge", "Zong"]

var aztec_first_names = ["Achcauhtli", "Ahuiliztli", "Amoxtli", "Atl", "Centehua", "Chicahua", "Chipahua", "Cihuaton", "Citlali", "Citlalmina", "Coaxoch", "Coszcatl", "Cozamalotl", "Cualli", "Cuicatl", "Eheloc", "Eleuia", "Eloxochitl", "Etalpalli", "Eztli", "Ichtaca", "Icnoyotl", "Ihuicatl", "Ilhuitl", "Itotia", "Itzel", "Iuitl", "Ixcatzin", "Ixchel", "Ixtli", "Izel", "Mahuizoh", "Malina", "Manauia", "Mazatl", "Mecatl", "Meztli", "Miyaoaxochitl", "Mizquixaual", "Momozlan", "Momoztli", "Moyolehuani", "Nahuatl", "Necahual", "Nelli", "Nenetl", "Nochtli", "Noxochicoztli", "Ohtli", "Papa", "Papan", "Patli", "Quetzalxochitl", "Sacnite", "Teicuih", "Teiuc", "Teoxihuitl", "Tepin", "Teuicui", "Teyacapan", "Tlachinolli", "Tlaco", "Tlacoehua", "Tlacotl", "Tlalli", "Tlanextli", "Tlataca", "Tlazohtzin", "Tlexictli", "Toltecatl", "Tonalnan", "Topiltia", "Xihuitl", "Xilonen", "Xiloxoch", "Xipil", "Xiuhcoatl", "Xiuhtonal", "Xochicotzin", "Xochiquetzal", "Xochitl", "Xochiyotl", "Xocoh", "Xocoyotl", "Yaotl", "Yaretzi", "Yayauhqui", "Yolihuani", "Yolotli", "Yoltzin", "Zaniyah", "Zeltzin", "Zolel", "Zuma", "Zyanya"]

var ancient_egyptian_first_names = ["A'at", "Ahhotep", "Ahmose", "Ahmose-Nefertari", "Ahset", "Amtes", "Amunet", "Ana", "Aneksi", "Ankhes-Pepi", "Ankhesenamon", "Ankhesenpaaten", "Ankhesenpaaten-ta-sherit", "Ankhetitat", "Ankhnes-Pepi", "Ankhnesmery-Re", "Aoh", "Ashait", "Ast", "Atet", "Baketamon", "Bakt", "Baktwerel", "Beketaten", "Berenib", "Betresh", "Betrest", "Bint-Anath", "Bunefer", "Dedyet", "Fent-Ankhet", "Gilukhipa", "Hapynma'at", "Hedjhekenu", "Henhenet", "Henite", "Hent", "Hent-Temehu", "Hent-Tenemu", "Hentaneb", "Hentempet", "Hentmereb", "Hentmire", "Henutmire", "Henutsen", "Henuttawy", "Henuttimehu", "Hep", "Herit", "Herneith", "Hetepheres", "Hetephernebty", "Heterphenebty", "Hornefrure'", "Huy", "Imi", "Inhapi", "Intakaes", "Iput", "Ipwet", "Ipy", "Isetnofret", "Isis", "Istnofret", "Itekuyet", "Itet", "Kasmut", "Kawit", "Kemanub", "Kemanut", "Kemsit", "Kentetenka", "Khama'at", "Khamerernebty", "Khemut", "Khentikus", "Khentkawes", "Khenut", "Khuit", "Khumit", "Kiya", "Ma'at", "Maatkare-Nefertari", "Maia", "Meket-Aten", "Menhet", "Menwi", "Mereneith", "Mereryet", "Meresankh", "Merit-Amon", "Meritaten", "Meritites", "Merneith", "Merseger", "Merti", "Meryetamun", "Meryetre", "Merysankh", "Meryt-Amon", "Meryt-Re-Hatshepsut", "Merytamon", "Merytaten-tasherit", "Mutemwiya", "Mutnodjme", "Mutnofret", "Muyet", "Nebet", "Nebettawy", "Nebt", "Nebt-tawya", "Neferhent", "Neferhetep", "Neferhetepes", "Neferkent", "Neferneferure", "Nefertari", "Nefertiry", "Nefertiti", "Nefertkau,", "Nefertkaw", "Neferu", "Neferu-Re", "Neferukhayt", "Neferukhebt", "Nefret", "Nefru", "Nefru-Ptah", "Nefru-Sobek", "Nefru-totenen", "Nefrusheri", "Neith", "Neithotep", "Nemathap", "Nenseddjedet", "Neshkons", "Nestanebtishru", "Nit", "Nitemat", "Nithotep", "Nodjmet", "Nofret", "Nubkhas", "Nubkhesed", "Rai", "Raia", "Redji", "Reputneb", "Sadeh", "Sadek", "Sebek-shedty-Neferu", "Senebsen", "Senisonbe", "Sennuwy", "Seshseshet", "Sit-Hathor-Yunet", "Sitamun", "Sitkamose", "Sitre", "Sobekemsaf", "Sotepenre", "Ta-Opet", "Tadukhipa", "Takhaet", "Tarset", "Taweret", "Tem", "Tener", "Teo", "Tetisheri", "Tey", "Thent", "Tia", "Tiy", "Tiye", "Tjepu", "Tuia", "Tumerisy", "Tuya", "Tuyu", "Twosre", "Weret-Imtes"]