import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';

class AudioManger {
  AudioManger._internal();
  static AudioManger _instance = AudioManger._internal();

  static AudioManger get instance => _instance;

  late ValueNotifier<bool> _sfx;
  late ValueNotifier<bool> _bgm;

  void init(){
    
  }
}
