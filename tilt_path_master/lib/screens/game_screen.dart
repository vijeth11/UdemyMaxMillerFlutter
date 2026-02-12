import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:provider/provider.dart';
import '../game/ball_game.dart';
import '../controllers/game_state_controller.dart';
import '../controllers/tilt_controller.dart';
import '../services/audio_service.dart';
import 'pause_menu.dart';

/// Main game screen with Flame game widget and HUD
class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late BallGame _game;
  late TiltController _tiltController;
  bool _showCompletionDialog = false;

  @override
  void initState() {
    super.initState();
    _tiltController = TiltController();
    _initializeGame();
  }

  void _initializeGame() {
    final gameState = context.read<GameStateController>();
    final audioService = AudioService();

    _game = BallGame(
      level: gameState.currentLevel!,
      tiltController: _tiltController,
      gameStateController: gameState,
      audioService: audioService,
      onGoalReached: _handleGoalReached,
      onPitFall: _handlePitFall,
    );
  }

  void _handleGoalReached() {
    setState(() {
      _showCompletionDialog = true;
    });
    _showLevelCompleteDialog();
  }

  void _handlePitFall() {
    // Visual feedback could be added here
  }

  void _showLevelCompleteDialog() {
    final gameState = context.read<GameStateController>();
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Level Complete!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 64),
            const SizedBox(height: 16),
            Text(
              'Score: ${gameState.currentScore}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop(); // Return to main menu
            },
            child: const Text('Main Menu'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              final nextLevel = gameState.currentLevel!.levelNumber + 1;
              if (nextLevel <= gameState.totalLevels) {
                gameState.startLevel(nextLevel);
                _restartGame();
              } else {
                Navigator.of(context).pop(); // No more levels
              }
            },
            child: const Text('Next Level'),
          ),
        ],
      ),
    );
  }

  void _showPauseMenu() {
    _game.pause();
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PauseMenu(
        onMainPage: () {
          Navigator.of(context).pop(); // Close dialog
          Navigator.of(context).pop(); // Return to main menu
        },
        onRestart: () {
          Navigator.of(context).pop(); // Close dialog
          _restartGame();
        },
        onResume: () {
          Navigator.of(context).pop(); // Close dialog
          _game.resume();
        },
      ),
    );
  }

  void _restartGame() {
    final gameState = context.read<GameStateController>();
    gameState.restartLevel();
    setState(() {
      _initializeGame();
    });
  }

  @override
  void dispose() {
    _tiltController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Game widget
          GameWidget(game: _game),
          
          // HUD Overlay
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Score display
                      Consumer<GameStateController>(
                        builder: (context, gameState, child) {
                          return Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Score: ${gameState.currentScore}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'High: ${gameState.currentHighScore}',
                                  style: const TextStyle(
                                    color: Colors.amber,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      
                      // Pause button
                      IconButton(
                        icon: const Icon(Icons.pause, color: Colors.white),
                        iconSize: 32,
                        onPressed: _showPauseMenu,
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
