import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'learnpage.dart';

// --- Model Data ---
class LearningSlideData {
  final String title;
  final String description1;
  final String description2;

  const LearningSlideData({
    required this.title,
    required this.description1,
    required this.description2,
  });
}

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

// Database Materi (Bahasa Indonesia)
final Map<String, List<LearningSlideData>> schemeLearningContent = {
  'Analogous': [
    const LearningSlideData(
      title: 'Apa itu Analogus?',
      description1:
          'Skema warna analogous merupakan kombinasi beberapa warna yang posisinya saling berdampingan pada color wheel. Rangkaian warna ini biasanya terdiri atas tiga hingga lima warna yang bersebelahan.',
      description2:
          'Kombinasi ini menghasilkan gradasi visual yang sangat serasi, lembut, dan nyaman di mata pengguna tanpa memberikan kontras yang mencolok.',
    ),
    const LearningSlideData(
      title: 'Karakteristik Analogus',
      description1:
          'Ciri utamanya adalah keberadaan satu warna induk (mother color) dominan yang diapit oleh warna sekunder atau aksen di sisi kanan-kirinya.',
      description2:
          'Rancangan desain dengan skema ini menciptakan keterpaduan atmosfer yang solid, sering ditemukan pada tema alam, laut, dan matahari terbenam.',
    ),
    const LearningSlideData(
      title: 'Tips Penerapan',
      description1:
          'Pilihlah satu warna utama untuk mendominasi sekitar 60-70% bidang desain, lalu gunakan warna sebelahnya sebagai aksen pendukung.',
      description2:
          'Hindari menggunakan kombinasi warna analogus hangat dan dingin secara seimbang agar fokus utama visual tidak saling berebut.',
    ),
  ],
  'Monochrome': [
    const LearningSlideData(
      title: 'Apa itu Monokrom?',
      description1:
          'Skema warna monokromatik disusun dari satu jenis warna dasar tunggal (single hue), kemudian diperluas lewat variasi shade (kegelapan), tint (kecerahan), serta tone (saturasi).',
      description2:
          'Hasil rancangan terlihat sangat bersih, terorganisir, dan elegan, cocok untuk antarmuka yang mengedepankan keterbacaan data.',
    ),
    const LearningSlideData(
      title: 'Kelebihan Monokrom',
      description1:
          'Meminimalkan distorsi kognitif pembaca karena tidak adanya benturan antarragam pigmen warna yang mencolok.',
      description2:
          'Sangat mempermudah arsitektur visual dan hierarki informasi pada aplikasi finansial, e-reader, maupun formulir sistem.',
    ),
    const LearningSlideData(
      title: 'Tips Penerapan',
      description1:
          'Pastikan ada jarak nilai kegelapan (value contrast) yang tegas antara warna teks dan warna latar belakang.',
      description2:
          'Gunakan shade pekat untuk judul utama dan tint lembut untuk kartu kontainer atau batas latar belakang.',
    ),
  ],
  'Complement': [
    const LearningSlideData(
      title: 'Apa itu Komplementer?',
      description1:
          'Skema komplementer menggunakan dua warna yang berada di posisi saling berhadapan secara diagonal (180 derajat) pada color wheel.',
      description2:
          'Perpaduan ini menciptakan kontras visual tertinggi yang secara alami langsung memikat fokus pandangan pengguna.',
    ),
    const LearningSlideData(
      title: 'Keseimbangan Kontras',
      description1:
          'Jika dipakai dalam proporsi seimbang 50:50, tampilan akan terasa menyilaukan dan membuat mata cepat lelah.',
      description2:
          'Terapkan rasio dominasi, di mana satu warna menjadi latar belakang dan warna seberangnya khusus sebagai pemikat atensi utama.',
    ),
    const LearningSlideData(
      title: 'Tips Penerapan',
      description1:
          'Sangat ideal diterapkan pada tombol aksi krusial seperti Checkout, Call to Action, maupun lencana status notifikasi.',
      description2:
          'Gunakan nilai saturasi yang tidak terlalu menyengat jika diaplikasikan pada teks berukuran kecil.',
    ),
  ],
  'Triangle': [
    const LearningSlideData(
      title: 'Apa itu Triad / Triangle?',
      description1:
          'Skema triad menggunakan tiga warna yang terdistribusi merata di lingkaran warna sehingga membentuk segitiga sama sisi (jarak 120 derajat).',
      description2:
          'Menghasilkan kontras yang kaya dan tetap seimbang, membuat tampilan tampak hidup bahkan saat menggunakan saturasi lembut.',
    ),
    const LearningSlideData(
      title: 'Harmonisasi Tiga Titik',
      description1:
          'Kekuatan skema triad terletak pada keragaman warnanya yang tetap stabil tanpa menimbulkan ketimpangan visual.',
      description2:
          'Banyak digunakan pada aplikasi edukasi, produk anak-anak, infografis warna-warni, serta visual ilustrasi.',
    ),
    const LearningSlideData(
      title: 'Tips Penerapan',
      description1:
          'Tentukan satu warna sebagai penentu atmosfer umum, warna kedua sebagai struktur, dan warna ketiga untuk penegas interaksi.',
      description2:
          'Turunkan saturasi pada dua warna pendukung agar komposisi antarmuka tetap tenang.',
    ),
  ],
  'Square': [
    const LearningSlideData(
      title: 'Apa itu Square?',
      description1:
          'Skema bujur sangkar (square) melibatkan empat warna yang berjarak sama satu sama lain di sekeliling roda warna (jarak 90 derajat).',
      description2:
          'Skema ini menawarkan dinamika warna maksimal dengan dua pasang warna komplementer yang saling berpotongan simetris.',
    ),
    const LearningSlideData(
      title: 'Menata Variasi Warna',
      description1:
          'Karena memiliki empat warna kontras sekaligus, diperlukan kontrol hierarki yang disiplin agar tidak terkesan berantakan.',
      description2:
          'Perhatikan keseimbangan antara warna-warna bersuhu hangat dan dingin dalam antarmuka aplikasi.',
    ),
    const LearningSlideData(
      title: 'Tips Penerapan',
      description1:
          'Gunakan skema ini untuk dashboard analitik atau diagram kategori yang menuntut pembedaan kategori jelas.',
      description2:
          'Jangan gunakan keempat warna dalam proporsi luas permukaan yang setara.',
    ),
  ],
  'Split Complement': [
    const LearningSlideData(
      title: 'Apa itu Split Complement?',
      description1:
          'Variasi cerdas dari skema komplementer, di mana warna komplementer seberang digantikan oleh dua warna yang mengapitnya di kiri dan kanan.',
      description2:
          'Memberikan ketajaman kontras yang memikat namun dengan tingkat ketegangan visual yang jauh lebih bersahabat bagi mata.',
    ),
    const LearningSlideData(
      title: 'Keunggulan Skema',
      description1:
          'Lebih fleksibel dan tidak mudah berantakan dibandingkan skema komplementer biasa bagi desainer pemula.',
      description2:
          'Menyajikan dinamika visual cerah tanpa membuat pengguna merasa lelah saat menatap layar dalam durasi lama.',
    ),
    const LearningSlideData(
      title: 'Tips Penerapan',
      description1:
          'Gunakan warna dasar utama untuk latar atau kartu utama, lalu manfaatkan kedua warna split untuk tombol dan ikon.',
      description2:
          'Pastikan salah satu warna split memiliki tingkat kecerahan yang cukup berbeda dengan warna dasar.',
    ),
  ],
};

