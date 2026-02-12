/// Data model for player's game progress
class GameProgress {
  int lastPlayedLevel;
  int highestCompletedLevel;
  Map<int, int> levelHighScores; // levelNumber -> highScore

  GameProgress({
    this.lastPlayedLevel = 1,
    this.highestCompletedLevel = 0,
    this.levelHighScores = const {},
  });

  /// Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'lastPlayedLevel': lastPlayedLevel,
      'highestCompletedLevel': highestCompletedLevel,
      'levelHighScores': levelHighScores.map((k, v) => MapEntry(k.toString(), v)),
    };
  }

  /// Create from JSON  
  factory GameProgress.fromJson(Map<String, dynamic> json) {
    return GameProgress(
      lastPlayedLevel: json['lastPlayedLevel'] ?? 1,
      highestCompletedLevel: json['highestCompletedLevel'] ?? 0,
      levelHighScores: (json['levelHighScores'] as Map<String, dynamic>?)?.map(
            (k, v) => MapEntry(int.parse(k), v as int),
          ) ??
          {},
    );
  }

  /// Get high score for a specific level
  int getHighScore(int levelNumber) {
    return levelHighScores[levelNumber] ?? 0;
  }

  /// Update high score for a level
  void setHighScore(int levelNumber, int score) {
    levelHighScores[levelNumber] = score;
  }

  /// Mark level as completed
  void completeLevel(int levelNumber) {
    if (levelNumber > highestCompletedLevel) {
      highestCompletedLevel = levelNumber;
    }
  }

  /// Check if level is unlocked
  bool isLevelUnlocked(int levelNumber) {
    return levelNumber <= highestCompletedLevel + 1;
  }
}
