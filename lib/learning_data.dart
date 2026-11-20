// --- Model Data Komik ---
class ComicSlideData {
  final String imagePath;
  final String title;

  const ComicSlideData({
    required this.imagePath,
    required this.title,
  });
}

// --- Model Data Kuis ---
class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  const QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}

// Database Aset Komik Per Skema Warna
final Map<String, List<ComicSlideData>> schemeComicContent = {
  'Analogous': [
    for (int i = 21; i <= 43; i++)
      ComicSlideData(
        imagePath: 'assets/analogous/Frame $i.png',
        title: 'Analogous - Frame $i',
      ),
  ],
  'Monochrome': [
    for (int i = 44; i <= 68; i++)
      ComicSlideData(
        imagePath: 'assets/monochrome/Frame $i.png',
        title: 'Monochrome - Frame $i',
      ),
  ],
  'Complement': [
    for (int i = 69; i <= 94; i++)
      ComicSlideData(
        imagePath: 'assets/complement/Frame $i.png',
        title: 'Complement - Frame $i',
      ),
  ],
  'Triangle': [
    for (int i = 95; i <= 108; i++)
      ComicSlideData(
        imagePath: 'assets/triangle/Frame $i.png',
        title: 'Triangle - Frame $i',
      ),
  ],
  'Square': [
    for (int i = 109; i <= 117; i++)
      ComicSlideData(
        imagePath: 'assets/square/Frame $i.png',
        title: 'Square - Frame $i',
      ),
  ],
  'Split Complement': [
    for (int i = 1; i <= 14; i++)
      ComicSlideData(
        imagePath: 'assets/splitcomplement/$i.png',
        title: 'Split Complement - Frame $i',
      ),
  ],
};

