import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

class AudioManager {
  static final sfx = ValueNotifier(true);
  static final bgm = ValueNotifier(true);

  static Future<void> init() async {
    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.loadAll([
      'Blop_1.wav',
      'Collectibles_6.wav',
      'Hit_2.wav',
      'Jump_15.wav',
      'Winning_Sight.wav'
    ]);
  }

  static void playSfx(String file) {
    if (sfx.value) {
      FlameAudio.play(file);
    }
  }

  static void playBgm() {
    if (bgm.value) {
      FlameAudio.bgm.play('Winning_Sight.wav');
    }
  }

  static void stopBgm() {
    FlameAudio.bgm.stop();
  }
}
