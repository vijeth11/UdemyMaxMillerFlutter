import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/audio_controller.dart';

/// Settings screen for audio controls
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioController = context.watch<AudioController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.orange.shade800,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.orange.shade800,
              Colors.deepOrange.shade900,
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            // Background music setting
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: SwitchListTile(
                title: const Text(
                  'Background Music',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text('Play music in menus and gameplay'),
                value: audioController.isBGMusicEnabled,
                onChanged: (value) {
                  audioController.toggleBGMusic(value);
                },
                activeColor: Colors.green,
              ),
            ),
            const SizedBox(height: 16),

            // Sound effects setting
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: SwitchListTile(
                title: const Text(
                  'Sound Effects',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text('Play ball rolling and pit sounds'),
                value: audioController.isSFXEnabled,
                onChanged: (value) {
                  audioController.toggleSFX(value);
                },
                activeColor: Colors.green,
              ),
            ),
            const SizedBox(height: 32),

            // Info section
            Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Tilt Path Master v1.0',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Tilt your device to guide the ball through the path and avoid pits!',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
