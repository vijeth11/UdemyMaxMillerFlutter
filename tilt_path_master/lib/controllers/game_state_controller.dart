import 'package:flutter/material.dart';
import '../models/game_progress.dart';
import '../services/storage_service.dart';
import '../game/levels/level.dart';
import '../game/levels/level_definitions.dart';

/// Controller for managing game state
class GameStateController extends ChangeNotifier {
  final StorageService _storageService;

  GameProgress _progress = GameProgress();
  Level? _currentLevel;
  int _currentScore = 0;
  final Set<String> _visitedCells = {};
  bool _isPaused = false;

  GameStateController(this._storageService) {
    _loadProgress();
  }

  // Getters
  GameProgress get progress => _progress;
  Level? get currentLevel => _currentLevel;
  int get currentScore => _currentScore;
  int get currentHighScore => _currentLevel != null
      ? _progress.getHighScore(_currentLevel!.levelNumber)
      : 0;
  bool get isPaused => _isPaused;
  Set<String> get visitedCells => _visitedCells;

  /// Load game progress from storage
  void _loadProgress() {
    _progress = _storageService.loadProgress();
    notifyListeners();
  }

  /// Save game progress to storage
  Future<void> _saveProgress() async {
    await _storageService.saveProgress(_progress);
  }

  /// Start a specific level
  void startLevel(int levelNumber) {
    _currentLevel = LevelDefinitions.getLevel(levelNumber);
    _currentScore = 0;
    _visitedCells.clear();
    _isPaused = false;
    _progress.lastPlayedLevel = levelNumber;
    _saveProgress();
    notifyListeners();
  }

  /// Resume the last played level
  void resumeLastLevel() {
    startLevel(_progress.lastPlayedLevel);
  }

  /// Mark a cell as visited and update score
  void visitCell(int row, int col) {
    if (_currentLevel == null || _isPaused) return;

    final cellKey = '$row,$col';
    if (_visitedCells.contains(cellKey)) return;

    final cellPos = CellPosition(row, col);
    if (!_currentLevel!.isOnPath(cellPos)) return;

    _visitedCells.add(cellKey);
    final pointValue = _currentLevel!.getPointValue(cellPos);
    _currentScore += pointValue;
    notifyListeners();
  }

  /// Check if a cell has been visited
  bool isCellVisited(int row, int col) {
    return _visitedCells.contains('$row,$col');
  }

  /// Handle ball falling into pit
  void handlePitFall() {
    if (_currentLevel == null) return;

    // Update high score if current score is higher
    final currentHighScore = _progress.getHighScore(_currentLevel!.levelNumber);
    if (_currentScore > currentHighScore) {
      _progress.setHighScore(_currentLevel!.levelNumber, _currentScore);
      _saveProgress();
    }

    // Reset score and visited cells
    _currentScore = 0;
    _visitedCells.clear();
    notifyListeners();
  }

  /// Handle reaching the goal
  void handleGoalReached() {
    if (_currentLevel == null) return;

    final levelNumber = _currentLevel!.levelNumber;

    // Set high score to current score
    _progress.setHighScore(levelNumber, _currentScore);

    // Mark level as completed
    _progress.completeLevel(levelNumber);

    _saveProgress();
    notifyListeners();
  }

  /// Restart current level
  void restartLevel() {
    if (_currentLevel != null) {
      startLevel(_currentLevel!.levelNumber);
    }
  }

  /// Pause the game
  void pause() {
    _isPaused = true;
    notifyListeners();
  }

  /// Resume the game
  void resume() {
    _isPaused = false;
    notifyListeners();
  }

  /// Check if a level is unlocked
  bool isLevelUnlocked(int levelNumber) {
    return _progress.isLevelUnlocked(levelNumber);
  }

  /// Get high score for a level
  int getLevelHighScore(int levelNumber) {
    return _progress.getHighScore(levelNumber);
  }

  /// Get total number of levels
  int get totalLevels => LevelDefinitions.totalLevels;
}
