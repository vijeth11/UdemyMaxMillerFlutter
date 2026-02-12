import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'components/ball.dart';
import 'components/game_board.dart';
import 'levels/level.dart';
import '../controllers/tilt_controller.dart';
import '../controllers/game_state_controller.dart';
import '../services/audio_service.dart';

/// Main Flame game class
class BallGame extends FlameGame {
  final Level level;
  final TiltController tiltController;
  final GameStateController gameStateController;
  final AudioService audioService;
  final VoidCallback? onGoalReached;
  final VoidCallback? onPitFall;

  late Ball _ball;
  late GameBoard _gameBoard;
  bool _isPaused = false;
  CellPosition? _lastCellPosition;

  BallGame({
    required this.level,
    required this.tiltController,
    required this.gameStateController,
    required this.audioService,
    this.onGoalReached,
    this.onPitFall,
  });

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Create game board
    _gameBoard = GameBoard(
      level: level,
      boardSize: Vector2(size.x, size.y),
    );
    await add(_gameBoard);

    // Create ball at start position
    final startCenter = _gameBoard.getCellCenter(
      level.startCell.row,
      level.startCell.col,
    );
    _ball = Ball(position: startCenter);
    await add(_ball);

    // Listen to tilt events
    tiltController.tiltStream.listen((tilt) {
      if (!_isPaused) {
        _ball.applyTilt(tilt.dx, tilt.dy);
      }
    });

    // Start tilt controller
    tiltController.start();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (_isPaused) return;

    // Check ball position against grid
    final ballGridPos = _gameBoard.worldToGrid(_ball.position);
    if (ballGridPos != null) {
      // Check if entered a new cell
      if (_lastCellPosition == null ||
          ballGridPos.row != _lastCellPosition!.row ||
          ballGridPos.col != _lastCellPosition!.col) {
        _handleCellEntry(ballGridPos);
        _lastCellPosition = ballGridPos;
      }

      // Check for pit collision
      final cell = _gameBoard.getCell(ballGridPos.row, ballGridPos.col);
      if (cell != null && cell.isPit) {
        _handlePitCollision(ballGridPos);
      }

      // Check for goal reached
      if (cell != null && cell.isGoal) {
        _handleGoalReached();
      }
    }

    // Wall collision (simple boundary check)
    _handleWallCollisions();
  }

  void _handleCellEntry(CellPosition cellPos) {
    // Mark cell as visited and update score
    gameStateController.visitCell(cellPos.row, cellPos.col);
    _gameBoard.markCellVisited(cellPos.row, cellPos.col);
    
    // Play rolling sound
    audioService.playSFX('ball_rolling');
  }

  void _handlePitCollision(CellPosition pitPos) {
    // Play pit fall sound
    audioService.playSFX('pit_fall');
    
    // Notify game state
    gameStateController.handlePitFall();
    
    // Reset ball to start position
    final startCenter = _gameBoard.getCellCenter(
      level.startCell.row,
      level.startCell.col,
    );
    _ball.position = startCenter;
    _ball.velocity = Vector2.zero();
    _lastCellPosition = null;
    
    // Reset board visuals
    _gameBoard.resetVisitedCells();
    
    // Notify callback
    onPitFall?.call();
  }

  void _handleGoalReached() {
    // Notify game state
    gameStateController.handleGoalReached();
    
    // Play success sound
    audioService.playSFX('success');
    
    // Pause the game
    pause();
    
    // Notify callback
    onGoalReached?.call();
  }

  void _handleWallCollisions() {
    final ballRadius = Ball.radius;
    final bounds = _gameBoard.getBounds();

    // Check boundaries
    if (_ball.position.x - ballRadius < bounds.left) {
      _ball.position.x = bounds.left + ballRadius;
      _ball.velocity.x = -_ball.velocity.x * 0.5;
    }
    if (_ball.position.x + ballRadius > bounds.right) {
      _ball.position.x = bounds.right - ballRadius;
      _ball.velocity.x = -_ball.velocity.x * 0.5;
    }
    if (_ball.position.y - ballRadius < bounds.top) {
      _ball.position.y = bounds.top + ballRadius;
      _ball.velocity.y = -_ball.velocity.y * 0.5;
    }
    if (_ball.position.y + ballRadius > bounds.bottom) {
      _ball.position.y = bounds.bottom - ballRadius;
      _ball.velocity.y = -_ball.velocity.y * 0.5;
    }

    // Check wall collisions (non-path cells)
    // Simple approach: if ball enters a wall cell, bounce back
    if (_gameBoard.isWall(_ball.position)) {
      // Reverse velocity
      _ball.velocity *= -0.5;
      
      // Push ball back to previous valid position
      final gridPos = _gameBoard.worldToGrid(_ball.position);
      if (gridPos != null) {
        // Move ball towards center of current/last valid cell
        if (_lastCellPosition != null) {
          final validCenter = _gameBoard.getCellCenter(
            _lastCellPosition!.row,
            _lastCellPosition!.col,
          );
          final direction = (validCenter - _ball.position).normalized();
          _ball.position += direction * 5;
        }
      }
    }
  }

  void pause() {
    _isPaused = true;
    tiltController.pause();
  }

  void resume() {
    _isPaused = false;
    tiltController.resume();
  }

  void restart() {
    // Reset ball to start
    final startCenter = _gameBoard.getCellCenter(
      level.startCell.row,
      level.startCell.col,
    );
    _ball.position = startCenter;
    _ball.velocity = Vector2.zero();
    _lastCellPosition = null;
    
    // Reset board
    _gameBoard.resetVisitedCells();
    
    // Resume game
    _isPaused = false;
  }

  @override
  void onRemove() {
    tiltController.stop();
    super.onRemove();
  }
}
