import 'package:flutter/material.dart';
import '../services/audio_service.dart';
import '../services/storage_service.dart';

/// Controller for managing audio settings
class AudioController extends ChangeNotifier {
  final AudioService _audioService;
  final StorageService _storageService;

  bool _bgMusicEnabled = true;
  bool _sfxEnabled = true;

  AudioController(this._audioService, this._storageService) {
    _loadPreferences();
  }

  bool get isBGMusicEnabled => _bgMusicEnabled;
  bool get isSFXEnabled => _sfxEnabled;

  /// Load audio preferences from storage
  void _loadPreferences() {
    _bgMusicEnabled = _storageService.isBGMusicEnabled();
    _sfxEnabled = _storageService.isSFXEnabled();
    
    _audioService.init(
      bgMusicEnabled: _bgMusicEnabled,
      sfxEnabled: _sfxEnabled,
    );
  }

  /// Toggle background music
  Future<void> toggleBGMusic(bool enabled) async {
    _bgMusicEnabled = enabled;
    _audioService.toggleBGMusic(enabled);
    await _storageService.setBGMusicEnabled(enabled);
    notifyListeners();
  }

  /// Toggle sound effects
  Future<void> toggleSFX(bool enabled) async {
    _sfxEnabled = enabled;
    _audioService.toggleSFX(enabled);
    await _storageService.setSFXEnabled(enabled);
    notifyListeners();
  }

  /// Play background music
  void playBGMusic() {
    _audioService.playBGMusic();
  }

  /// Pause background music
  void pauseBGMusic() {
    _audioService.pauseBGMusic();
  }

  /// Resume background music
  void resumeBGMusic() {
    _audioService.resumeBGMusic();
  }

  /// Play sound effect
  void playSFX(String sfxName) {
    _audioService.playSFX(sfxName);
  }
}
