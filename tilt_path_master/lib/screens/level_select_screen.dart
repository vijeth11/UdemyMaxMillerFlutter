import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/game_state_controller.dart';
import 'game_screen.dart';

/// Level selection screen
class LevelSelectScreen extends StatelessWidget {
  const LevelSelectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameState = context.watch<GameStateController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Level'),
        backgroundColor: Colors.purple.shade800,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.purple.shade800,
              Colors.blue.shade900,
            ],
          ),
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.9,
          ),
          itemCount: gameState.totalLevels,
          itemBuilder: (context, index) {
            final levelNumber = index + 1;
            final isUnlocked = gameState.isLevelUnlocked(levelNumber);
            final highScore = gameState.getLevelHighScore(levelNumber);
            final isCompleted = highScore > 0;

            return _LevelCard(
              levelNumber: levelNumber,
              isUnlocked: isUnlocked,
              isCompleted: isCompleted,
              highScore: highScore,
              onTap: isUnlocked
                  ? () {
                      gameState.startLevel(levelNumber);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const GameScreen()),
                      );
                    }
                  : null,
            );
          },
        ),
      ),
    );
  }
}

class _LevelCard extends StatelessWidget {
  final int levelNumber;
  final bool isUnlocked;
  final bool isCompleted;
  final int highScore;
  final VoidCallback? onTap;

  const _LevelCard({
    required this.levelNumber,
    required this.isUnlocked,
    required this.isCompleted,
    required this.highScore,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isUnlocked 
              ? (isCompleted ? Colors.green.shade700 : Colors.blue.shade700)
              : Colors.grey.shade600,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lock icon or level number
            if (!isUnlocked)
              const Icon(
                Icons.lock,
                size: 48,
                color: Colors.white54,
              )
            else
              Text(
                levelNumber.toString(),
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            
            const SizedBox(height: 8),
            
            // Stars or high score
            if (isUnlocked)
              Column(
                children: [
                  if (isCompleted)
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 24,
                    ),
                  const SizedBox(height: 4),
                  Text(
                    isCompleted ? 'High: $highScore' : 'Not Played',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            else
              const Text(
                'Locked',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
