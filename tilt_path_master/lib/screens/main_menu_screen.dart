import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/game_state_controller.dart';
import 'game_screen.dart';
import 'level_select_screen.dart';
import 'settings_screen.dart';

/// Main menu screen
class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade900,
              Colors.purple.shade700,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Game title
                const Text(
                  'TILT PATH',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 4,
                    shadows: [
                      Shadow(
                        color: Colors.black54,
                        offset: Offset(3, 3),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
                const Text(
                  'MASTER',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                    letterSpacing: 4,
                    shadows: [
                      Shadow(
                        color: Colors.black54,
                        offset: Offset(3, 3),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 60),

                // Menu buttons
                _MenuButton(
                  text: 'Play',
                  icon: Icons.play_arrow_rounded,
                  color: Colors.green,
                  onPressed: () {
                    final gameState = context.read<GameStateController>();
                    gameState.resumeLastLevel();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const GameScreen()),
                    );
                  },
                ),
                const SizedBox(height: 20),
                
                _MenuButton(
                  text: 'Select Level',
                  icon: Icons.grid_view_rounded,
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LevelSelectScreen()),
                    );
                  },
                ),
                const SizedBox(height: 20),
                
                _MenuButton(
                  text: 'Settings',
                  icon: Icons.settings_rounded,
                  color: Colors.orange,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SettingsScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const _MenuButton({
    required this.text,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          shadowColor: Colors.black54,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: Colors.white),
            const SizedBox(width: 12),
            Text(
              text,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
