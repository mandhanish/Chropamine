import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'learningpage.dart';
import 'wheelpage.dart';

class HarmonyItem {
  final String title;
  final String description;
  final Color primaryColor;
  final Color secondaryColor;

  const HarmonyItem({
    required this.title,
    required this.description,
    required this.primaryColor,
    required this.secondaryColor,
  });
}

final List<HarmonyItem> harmonyList = [
  const HarmonyItem(
    title: 'Analogous',
    description:
        'Warna-warna yang saling berdampingan pada roda warna. Memberikan kesan harmonis dan nyaman dilihat.',
    primaryColor: Color(0xFFFF3B30),
    secondaryColor: Color(0xFFFF9500),
  ),
  const HarmonyItem(
    title: 'Monochrome',
    description:
        'Kombinasi saturasi dan kecerahan yang berbeda dari satu warna dasar.',
    primaryColor: Color(0xFFFFCC00),
    secondaryColor: Color(0xFFFFD60A),
  ),
  const HarmonyItem(
    title: 'Complement',
    description:
        'Dua warna yang saling berhadapan secara diagonal pada color wheel.',
    primaryColor: Color(0xFF34C759),
    secondaryColor: Color(0xFF30D158),
  ),
  const HarmonyItem(
    title: 'Triangle',
    description:
        'Tiga warna yang membentuk segitiga sama sisi pada lingkaran warna.',
    primaryColor: Color(0xFF00C7BE),
    secondaryColor: Color(0xFF32ADE6),
  ),
  const HarmonyItem(
    title: 'Square',
    description:
        'Empat warna yang tersebar seimbang dalam bentuk bujur sangkar.',
    primaryColor: Color(0xFF7856FF),
    secondaryColor: Color(0xFF5E5CE6),
  ),
  const HarmonyItem(
    title: 'Split Complement',
    description:
        'Kombinasi warna dasar dengan dua warna di sebelah warna komplementernya.',
    primaryColor: Color(0xFFFF453A),
    secondaryColor: Color(0xFFFF6961),
  ),
];

class LearnPage extends StatefulWidget {
  const LearnPage({super.key});

  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  int? expandedIndex;

  // Catatan perolehan kunci maksimal 3 per skema (anti-farming)
  final Map<String, int> _schemeKeysMap = {
    'Analogous': 0,
    'Monochrome': 0,
    'Complement': 0,
    'Triangle': 0,
    'Square': 0,
    'Split Complement': 0,
  };

  int get totalKeys => _schemeKeysMap.values.fold(0, (sum, val) => sum + val);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: const CustomBottomNavBar(),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 100),
          child: Column(
            children: [
              // Header dengan Dummy Total Kunci & Profile
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
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
                        Icon(Icons.blur_on, size: 20, color: Colors.black87),
                        SizedBox(width: 6),
                        Text(
                          'Chropamine',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ],
                    ),
                  ),

                  // Key counter tracker & profile icon
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F2F4),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.vpn_key_rounded,
                                size: 16, color: Color(0xFFFFB300)),
                            const SizedBox(width: 4),
                            Text(
                              '$totalKeys Keys',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
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
                        child: const Icon(Icons.person,
                            size: 22, color: Colors.black87),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Search Bar
              Container(
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F2F4),
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              const SizedBox(height: 20),

              // List Harmoni Cards
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: harmonyList.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = harmonyList[index];
                  final isExpanded = expandedIndex == index;

                  return HarmonyCard(
                    item: item,
                    isExpanded: isExpanded,
                    earnedKeys: _schemeKeysMap[item.title] ?? 0,
                    onTap: () {
                      setState(() {
                        expandedIndex = isExpanded ? null : index;
                      });
                    },
                    onLearnTap: () async {
                      final currentKeys = _schemeKeysMap[item.title] ?? 0;
                      final resultKeys = await Navigator.push<int>(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LearningPage(
                            item: item,
                            alreadyEarnedKeys: currentKeys,
                          ),
                        ),
                      );

                      if (resultKeys != null) {
                        setState(() {
                          _schemeKeysMap[item.title] =
                              math.max(currentKeys, resultKeys);
                        });
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget Card Harmoni
class HarmonyCard extends StatelessWidget {
  final HarmonyItem item;
  final bool isExpanded;
  final int earnedKeys;
  final VoidCallback onTap;
  final VoidCallback onLearnTap;

  const HarmonyCard({
    super.key,
    required this.item,
    required this.isExpanded,
    required this.earnedKeys,
    required this.onTap,
    required this.onLearnTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: item.primaryColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: item.primaryColor.withOpacity(0.35),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: CustomPaint(
            painter: CardArcPainter(color: item.secondaryColor),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            item.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          if (earnedKeys > 0) ...[
                            const SizedBox(width: 8),
                            Icon(
                              Icons.vpn_key_rounded,
                              size: 14,
                              color: earnedKeys >= 3
                                  ? Colors.amberAccent
                                  : Colors.white70,
                            ),
                            Text(
                              ' $earnedKeys/3',
                              style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ],
                      ),
                      Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  if (isExpanded) ...[
                    const SizedBox(height: 8),
                    Text(
                      item.description,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 14),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black87,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 22, vertical: 6),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: onLearnTap,
                      child: const Text(
                        'Learn',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Background Arc Painter untuk kartu
class CardArcPainter extends CustomPainter {
  final Color color;
  CardArcPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 35;

    final center = Offset(size.width * 0.75, size.height * 1.1);
    canvas.drawCircle(center, 90, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Floating Pill Bottom Navigation Bar
// Floating Pill Bottom Navigation Bar yang sudah terhubung antar-page
class CustomBottomNavBar extends StatelessWidget {
  final int activeTab; // 0: Learn, 1: Wheel, 2: Book

  const CustomBottomNavBar({super.key, this.activeTab = 2});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1E),
            borderRadius: BorderRadius.circular(36),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Tab 1: Game / Palette
              const Icon(Icons.videogame_asset_outlined,
                  color: Colors.white70, size: 24),

              // Tab 2: Color Wheel (Tengah)
              GestureDetector(
                onTap: () {
                  if (activeTab != 1) {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const WheelPage(),
                        transitionDuration: Duration.zero,
                      ),
                    );
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(activeTab == 1 ? 7 : 0),
                  decoration: BoxDecoration(
                    color: activeTab == 1 ? Colors.white : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.donut_large_rounded, // Icon Roda Warna
                    color: activeTab == 1 ? Colors.black : Colors.white70,
                    size: 22,
                  ),
                ),
              ),

              // Tab 3: Learning List
              GestureDetector(
                onTap: () {
                  if (activeTab != 2) {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const LearnPage(),
                        transitionDuration: Duration.zero,
                      ),
                    );
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(activeTab == 2 ? 7 : 0),
                  decoration: BoxDecoration(
                    color: activeTab == 2 ? Colors.white : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.menu_book_rounded,
                    color: activeTab == 2 ? Colors.black : Colors.white70,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
