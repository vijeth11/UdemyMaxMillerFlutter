import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/game_progress.dart';

/// Service for persisting game data
class StorageService {
  static const String _progressKey = 'game_progress';
  static const String _bgMusicKey = 'bg_music_enabled';
  static const String _sfxKey = 'sfx_enabled';

  late SharedPreferences _prefs;

  /// Initialize the service
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Save game progress
  Future<void> saveProgress(GameProgress progress) async {
    final json = jsonEncode(progress.toJson());
    await _prefs.setString(_progressKey, json);
  }

  /// Load game progress
  GameProgress loadProgress() {
    final json = _prefs.getString(_progressKey);
    if (json == null) {
      return GameProgress();
    }
    return GameProgress.fromJson(jsonDecode(json));
  }

  /// Save background music preference
  Future<void> setBGMusicEnabled(bool enabled) async {
    await _prefs.setBool(_bgMusicKey, enabled);
  }

  /// Load background music preference
  bool isBGMusicEnabled() {
    return _prefs.getBool(_bgMusicKey) ?? true;
  }

  /// Save SFX preference
  Future<void> setSFXEnabled(bool enabled) async {
    await _prefs.setBool(_sfxKey, enabled);
  }

  /// Load SFX preference
  bool isSFXEnabled() {
    return _prefs.getBool(_sfxKey) ?? true;
  }
}
