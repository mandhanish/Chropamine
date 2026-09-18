import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'learnpage.dart';

const List<Color> rybColors = [
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

String colorToHex(Color color) {
  return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
}

class SchemeConfig {
  final String title;
  final String quickTip;
  final String geometryType;
  final List<double> pointerAngles;

  const SchemeConfig({
    required this.title,
    required this.quickTip,
    required this.geometryType,
    required this.pointerAngles,
  });
}

final List<SchemeConfig> schemeList = [
  const SchemeConfig(
    title: 'Analogus',
    quickTip:
        'Warna-warna yang saling bersebelahan pada roda warna. Memberikan kesan harmonis dan nyaman.',
    geometryType: 'none',
    pointerAngles: [240, 270, 300],
  ),
  const SchemeConfig(
    title: 'Monochrome',
    quickTip:
        'Satu warna rona yang dieksplorasi hingga ke dalam lingkaran dengan berbagai tingkat kecerahan.',
    geometryType: 'mono',
    pointerAngles: [270],
  ),
  const SchemeConfig(
    title: 'Complement',
    quickTip:
        'Dua warna berhadapan langsung (180°) yang menghasilkan kontras visual paling tajam.',
    geometryType: 'complement',
    pointerAngles: [90, 270],
  ),
  const SchemeConfig(
    title: 'Triangle',
    quickTip:
        'Tiga titik segitiga seimbang (120°) yang membuat tampilan dinamis dan tetap stabil.',
    geometryType: 'triangle',
    pointerAngles: [270, 30, 150],
  ),
  const SchemeConfig(
    title: 'Square',
    quickTip:
        'Empat warna berjarak sama (90°) untuk variasi kategori data yang sangat kaya.',
    geometryType: 'square',
    pointerAngles: [270, 0, 90, 180],
  ),
  const SchemeConfig(
    title: 'Split Complement',
    quickTip:
        'Kombinasi satu warna dasar dengan dua warna yang mengapit warna komplementernya.',
    geometryType: 'split',
    pointerAngles: [270, 60, 120],
  ),
];

class WheelPage extends StatefulWidget {
  const WheelPage({super.key});

  @override
  State<WheelPage> createState() => _WheelPageState();
}

class _WheelPageState extends State<WheelPage> {
  int _currentSchemeIndex = 0;
  double _rotationAngle = 0.0;
  double _startDragAngle = 0.0;
  double _currentRotationBase = 0.0;

  SchemeConfig get currentScheme => schemeList[_currentSchemeIndex];

  Color _getColorAtAngle(double pointerDeg) {
    double rotDeg = _rotationAngle * 180 / math.pi;
    double effectiveDeg = (pointerDeg - rotDeg) % 360;
    if (effectiveDeg < 0) effectiveDeg += 360;
    int colorIndex = ((effectiveDeg + 15) ~/ 30) % 12;
    return rybColors[colorIndex];
  }

  List<Color> _getActivePaletteColors() {
    if (currentScheme.geometryType == 'mono') {
      final baseColor = _getColorAtAngle(270);
      final hsl = HSLColor.fromColor(baseColor);
      return [
        hsl.withLightness((hsl.lightness + 0.25).clamp(0.0, 0.95)).toColor(),
        baseColor,
        hsl.withLightness((hsl.lightness - 0.25).clamp(0.05, 1.0)).toColor(),
      ];
    }

    return currentScheme.pointerAngles
        .map((angle) => _getColorAtAngle(angle))
        .toList();
  }

  void _nextScheme() {
    if (_currentSchemeIndex < schemeList.length - 1) {
      setState(() => _currentSchemeIndex++);
    }
  }

  void _prevScheme() {
    if (_currentSchemeIndex > 0) {
      setState(() => _currentSchemeIndex--);
    }
  }

  @override
  Widget build(BuildContext context) {
    final activeColors = _getActivePaletteColors();

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: const CustomBottomNavBar(activeTab: 1),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 100),
          child: Column(
            children: [
              // Header
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
              const SizedBox(height: 20),

              // Selector Skema
              // Selector Skema (Lebar Box Tetap / Anti-Shift)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _prevScheme,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: _currentSchemeIndex > 0
                            ? const Color(0xFF1C1C1E)
                            : Colors.black26,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back,
                          size: 16, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Box judul dibuat lebar tetap agar panah tidak bergeser
                  Container(
                    width: 170,
                    height: 38,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C1C1E),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      currentScheme.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.5,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: _nextScheme,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: _currentSchemeIndex < schemeList.length - 1
                            ? const Color(0xFF1C1C1E)
                            : Colors.black26,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_forward,
                          size: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Indicator Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(schemeList.length, (index) {
                  return Container(
                    width: index == _currentSchemeIndex ? 12 : 5,
                    height: 5,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: index == _currentSchemeIndex
                          ? const Color(0xFF1C1C1E)
                          : const Color(0xFFD1D5DB),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),

              Center(
                child: SizedBox(
                  width: 270,
                  height: 270,
                  child: GestureDetector(
                    onPanStart: (details) {
                      const center = Offset(135, 135);
                      final touch = details.localPosition;
                      _startDragAngle = math.atan2(
                          touch.dy - center.dy, touch.dx - center.dx);
                      _currentRotationBase = _rotationAngle;
                    },
                    onPanUpdate: (details) {
                      const center = Offset(135, 135);
                      final touch = details.localPosition;
                      final currentAngle = math.atan2(
                          touch.dy - center.dy, touch.dx - center.dx);
                      setState(() {
                        _rotationAngle = _currentRotationBase +
                            (currentAngle - _startDragAngle);
                      });
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Transform.rotate(
                          angle: _rotationAngle,
                          child: CustomPaint(
                            size: const Size(270, 270),
                            painter: FullWheelPainter(
                              isMonochrome:
                                  currentScheme.geometryType == 'mono',
                            ),
                          ),
                        ),
                        CustomPaint(
                          size: const Size(270, 270),
                          painter: StaticIndicatorPainter(
                            scheme: currentScheme,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Putar roda warna untuk eksplorasi',
                style: TextStyle(
                    fontSize: 11,
                    color: Colors.black45,
                    fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 16),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE9ECEF)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Palette Colors',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(activeColors.length, (idx) {
                        final color = activeColors[idx];
                        final hex = colorToHex(color);

                        return GestureDetector(
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: hex));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('$hex copied to clipboard!'),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: color.withOpacity(0.35),
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                hex,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 14),
                    const Divider(height: 1, color: Color(0xFFE9ECEF)),
                    const SizedBox(height: 10),
                    Text(
                      currentScheme.quickTip,
                      style: const TextStyle(
                        fontSize: 11.5,
                        height: 1.4,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FullWheelPainter extends CustomPainter {
  final bool isMonochrome;

  FullWheelPainter({required this.isMonochrome});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width / 2;
    const strokeWidth = 32.0;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    for (int i = 0; i < 12; i++) {
      paint.color = rybColors[i];
      final startAngle = (i * 30 - 15) * math.pi / 180;
      const sweepAngle = (30 - 1.5) * math.pi / 180;
      canvas.drawArc(
        Rect.fromCircle(
            center: center, radius: outerRadius - (strokeWidth / 2)),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }

    if (isMonochrome) {
      final innerPaint = Paint()..style = PaintingStyle.stroke;
      const rings = 3;
      const ringWidth = 22.0;

      for (int r = 1; r <= rings; r++) {
        final radius =
            outerRadius - strokeWidth - (r * ringWidth) + (ringWidth / 2);
        innerPaint.strokeWidth = ringWidth - 1.5;

        for (int i = 0; i < 12; i++) {
          final hsl = HSLColor.fromColor(rybColors[i]);
          // Cincin ke dalam semakin terang / pudar
          final adjustedColor = hsl
              .withLightness((hsl.lightness + (r * 0.14)).clamp(0.0, 0.95))
              .withSaturation((hsl.saturation - (r * 0.15)).clamp(0.1, 1.0))
              .toColor();

          innerPaint.color = adjustedColor;
          final startAngle = (i * 30 - 15) * math.pi / 180;
          const sweepAngle = (30 - 1.5) * math.pi / 180;
          canvas.drawArc(
            Rect.fromCircle(center: center, radius: radius),
            startAngle,
            sweepAngle,
            false,
            innerPaint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant FullWheelPainter oldDelegate) =>
      oldDelegate.isMonochrome != isMonochrome;
}

// Painter Indikator Garis Statis di Atas Roda Warna
class StaticIndicatorPainter extends CustomPainter {
  final SchemeConfig scheme;

  StaticIndicatorPainter({required this.scheme});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const strokeWidth = 32.0;

    // Hitung koordinat titik node indikator
    final innerRadius = radius - strokeWidth - 6;
    final points = scheme.pointerAngles.map((deg) {
      final rad = deg * math.pi / 180;
      return Offset(
        center.dx + innerRadius * math.cos(rad),
        center.dy + innerRadius * math.sin(rad),
      );
    }).toList();

    final linePaint = Paint()
      ..color = const Color(0xFFE2E4E8).withOpacity(0.95)
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final nodePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final nodeBorderPaint = Paint()
      ..color = const Color(0xFFBDBDBD)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    if (scheme.geometryType != 'none' && scheme.geometryType != 'mono') {
      final path = Path()..addPolygon(points, true);
      canvas.drawPath(path, linePaint);
    }

    // Gambar bulatan node di setiap sudut target
    for (final p in points) {
      canvas.drawCircle(p, 9, nodePaint);
      canvas.drawCircle(p, 9, nodeBorderPaint);
    }

    if (scheme.geometryType == 'none') {
      final arcPaint = Paint()
        ..color = const Color(0xFFE2E4E8).withOpacity(0.95)
        ..strokeWidth = 12
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: innerRadius),
        (240 - 2) * math.pi / 180,
        64 * math.pi / 180,
        false,
        arcPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant StaticIndicatorPainter oldDelegate) =>
      oldDelegate.scheme.title != scheme.title;
}
