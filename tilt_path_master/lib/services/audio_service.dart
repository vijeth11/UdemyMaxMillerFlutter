import 'package:audioplayers/audioplayers.dart';

/// Service for managing game audio
class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioPlayer _bgMusicPlayer = AudioPlayer();
  final AudioPlayer _sfxPlayer = AudioPlayer();

  bool _bgMusicEnabled = true;
  bool _sfxEnabled = true;
  bool _isBGMusicPlaying = false;

  /// Initialize audio service
  Future<void> init(
      {bool bgMusicEnabled = true, bool sfxEnabled = true}) async {
    _bgMusicEnabled = bgMusicEnabled;
    _sfxEnabled = sfxEnabled;

    // Set release mode for BGM to loop
    await _bgMusicPlayer.setReleaseMode(ReleaseMode.loop);
  }

  /// Play background music
  Future<void> playBGMusic() async {
    if (_bgMusicEnabled && !_isBGMusicPlaying) {
      try {
        // Note: Replace with actual audio file when available
        // await _bgMusicPlayer.play(AssetSource('audio/background_music.mp3'));
        _isBGMusicPlaying = true;
      } catch (e) {
        print('Error playing background music: $e');
      }
    }
  }

  /// Pause background music
  Future<void> pauseBGMusic() async {
    await _bgMusicPlayer.pause();
    _isBGMusicPlaying = false;
  }

  /// Resume background music
  Future<void> resumeBGMusic() async {
    if (_bgMusicEnabled) {
      await _bgMusicPlayer.resume();
      _isBGMusicPlaying = true;
    }
  }

  /// Stop background music
  Future<void> stopBGMusic() async {
    await _bgMusicPlayer.stop();
    _isBGMusicPlaying = false;
  }

  /// Play sound effect
  Future<void> playSFX(String sfxName) async {
    if (_sfxEnabled) {
      try {
        // Note: Replace with actual audio files when available
        // await _sfxPlayer.play(AssetSource('audio/$sfxName.mp3'));
      } catch (e) {
        print('Error playing SFX: $e');
      }
    }
  }

  /// Toggle background music
  void toggleBGMusic(bool enabled) {
    _bgMusicEnabled = enabled;
    if (!enabled) {
      pauseBGMusic();
    } else {
      playBGMusic();
    }
  }

  /// Toggle sound effects
  void toggleSFX(bool enabled) {
    _sfxEnabled = enabled;
  }

  /// Get current BGM state
  bool get isBGMusicEnabled => _bgMusicEnabled;

  /// Get current SFX state
  bool get isSFXEnabled => _sfxEnabled;

  /// Dispose audio resources
  void dispose() {
    _bgMusicPlayer.dispose();
    _sfxPlayer.dispose();
  }
}
