import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'learnpage.dart';
import 'learning_data.dart';
import 'quiz_flow_widgets.dart';

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

  List<ComicSlideData> get comicSlides =>
      schemeComicContent[widget.item.title] ?? schemeComicContent['Analogous']!;

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
        child: _isQuizMode
            ? QuizFlowWidget(
                pageController: _quizPageController,
                currentQuizIndex: _currentQuizIndex,
                secondsRemaining: _secondsRemaining,
                isTimedOut: _isTimedOut,
                schemeTitle: widget.item.title,
                questions: _activeQuestions,
                selectedAnswers: _selectedAnswers,
                sessionEarnedKeys: _sessionEarnedKeys,
                alreadyEarnedKeys: widget.alreadyEarnedKeys,
                onAnswerSelected: _onAnswerSelected,
                onRetryLearning: _retryLearning,
                onResetQuiz: _resetQuiz,
                onFinish: () => Navigator.pop(context, _sessionEarnedKeys),
              )
            : _buildVerticalComicFlow(),
      ),
    );
  }

  // --- ALUR BELAJAR: 2 SLIDE PEMBUKA + KOMIK + START QUIZ ---
  Widget _buildVerticalComicFlow() {
    final slides = comicSlides;
    // Total halaman: 2 slide pembuka + jumlah frame komik + 1 slide tombol Start Quiz di akhir
    final totalPages = 2 + slides.length + 1;

    return Stack(
      children: [
        PageView.builder(
          controller: _verticalController,
          scrollDirection: Axis.vertical,
          itemCount: totalPages,
          itemBuilder: (context, index) {
            if (index == 0) {
              return _buildIntroSlide1(); // Slide 1: Kenalan dengan...
            } else if (index == 1) {
              return _buildIntroSlide2(); // Slide 2: Apa itu ... ? + Frame Merah & "Slide ↑"
            } else if (index >= 2 && index < 2 + slides.length) {
              final comicIndex = index - 2;
              return _buildComicSlideItem(
                  slides[comicIndex]); // Slide Komik dengan Frame Merah
            } else {
              return _buildSlideStartQuiz(); // Slide Terakhir: Tombol Start Quiz
            }
          },
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
                        color: Colors.black.withValues(alpha: 0.08),
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
                      color: Colors.black.withValues(alpha: 0.08),
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

  // Slide Pembuka 1: "Kenalan dengan [Skema]!" + Wheel Graphic
  Widget _buildIntroSlide1() {
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

  // Slide Pembuka 2: "Apa itu [Skema]?" dengan Frame Merah & Teks "Slide ↑"
  Widget _buildIntroSlide2() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(36, 75, 24, 90),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Apa itu ${widget.item.title}?',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                // Frame Merah Lengkung sesuai desain
                border: Border.all(
                  color: const Color(0xFFFF3B30),
                  width: 4.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Slide',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(
                      Icons.arrow_upward_rounded,
                      size: 20,
                      color: Colors.black87,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Slide Komik Per Frame dengan Border/Frame Merah Melengkung
  Widget _buildComicSlideItem(ComicSlideData slide) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(36, 75, 24, 90),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(24),
                // Frame Merah Lengkung untuk Komik
                border: Border.all(
                  color: const Color(0xFFFF3B30),
                  width: 4.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  slide.imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'Gambar Belum Tersedia\n(${slide.imagePath})',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Slide Terakhir: Tombol Mulai Quiz
  Widget _buildSlideStartQuiz() {
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
            'Quiz Time!',
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
}

// --- Custom Painter Roda Warna Khusus Tiap Skema ---
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
      Color(0xFFE52020),
      Color(0xFFFF5722),
      Color(0xFFFF9800),
      Color(0xFFFFC107),
      Color(0xFFFFEB3B),
      Color(0xFF8BC34A),
      Color(0xFF4CAF50),
      Color(0xFF009688),
      Color(0xFF2196F3),
      Color(0xFF3F51B5),
      Color(0xFF9C27B0),
      Color(0xFFE91E63),
    ];

    // Gambar lingkaran dasar transparan
    for (int i = 0; i < 12; i++) {
      paint.color = standardColors[i].withValues(alpha: 0.22);
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

    // Tentukan indeks warna aktif sesuai skema
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

    // Sorot warna yang sesuai skema
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

    // Gambar garis penghubung antar titik warna
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
