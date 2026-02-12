import 'dart:ui';

/// Represents a single level in the game
class Level {
  final int levelNumber;
  final int gridRows;
  final int gridCols;
  final CellPosition startCell;
  final CellPosition goalCell;
  final List<CellPosition> pathCells;
  final List<CellPosition> pitCells;
  final List<WallSegment> walls;

  Level({
    required this.levelNumber,
    required this.gridRows,
    required this.gridCols,
    required this.startCell,
    required this.goalCell,
    required this.pathCells,
    required this.pitCells,
    required this.walls,
  });

  /// Get the point value for a specific cell
  int getPointValue(CellPosition cell) {
    final index = pathCells.indexWhere(
      (c) => c.row == cell.row && c.col == cell.col,
    );
    return index >= 0 ? index + 1 : 0;
  }

  /// Check if a cell is on the path
  bool isOnPath(CellPosition cell) {
    return pathCells.any((c) => c.row == cell.row && c.col == cell.col);
  }

  /// Check if a cell is a pit
  bool isPit(CellPosition cell) {
    return pitCells.any((c) => c.row == cell.row && c.col == cell.col);
  }

  /// Check if a cell is the goal
  bool isGoal(CellPosition cell) {
    return cell.row == goalCell.row && cell.col == goalCell.col;
  }

  /// Check if a cell is the start
  bool isStart(CellPosition cell) {
    return cell.row == startCell.row && cell.col == startCell.col;
  }
}

/// Represents a position in the grid
class CellPosition {
  final int row;
  final int col;

  const CellPosition(this.row, this.col);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CellPosition && other.row == row && other.col == col;
  }

  @override
  int get hashCode => row.hashCode ^ col.hashCode;

  @override
  String toString() => 'CellPosition($row, $col)';
}

/// Represents a wall segment on the game board
class WallSegment {
  final Offset start;
  final Offset end;

  WallSegment(this.start, this.end);
}
