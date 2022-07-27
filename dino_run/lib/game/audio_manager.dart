import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class AudioManager {
  AudioManager._internal();
  static AudioManager _instance = AudioManager._internal();

  static AudioManager get instance => _instance;

  late ValueNotifier<bool> _sfx;
  late ValueNotifier<bool> _bgm;
  ValueNotifier<bool> get sfx => _sfx;
  ValueNotifier<bool> get bgm => _bgm;
  late Box prefs;

  Future<void> init() async {
    FlameAudio.bgm.initialize();
    await FlameAudio.bgm.load('8BitPlatformerLoop.wav');

    prefs = await Hive.openBox('preferences');
    if (prefs.get('bgm') == null) {
      prefs.put('bgm', true);
      FlameAudio.bgm.play('8BitPlatformerLoop.wav', volume: 0.4);
    }
    if (prefs.get('sfx') == null) {
      prefs.put('sfx', true);
    }

    _sfx = ValueNotifier(prefs.get('sfx'));
    _bgm = ValueNotifier(prefs.get('bgm'));
  }

  void setSFX(bool value) {
    prefs.put('sfx', value);
    _sfx.value = value;
  }

  void setBGM(bool value) {
    prefs.put('bgm', value);
    _bgm.value = value;
    value
        ? FlameAudio.bgm
            .play('8BitPlatformerLoop.wav', volume: 0.4)
        : FlameAudio.bgm.stop();
  }

  void playSfx(String audioName) {
    if (_sfx.value) {
      FlameAudio.play(audioName, volume: 0.7);
    }
  }
}