// Database Soal Kuis (Tiap skema memiliki 3 pertanyaan spesifik dari materi)
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

class LearningPage extends StatefulWidget {
  final HarmonyItem item;
  final int alreadyEarnedKeys;

  const LearningPage({
    super.key,
    required this.item,
    required this.alreadyEarnedKeys,
  });

  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  final PageController _verticalController = PageController();
  double _verticalScrollRatio = 0.0;

  final PageController _quizPageController = PageController();
  bool _isQuizMode = false;
  int _currentQuizIndex = 0;

  Timer? _countdownTimer;
  int _secondsRemaining = 30;
  bool _isTimedOut = false;

  List<QuizQuestion> _activeQuestions = [];
  late List<int?> _selectedAnswers;
  int _sessionEarnedKeys = 0;

  List<LearningSlideData> get slides =>
      schemeLearningContent[widget.item.title] ??
      schemeLearningContent['Analogous']!;

  @override
  void initState() {
    super.initState();
    _verticalController.addListener(() {
      if (_verticalController.hasClients &&
          _verticalController.position.maxScrollExtent > 0) {
        setState(() {
          _verticalScrollRatio = _verticalController.position.pixels /
              _verticalController.position.maxScrollExtent;
        });
      }
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _verticalController.dispose();
    _quizPageController.dispose();
    super.dispose();
  }

  void _setupShuffledQuestions() {
    final rawList =
        schemeQuizContent[widget.item.title] ?? schemeQuizContent['Analogous']!;
    _activeQuestions = rawList.map((q) {
      final correctAnswerString = q.options[q.correctIndex];
      final shuffledOptions = List<String>.from(q.options)..shuffle();
      final newCorrectIndex = shuffledOptions.indexOf(correctAnswerString);

      return QuizQuestion(
        question: q.question,
        options: shuffledOptions,
        correctIndex: newCorrectIndex,
        explanation: q.explanation,
      );
    }).toList();

    _selectedAnswers = List.filled(_activeQuestions.length, null);
    _sessionEarnedKeys = 0;
    _currentQuizIndex = 0;
    _isTimedOut = false;
  }

  void _startTimer() {
    _countdownTimer?.cancel();
    _secondsRemaining = 30;
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _countdownTimer?.cancel();
        setState(() {
          _isTimedOut = true;
        });
        if (_quizPageController.hasClients) {
          _quizPageController.animateToPage(
            3,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  void _onAnswerSelected(int questionIdx, int optionIdx) {
    if (_selectedAnswers[questionIdx] != null || _secondsRemaining <= 0) return;

    setState(() {
      _selectedAnswers[questionIdx] = optionIdx;
      if (optionIdx == _activeQuestions[questionIdx].correctIndex) {
        _sessionEarnedKeys++;
      }
    });
  }

  void _resetQuiz() {
    _countdownTimer?.cancel();
    setState(() {
      _setupShuffledQuestions();
    });
    if (_quizPageController.hasClients) {
      _quizPageController.jumpToPage(0);
    }
    _startTimer();
  }

  void _retryLearning() {
    _countdownTimer?.cancel();
    setState(() {
      _isQuizMode = false;
      _currentQuizIndex = 0;
      _sessionEarnedKeys = 0;
      _isTimedOut = false;
    });
    if (_verticalController.hasClients) {
      _verticalController.jumpToPage(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: _isQuizMode ? widget.item.primaryColor : Colors.white,
      bottomNavigationBar: const CustomBottomNavBar(),
      body: SafeArea(
        bottom: false,
        child: _isQuizMode ? _buildQuizFlow() : _buildVerticalLearningFlow(),
      ),
    );
  }

  // --- 1. TAHAPAN BELAJAR VERTIKAL (5 SLIDE) ---
  Widget _buildVerticalLearningFlow() {
    return Stack(
      children: [
        PageView(
          controller: _verticalController,
          scrollDirection: Axis.vertical,
          children: [
            _buildSlide1Overview(),
            _buildSlideContent(slides[0], 0),
            _buildSlideContent(slides[1], 1),
            _buildSlideContent(slides[2], 2),
            _buildSlide5StartQuiz(),
          ],
        ),

        // Header Top Bar
        Positioned(
          top: 12,
          left: 20,
          right: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_back_ios_new,
                          size: 14, color: Colors.black87),
                      SizedBox(width: 6),
                      Text('Chropamine',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13)),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(4),
                child:
                    const Icon(Icons.person, size: 22, color: Colors.black87),
              ),
            ],
          ),
        ),

        // Scrollbar Indicator di Sisi Kiri
        Positioned(
          left: 14,
          top: 120,
          bottom: 120,
          child: SizedBox(
            width: 4,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final trackHeight = constraints.maxHeight;
                const thumbHeight = 45.0;
                final topOffset = (trackHeight - thumbHeight) *
                    _verticalScrollRatio.clamp(0.0, 1.0);

                return Stack(
                  children: [
                    Container(
                      width: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9ECEF),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    Positioned(
                      top: topOffset,
                      child: Container(
                        width: 4,
                        height: thumbHeight,
                        decoration: BoxDecoration(
                          color: const Color(0xFFADB5BD),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSlide1Overview() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 36, right: 20, top: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kenalan dengan\n${widget.item.title}!',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  height: 1.25,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: -130,
          top: 180,
          child: SizedBox(
            width: 320,
            height: 320,
            child: CustomPaint(
              painter:
                  DynamicSchemeWheelPainter(schemeTitle: widget.item.title),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSlideContent(LearningSlideData slide, int slideIndex) {
    return Padding(
      padding: const EdgeInsets.only(left: 36, right: 24, top: 75, bottom: 90),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            slide.title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          // Visual Wheel khusus tiap skema
          SchemeVisualCard(
            schemeTitle: widget.item.title,
            primaryColor: widget.item.primaryColor,
            slideIndex: slideIndex,
          ),
          const SizedBox(height: 20),
          Text(
            slide.description1,
            style: const TextStyle(
              fontSize: 14,
              height: 1.6,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            slide.description2,
            style: const TextStyle(
              fontSize: 14,
              height: 1.6,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlide5StartQuiz() {
    return Container(
      color: widget.item.primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: const BoxDecoration(
              color: Color(0xFFFFD60A),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                '!',
                style: TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Quiz!',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black87,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 46, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
            ),
            onPressed: () {
              setState(() {
                _isQuizMode = true;
              });
              _resetQuiz();
            },
            child: const Text('START',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // --- 2. TAHAPAN KUIS (HORIZONTAL SWIPE) ---
  Widget _buildQuizFlow() {
    final formattedTimer = '00:${_secondsRemaining.toString().padLeft(2, '0')}';

    return Column(
      children: [
        // Header Kuis
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.blur_on, size: 20, color: Colors.black87),
                    SizedBox(width: 6),
                    Text('Chropamine',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13)),
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(4),
                child:
                    const Icon(Icons.person, size: 22, color: Colors.black87),
              ),
            ],
          ),
        ),

        // Progress Bar
        if (_currentQuizIndex < 3) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: List.generate(3, (idx) {
                return Expanded(
                  child: Container(
                    height: 5,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      color: idx <= _currentQuizIndex
                          ? Colors.white
                          : Colors.white.withOpacity(0.35),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.item.title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12),
                ),
                Text(
                  formattedTimer,
                  style: TextStyle(
                    color: _secondsRemaining <= 5
                        ? Colors.yellowAccent
                        : Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],

        // PageView: Soal 1 -> Soal 2 -> Soal 3 -> Layar Hasil
        Expanded(
          child: PageView.builder(
            controller: _quizPageController,
            physics: (_currentQuizIndex < 3 &&
                    _selectedAnswers[_currentQuizIndex] == null)
                ? const NeverScrollableScrollPhysics()
                : const BouncingScrollPhysics(),
            onPageChanged: (idx) {
              setState(() {
                _currentQuizIndex = idx;
              });
              if (idx == 3) {
                _countdownTimer?.cancel();
              }
            },
            itemCount: 4,
            itemBuilder: (context, pageIndex) {
              if (pageIndex == 3) {
                return _buildCongratsScreen();
              }

              final q = _activeQuestions[pageIndex];
              final hasAnswered = _selectedAnswers[pageIndex] != null;
              final selectedOpt = _selectedAnswers[pageIndex];

              return SingleChildScrollView(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 18, bottom: 90),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      q.question,
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 28),

                    // 4 Pilihan Jawaban Acak
                    ...List.generate(q.options.length, (optIdx) {
                      Color buttonBg = Colors.white;
                      Color textColor = Colors.black87;

                      if (hasAnswered) {
                        if (optIdx == q.correctIndex) {
                          buttonBg = const Color(0xFF00E676);
                          textColor = Colors.white;
                        } else if (selectedOpt == optIdx) {
                          buttonBg = const Color(0xFFD50000);
                          textColor = Colors.white;
                        }
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonBg,
                              foregroundColor: textColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            onPressed: () =>
                                _onAnswerSelected(pageIndex, optIdx),
                            child: Text(
                              q.options[optIdx],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 13),
                            ),
                          ),
                        ),
                      );
                    }),

                    // Penjelasan Singkat & Petunjuk Swipe
                    if (hasAnswered) ...[
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          q.explanation,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            height: 1.4,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Swipe right to continue',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 6),
                          Icon(Icons.arrow_forward_ios,
                              size: 12, color: Colors.white),
                        ],
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Congrats / Result Screen
  Widget _buildCongratsScreen() {
    final alreadyMax = widget.alreadyEarnedKeys >= 3;
    final keysToAdd = alreadyMax
        ? 0
        : math.max(0, _sessionEarnedKeys - widget.alreadyEarnedKeys);

    String resultTitle;
    String resultSubtitle;

    if (_isTimedOut) {
      resultTitle = "Time's Up!";
      resultSubtitle = "You ran out of time. Give it another shot!";
    } else if (_sessionEarnedKeys == 3) {
      resultTitle = "Flawless!";
      resultSubtitle =
          "Outstanding! You mastered the ${widget.item.title} scheme!";
    } else if (_sessionEarnedKeys == 2) {
      resultTitle = "Well Done!";
      resultSubtitle =
          "Great effort! You secured 2 keys. One more to perfection!";
    } else if (_sessionEarnedKeys == 1) {
      resultTitle = "Keep Practicing!";
      resultSubtitle = "Good start! You got 1 key. Try again to collect more!";
    } else {
      resultTitle = "Don't Give Up!";
      resultSubtitle =
          "You didn't get any keys this round. Review the materials and retry!";
    }

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              resultTitle,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            SizedBox(
              height: 38,
              child: Text(
                resultSubtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withOpacity(0.92),
                  height: 1.3,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Box Visual Hasil
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Icon(
                _isTimedOut
                    ? Icons.timer_off_rounded
                    : (_sessionEarnedKeys == 3
                        ? Icons.emoji_events_rounded
                        : Icons.lightbulb_outline_rounded),
                size: 64,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),

            // Posisi Kunci & Keterangan
            SizedBox(
              height: 68,
              child: Center(
                child: alreadyMax
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text(
                          'You already got all 3 keys for this scheme!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(3, (index) {
                              final isKeyUnlocked = index < _sessionEarnedKeys;
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: Icon(
                                  Icons.vpn_key_rounded,
                                  size: 32,
                                  color: isKeyUnlocked
                                      ? const Color(0xFFFFD700)
                                      : Colors.white24,
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            keysToAdd > 0
                                ? '+$keysToAdd new key${keysToAdd > 1 ? "s" : ""} added to your collection!'
                                : (_isTimedOut
                                    ? 'No keys earned due to timeout'
                                    : '$_sessionEarnedKeys of 3 keys earned'),
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 20),

            // 3 Tombol Aksi
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.2),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                            side: const BorderSide(color: Colors.white38),
                          ),
                        ),
                        onPressed: _retryLearning,
                        child: const Text(
                          'Retry Learning',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black87,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        onPressed: _resetQuiz,
                        child: const Text(
                          'Retry Quiz',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black87,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context, _sessionEarnedKeys);
                    },
                    child: const Text(
                      'Next',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// --- Komponen Visual Color Wheel untuk Materi ---
class SchemeVisualCard extends StatelessWidget {
  final String schemeTitle;
  final Color primaryColor;
  final int slideIndex;

  const SchemeVisualCard({
    super.key,
    required this.schemeTitle,
    required this.primaryColor,
    required this.slideIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE9ECEF), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(140, 140),
            painter: DynamicSchemeWheelPainter(
              schemeTitle: schemeTitle,
              highlightOnly: slideIndex == 1,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Text(
              schemeTitle,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Painter Roda Warna Khusus Tiap Skema
class DynamicSchemeWheelPainter extends CustomPainter {
  final String schemeTitle;
  final bool highlightOnly;

  DynamicSchemeWheelPainter({
    required this.schemeTitle,
    this.highlightOnly = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const strokeWidth = 24.0;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    const standardColors = [
      Color(0xFFE52020), // Merah
      Color(0xFFFF5722), // Merah-Oranye
      Color(0xFFFF9800), // Oranye
      Color(0xFFFFC107), // Kuning-Oranye
      Color(0xFFFFEB3B), // Kuning
      Color(0xFF8BC34A), // Kuning-Hijau
      Color(0xFF4CAF50), // Hijau
      Color(0xFF009688), // Biru-Hijau
      Color(0xFF2196F3), // Biru
      Color(0xFF3F51B5), // Biru-Ungu
      Color(0xFF9C27B0), // Ungu
      Color(0xFFE91E63), // Merah-Ungu
    ];

    for (int i = 0; i < 12; i++) {
      paint.color = standardColors[i].withOpacity(0.22);
      final startAngle = (i * 30 - 15) * math.pi / 180;
      const sweepAngle = 28 * math.pi / 180;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - (strokeWidth / 2)),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }

    List<int> activeIndices = [];
    switch (schemeTitle) {
      case 'Analogous':
        activeIndices = [0, 1, 2];
        break;
      case 'Monochrome':
        activeIndices = [4];
        break;
      case 'Complement':
        activeIndices = [0, 6];
        break;
      case 'Triangle':
        activeIndices = [0, 4, 8];
        break;
      case 'Square':
        activeIndices = [0, 3, 6, 9];
        break;
      case 'Split Complement':
        activeIndices = [0, 5, 7];
        break;
      default:
        activeIndices = [0, 1, 2];
    }

    for (final idx in activeIndices) {
      paint.color = standardColors[idx];
      paint.strokeWidth = strokeWidth + 4;
      final startAngle = (idx * 30 - 15) * math.pi / 180;
      const sweepAngle = 28 * math.pi / 180;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - (strokeWidth / 2)),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }

    if (activeIndices.length > 1) {
      final linePaint = Paint()
        ..color = Colors.black54
        ..strokeWidth = 1.8
        ..style = PaintingStyle.stroke;

      final path = Path();
      for (int i = 0; i < activeIndices.length; i++) {
        final angle = activeIndices[i] * 30 * math.pi / 180;
        final pointRadius = radius - strokeWidth - 4;
        final x = center.dx + pointRadius * math.cos(angle);
        final y = center.dy + pointRadius * math.sin(angle);
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      if (activeIndices.length >= 3) {
        path.close();
      }
      canvas.drawPath(path, linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant DynamicSchemeWheelPainter oldDelegate) {
    return oldDelegate.schemeTitle != schemeTitle ||
        oldDelegate.highlightOnly != highlightOnly;
  }
}
