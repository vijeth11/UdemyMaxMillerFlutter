import 'package:flutter/material.dart';
import 'package:simple_platform/game/actor/game_play.dart';
import 'package:simple_platform/game/game.dart';
import 'package:simple_platform/game/overlays/main_menu.dart';
import 'package:simple_platform/game/utils/audio_manager.dart';

class Settings extends StatelessWidget {
  static const id = 'Settings';
  final SimplePlatformer gameRef;

  const Settings({super.key, required this.gameRef});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                child: ValueListenableBuilder<bool>(
              valueListenable: AudioManager.sfx,
              builder: (ctx, bool sfx, child) => SwitchListTile(
                  title: Text("Sound Effects"),
                  value: sfx,
                  onChanged: (value) {
                    AudioManager.sfx.value = value;
                  }),
            )),
            SizedBox(
                child: ValueListenableBuilder<bool>(
              valueListenable: AudioManager.bgm,
              builder: (ctx, bool bgm, child) => SwitchListTile(
                  title: Text("Background music"),
                  value: bgm,
                  onChanged: (value) {
                    AudioManager.bgm.value = value;
                  }),
            )),
            SizedBox(
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  gameRef.overlays.remove(id);
                  gameRef.overlays.add(MainMenu.id);
                },
                child: Text('Back'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