// Database Soal Kuis Per Skema Warna
final Map<String, List<QuizQuestion>> schemeQuizContent = {
  'Analogous': [
    const QuizQuestion(
      question:
          'Berapa jumlah warna yang umum digunakan dalam skema warna Analogus?',
      options: [
        '3 hingga 5 warna bersebelahan',
        'Hanya 1 warna tunggal',
        '2 warna berhadapan langsung',
        'Semua 12 warna pada roda',
      ],
      correctIndex: 0,
      explanation:
          'Analogous umumnya memakai 3 sampai 5 warna yang posisinya saling berdampingan.',
    ),
    const QuizQuestion(
      question:
          'Warna induk utama dalam skema Analogus sering disebut dengan istilah?',
      options: [
        'Mother color',
        'Split hue',
        'Inverted color',
        'Pure neutral',
      ],
      correctIndex: 0,
      explanation:
          'Mother color adalah satu warna dominan yang diapit oleh warna aksen pendukungnya.',
    ),
    const QuizQuestion(
      question:
          'Berapa persentase ideal bagi warna utama dalam bidang desain Analogus?',
      options: [
        'Sekitar 60-70%',
        'Tepat 25%',
        'Harus seimbang 50-50%',
        'Kurang dari 10%',
      ],
      correctIndex: 0,
      explanation:
          'Disarankan mendominasi 60-70% bidang agar tercipta hierarki visual yang jelas.',
    ),
  ],
  'Monochrome': [
    const QuizQuestion(
      question:
          'Skema Monokromatik disusun dari berapa jenis rona warna (hue) dasar?',
      options: [
        'Satu rona dasar tunggal (single hue)',
        'Dua rona berseberangan',
        'Tiga rona sudut 120°',
        'Empat rona berjarak 90°',
      ],
      correctIndex: 0,
      explanation:
          'Monokromatik hanya memakai 1 warna dasar yang divariasikan nilai kecerahannya.',
    ),
    const QuizQuestion(
      question:
          'Variasi warna monokrom dieksplorasi melalui komponen apa saja?',
      options: [
        'Shade, tint, dan tone',
        'Pemisahan sudut komplementer',
        'Penambahan warna primer acak',
        'Rotasi warna 180 derajat',
      ],
      correctIndex: 0,
      explanation:
          'Monokrom dieksplorasi lewat shade (kegelapan), tint (kecerahan), dan tone (saturasi).',
    ),
    const QuizQuestion(
      question:
          'Kunci utama agar teks pada desain monokrom tetap mudah dibaca adalah?',
      options: [
        'Kontras nilai (value contrast) yang tegas',
        'Menggunakan ukuran teks sangat kecil',
        'Menghilangkan batas kontainer',
        'Menyamakan shade teks dengan latar',
      ],
      correctIndex: 0,
      explanation:
          'Value contrast yang tegas antara teks dan background menjamin keterbacaan yang tajam.',
    ),
  ],
  'Complement': [
    const QuizQuestion(
      question:
          'Berapa derajat jarak posisi antarwarna pada skema Komplementer?',
      options: [
        '180 derajat (berhadapan langsung)',
        '90 derajat (siku-siku)',
        '120 derajat (segitiga)',
        '30 derajat (berdampingan)',
      ],
      correctIndex: 0,
      explanation:
          'Warna komplementer berada tepat di posisi diagonal seberang roda warna (180°).',
    ),
    const QuizQuestion(
      question:
          'Apa risiko jika menggunakan warna komplementer dengan rasio 50:50?',
      options: [
        'Menyilaukan dan membuat mata lelah',
        'Desain tampak pudar dan kusam',
        'Elemen penting menjadi tidak terlihat',
        'Warna saling meniadakan secara otomatis',
      ],
      correctIndex: 0,
      explanation:
          'Rasio seimbang 50:50 menghasilkan ketegangan visual yang menyilaukan mata.',
    ),
    const QuizQuestion(
      question:
          'Komponen UI manakah yang paling ideal diberi warna aksen komplementer?',
      options: [
        'Tombol Call To Action (CTA) & notifikasi',
        'Seluruh latar belakang aplikasi',
        'Teks paragraf panjang',
        'Garis batas tipis pasif',
      ],
      correctIndex: 0,
      explanation:
          'Kontras maksimum komplementer sangat efektif menarik atensi klik pada tombol CTA.',
    ),
  ],
  'Triangle': [
    const QuizQuestion(
      question:
          'Berapa jarak sudut antarwarna yang membentuk skema Triad / Triangle?',
      options: [
        '120 derajat (segitiga sama sisi)',
        '90 derajat (bujur sangkar)',
        '180 derajat (garis lurus)',
        '60 derajat (berdekatan)',
      ],
      correctIndex: 0,
      explanation:
          'Skema triad membentuk segitiga sama sisi dengan jarak antarwarna seimbang 120°.',
    ),
    const QuizQuestion(
      question: 'Apa keunggulan utama dari karakteristik visual skema Triad?',
      options: [
        'Tetap hidup dan seimbang meski bersaturasi lembut',
        'Hanya bisa diterapkan dalam mode gelap',
        'Membuat tampilan menjadi redup dan monoton',
        'Tidak memiliki warna fokus sama sekali',
      ],
      correctIndex: 0,
      explanation:
          'Skema triad menawarkan dinamika warna ceria yang tetap stabil dan seimbang.',
    ),
    const QuizQuestion(
      question: 'Bagaimana tips penerapan skema Triad pada antarmuka aplikasi?',
      options: [
        'Turunkan saturasi pada dua warna pendukung',
        'Gunakan ketiga warna dengan luas bidang yang sama',
        'Pilih tiga warna dengan saturasi tertinggi',
        'Hilangkan warna dominan utama',
      ],
      correctIndex: 0,
      explanation:
          'Menurunkan saturasi dua warna pendukung membantu menjaga antarmuka tetap harmonis.',
    ),
  ],
  'Square': [
    const QuizQuestion(
      question:
          'Berapa banyak warna dan sudut jarak yang digunakan dalam skema Square?',
      options: [
        '4 warna dengan jarak 90 derajat',
        '3 warna dengan jarak 120 derajat',
        '2 warna dengan jarak 180 derajat',
        '5 warna dengan jarak 72 derajat',
      ],
      correctIndex: 0,
      explanation:
          'Square melibatkan 4 warna simetris yang berjarak sama 90° pada roda warna.',
    ),
    const QuizQuestion(
      question: 'Hubungan geometris apa yang terkandung di dalam skema Square?',
      options: [
        'Dua pasang warna komplementer yang berpotongan',
        'Satu garis lurus horizontal tunggal',
        'Tiga warna berdampingan erat',
        'Dua warna berjarak 45 derajat',
      ],
      correctIndex: 0,
      explanation:
          'Square tersusun dari 2 pasang warna komplementer yang saling berpotongan simetris.',
    ),
    const QuizQuestion(
      question:
          'Kapan skema Square sangat efektif untuk digunakan dalam UI desain?',
      options: [
        'Dashboard analitik atau diagram pembeda kategori',
        'Tampilan splash screen hitam-putih',
        'Desain kartu nama satu warna',
        'Teks artikel panjang tanpa grafis',
      ],
      correctIndex: 0,
      explanation:
          'Keberagaman warnanya sangat membantu membedakan banyak kategori data analitik.',
    ),
  ],
  'Split Complement': [
    const QuizQuestion(
      question:
          'Bagaimana cara menentukan kombinasi warna dalam skema Split Complement?',
      options: [
        '1 warna acuan + 2 warna di samping komplementernya',
        '3 warna berdampingan lurus tanpa jeda',
        '4 warna membentuk tanda tambah (+)',
        '2 warna yang berada di sudut 90 derajat',
      ],
      correctIndex: 0,
      explanation:
          'Split complement memakai 1 warna utama plus 2 warna yang mengapit komplementernya.',
    ),
    const QuizQuestion(
      question:
          'Apa kelebihan utama Split Complement dibandingkan Komplementer murni?',
      options: [
        'Ketegangan kontras visual lebih ramah di mata',
        'Lebih menyilaukan dan tajam bagi mata',
        'Menghilangkan semua warna aksen',
        'Hanya boleh dipakai oleh desainer profesional',
      ],
      correctIndex: 0,
      explanation:
          'Menghadirkan kontras menarik dengan ketegangan visual yang lebih lembut bagi pengguna.',
    ),
    const QuizQuestion(
      question:
          'Berapa jumlah total warna yang dipakai dalam skema Split Complement?',
      options: [
        'Total 3 warna',
        'Total 2 warna',
        'Total 4 warna',
        'Total 5 warna',
      ],
      correctIndex: 0,
      explanation:
          'Menggunakan tepat 3 warna (1 warna acuan dan 2 warna di kiri-kanan seberangnya).',
    ),
  ],
};
