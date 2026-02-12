import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../levels/level.dart';
import 'grid_cell.dart';

/// Manages the game board grid
class GameBoard extends Component {
  final Level level;
  final Vector2 boardSize;
  final Map<String, GridCell> cells = {};
  
  late double cellWidth;
  late double cellHeight;

  GameBoard({
    required this.level,
    required this.boardSize,
  });

  @override
  Future<void> onLoad() async {
    super.onLoad();
    
    // Calculate cell dimensions
    cellWidth = boardSize.x / level.gridCols;
    cellHeight = boardSize.y / level.gridRows;

    // Create all grid cells
    for (int row = 0; row < level.gridRows; row++) {
      for (int col = 0; col < level.gridCols; col++) {
        final cellPos = CellPosition(row, col);
        final isPath = level.isOnPath(cellPos);
        final isPit = level.isPit(cellPos);
        final isStart = level.isStart(cellPos);
        final isGoal = level.isGoal(cellPos);
        final pointValue = level.getPointValue(cellPos);

        final cell = GridCell(
          row: row,
          col: col,
          pointValue: pointValue,
          isPath: isPath,
          isPit: isPit,
          isStart: isStart,
          isGoal: isGoal,
          position: Vector2(col * cellWidth, row * cellHeight),
          size: Vector2(cellWidth, cellHeight),
        );

        cells['$row,$col'] = cell;
        add(cell);
      }
    }
  }

  /// Get cell at grid position
  GridCell? getCell(int row, int col) {
    return cells['$row,$col'];
  }

  /// Convert world position to grid position
  CellPosition? worldToGrid(Vector2 worldPos) {
    if (worldPos.x < 0 || worldPos.y < 0 ||
        worldPos.x >= boardSize.x || worldPos.y >= boardSize.y) {
      return null;
    }

    final col = (worldPos.x / cellWidth).floor();
    final row = (worldPos.y / cellHeight).floor();

    if (row < 0 || row >= level.gridRows || col < 0 || col >= level.gridCols) {
      return null;
    }

    return CellPosition(row, col);
  }

  /// Get the center position of a cell in world coordinates
  Vector2 getCellCenter(int row, int col) {
    return Vector2(
      col * cellWidth + cellWidth / 2,
      row * cellHeight + cellHeight / 2,
    );
  }

  /// Mark a cell as visited
  void markCellVisited(int row, int col) {
    final cell = getCell(row, col);
    cell?.setVisited(true);
  }

  /// Reset all visited cells
  void resetVisitedCells() {
    for (final cell in cells.values) {
      cell.setVisited(false);
    }
  }

  /// Check if position is on a wall (non-path cell)
  bool isWall(Vector2 position) {
    final gridPos = worldToGrid(position);
    if (gridPos == null) return true; // Out of bounds is a wall

    final cell = getCell(gridPos.row, gridPos.col);
    return cell != null && !cell.isPath;
  }

  /// Get boundaries for ball collision
  Rect getBounds() {
    return Rect.fromLTWH(0, 0, boardSize.x, boardSize.y);
  }
}
