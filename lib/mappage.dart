import 'package:flutter/material.dart';
import 'learnpage.dart';
import 'progress_manager.dart';

class LevelNodeData {
  final int level;
  final double topFactor;
  final double leftFactor;
  final Color activeColor;
  final int requiredKeys;
  final bool isComingSoon;

  const LevelNodeData({
    required this.level,
    required this.topFactor,
    required this.leftFactor,
    required this.activeColor,
    required this.requiredKeys,
    this.isComingSoon = false,
  });
}

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  int totalStars = 0;
  int availableKeys = 0;

  Map<int, bool> unlockedLevels = {
    1: false,
    2: false,
    3: false,
    4: false,
    5: false,
  };

  Map<int, int> levelStars = {
    1: 0,
    2: 0,
    3: 0,
    4: 0,
    5: 0,
  };

  // Koordinat sudah dipresisikan dengan lekukan jalan & syarat kunci baru
  final List<LevelNodeData> levels = const [
    LevelNodeData(
      level: 1,
      topFactor: 0.71,
      leftFactor: 0.67,
      activeColor: Color(0xFFFF4136), // Merah
      requiredKeys: 2,
    ),
    LevelNodeData(
      level: 2,
      topFactor: 0.56,
      leftFactor: 0.16,
      activeColor: Color(0xFFFFD230), // Kuning
      requiredKeys: 3,
    ),
    LevelNodeData(
      level: 3,
      topFactor: 0.42,
      leftFactor: 0.68,
      activeColor: Color(0xFF1F8A70), // Hijau Tosca
      requiredKeys: 4,
    ),
    LevelNodeData(
      level: 4,
      topFactor: 0.28,
      leftFactor: 0.16,
      activeColor: Color(0xFF0099E5), // Biru
      requiredKeys: 4,
    ),
    LevelNodeData(
      level: 5,
      topFactor: 0.13,
      leftFactor: 0.67,
      activeColor: Color(0xFF7B2CBF), // Ungu
      requiredKeys: 5,
    ),
    LevelNodeData(
      level: 6,
      topFactor: -0.02, // Ujung jalan kiri atas
      leftFactor: 0.16,
      activeColor: Colors.grey,
      requiredKeys: 999,
      isComingSoon: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _refreshMapData();
  }

  Future<void> _refreshMapData() async {
    final data = await ProgressManager.getMapData();
    if (!mounted) return;
    setState(() {
      availableKeys = data['availableKeys'] as int;
      unlockedLevels = Map<int, bool>.from(data['unlocked'] as Map);
      levelStars = Map<int, int>.from(data['stars'] as Map);
      totalStars = data['totalStars'] as int;
    });
  }

  void _onNodeTap(LevelNodeData data) {
    if (data.isComingSoon) {
      _showComingSoonPopup();
      return;
    }

    final isUnlocked = unlockedLevels[data.level] ?? false;
    if (!isUnlocked) {
      _showLockedPopup(data);
    } else {
      _showPlayPopup(data);
    }
  }

  // Pop-up khusus ujung atas kiri (Coming Soon & tidak bisa di-unlock)
  void _showComingSoonPopup() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 18),
                padding: const EdgeInsets.fromLTRB(24, 42, 24, 24),
                width: 280,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD62C),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFE0B400), width: 4),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFD4A800),
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Coming Soon',
                      style: TextStyle(
                        color: Color(0xFF5C4700),
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'New levels are on the way!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF7A5E00),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF999999),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFF707070),
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.lock_rounded,
                              color: Colors.white, size: 18),
                          SizedBox(width: 6),
                          Text(
                            'Locked',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFD4A800),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFEBC010), width: 2),
                ),
                child: const Text(
                  'Next World',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLockedPopup(LevelNodeData data) {
    final canUnlock = availableKeys >= data.requiredKeys;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 18),
                padding: const EdgeInsets.fromLTRB(24, 42, 24, 24),
                width: 280,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD62C),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFE0B400), width: 4),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFD4A800),
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'need ${data.requiredKeys} keys',
                      style: const TextStyle(
                        color: Color(0xFFD90429),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: canUnlock
                          ? () async {
                              final success =
                                  await ProgressManager.unlockMapLevel(
                                      data.level, data.requiredKeys);
                              if (success) {
                                await _refreshMapData();
                                if (dialogContext.mounted) {
                                  Navigator.pop(dialogContext);
                                }
                              }
                            }
                          : null,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 10),
                        decoration: BoxDecoration(
                          color: canUnlock
                              ? const Color(0xFF1F9D85)
                              : const Color(0xFF999999),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: canUnlock
                                  ? const Color(0xFF146B5A)
                                  : const Color(0xFF707070),
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Text(
                          'Unlock',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFD4A800),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFEBC010), width: 2),
                ),
                child: Text(
                  'Level ${data.level}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPlayPopup(LevelNodeData data) {
    final currentStars = levelStars[data.level] ?? 0;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 18),
                padding: const EdgeInsets.fromLTRB(24, 42, 24, 24),
                width: 280,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD62C),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFE0B400), width: 4),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFD4A800),
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildPopupStar(currentStars >= 1, offset: 8),
                        const SizedBox(width: 8),
                        _buildPopupStar(currentStars >= 2, offset: 0),
                        const SizedBox(width: 8),
                        _buildPopupStar(currentStars >= 3, offset: 8),
                      ],
                    ),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(dialogContext);
                        _startLevelGame(data.level);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1F9D85),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xFF146B5A),
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Text(
                          'Play',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFD4A800),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFEBC010), width: 2),
                ),
                child: Text(
                  'Level ${data.level}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPopupStar(bool isEarned, {double offset = 0}) {
    return Transform.translate(
      offset: Offset(0, offset),
      child: Icon(
        Icons.star_rounded,
        size: 46,
        color: isEarned ? const Color(0xFFFFB703) : const Color(0xFFD9AE00),
      ),
    );
  }

  Future<void> _startLevelGame(int level) async {
    await ProgressManager.saveLevelStars(level, 3);
    await _refreshMapData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: const CustomBottomNavBar(activeTab: 0),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/map_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          ...levels.map((data) {
            final isUnlocked =
                !data.isComingSoon && (unlockedLevels[data.level] ?? false);
            final stars = levelStars[data.level] ?? 0;

            return Positioned(
              top: size.height * data.topFactor,
              left: size.width * data.leftFactor,
              child: GestureDetector(
                onTap: () => _onNodeTap(data),
                child: SizedBox(
                  width: 68,
                  height: 92,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      // Bintang mengambang di atas lingkaran tanpa menggeser titik lingkaran
                      if (isUnlocked && stars > 0)
                        Positioned(
                          top: 0,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(3, (index) {
                              return Transform.translate(
                                offset: Offset(0, index == 1 ? -4 : 0),
                                child: Icon(
                                  Icons.star_rounded,
                                  size: 22,
                                  color: index < stars
                                      ? const Color(0xFFFFD62C)
                                      : Colors.black26,
                                ),
                              );
                            }),
                          ),
                        ),

                      // Lingkaran Node selalu terkunci presisi di bagian bawah SizedBox
                      isUnlocked
                          ? Container(
                              width: 64,
                              height: 64,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: data.activeColor,
                                shape: BoxShape.circle,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Text(
                                '${data.level}',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black.withValues(alpha: 0.35),
                                ),
                              ),
                            )
                          : Image.asset(
                              'assets/node_locked.png',
                              width: 64,
                              height: 64,
                            ),
                    ],
                  ),
                ),
              ),
            );
          }),

          // Status Bar Atas (Total Bintang & Saldo Kunci)
          Positioned(
            top: MediaQuery.of(context).padding.top + 14,
            left: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.star_rounded,
                      color: Color(0xFFFFD62C), size: 20),
                  const SizedBox(width: 4),
                  Text(
                    '$totalStars',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(Icons.vpn_key_rounded,
                      color: Color(0xFFFFD62C), size: 18),
                  const SizedBox(width: 4),
                  Text(
                    '$availableKeys',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}