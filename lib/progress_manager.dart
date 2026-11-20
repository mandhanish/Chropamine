import 'dart:math' as math;
import 'package:shared_preferences/shared_preferences.dart';

class ProgressManager {
  static const List<String> schemes = [
    'Analogous',
    'Monochrome',
    'Complement',
    'Triangle',
    'Square',
    'Split Complement',
  ];

  static Future getSchemeKeys() async {
    final prefs = await SharedPreferences.getInstance();
    final Map<String, int> data = {};
    for (final scheme in schemes) {
      data[scheme] = prefs.getInt('scheme_key_$scheme') ?? 0;
    }
    return data;
  }

  static Future getAvailableKeys() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('available_keys') ?? 0;
  }

  static Future updateSchemeKeys(String scheme, int newEarnedKeys) async {
    final prefs = await SharedPreferences.getInstance();
    final oldSchemeKeys = prefs.getInt('scheme_key_$scheme') ?? 0;
    final bestKeys = math.max(oldSchemeKeys, newEarnedKeys);
    final diff = bestKeys - oldSchemeKeys;

    await prefs.setInt('scheme_key_$scheme', bestKeys);

    if (diff > 0) {
      final currentAvailable = prefs.getInt('available_keys') ?? 0;
      await prefs.setInt('available_keys', currentAvailable + diff);
    }
  }

  static Future unlockMapLevel(int level, int cost) async {
    final prefs = await SharedPreferences.getInstance();
    final currentAvailable = prefs.getInt('available_keys') ?? 0;
    if (currentAvailable < cost) return false;

    await prefs.setInt('available_keys', currentAvailable - cost);
    await prefs.setBool('map_level_${level}_unlocked', true);
    return true;
  }

  static Future getMapData() async {
    final prefs = await SharedPreferences.getInstance();
    final availableKeys = prefs.getInt('available_keys') ?? 0;
    final Map<int, bool> unlocked = {};
    final Map<int, int> stars = {};
    int totalStars = 0;

    for (int i = 1; i <= 5; i++) {
      unlocked[i] = prefs.getBool('map_level_${i}_unlocked') ?? false;
      final s = prefs.getInt('map_level_${i}_stars') ?? 0;
      stars[i] = s;
      totalStars += s;
    }

    return {
      'availableKeys': availableKeys,
      'unlocked': unlocked,
      'stars': stars,
      'totalStars': totalStars,
    };
  }

  static Future saveLevelStars(int level, int earnedStars) async {
    final prefs = await SharedPreferences.getInstance();
    final oldStars = prefs.getInt('map_level_${level}_stars') ?? 0;
    if (earnedStars > oldStars) {
      await prefs.setInt('map_level_${level}_stars', earnedStars);
    }
  }
}