import 'dart:ui';
import 'level.dart';

/// Hardcoded level definitions for the game
class LevelDefinitions {
  static List<Level> getAllLevels() {
    return [
      _createLevel1(),
      _createLevel2(),
      _createLevel3(),
      _createLevel4(),
      _createLevel5(),
    ];
  }

  static Level getLevel(int levelNumber) {
    final levels = getAllLevels();
    if (levelNumber < 1 || levelNumber > levels.length) {
      return levels[0]; // Return level 1 if invalid
    }
    return levels[levelNumber - 1];
  }

  static int get totalLevels => getAllLevels().length;

  /// Level 1: Simple L-shaped path with 2 pits
  static Level _createLevel1() {
    const gridRows = 8;
    const gridCols = 12;

    // Create an L-shaped path from top-left to bottom-right
    final pathCells = <CellPosition>[
      // Start at top-left corner
      const CellPosition(1, 1),
      const CellPosition(1, 2),
      const CellPosition(1, 3),
      const CellPosition(1, 4),
      const CellPosition(1, 5),
      // Turn down
      const CellPosition(2, 5),
      const CellPosition(3, 5),
      const CellPosition(4, 5),
      const CellPosition(5, 5),
      const CellPosition(6, 5),
      // Turn right to goal
      const CellPosition(6, 6),
      const CellPosition(6, 7),
      const CellPosition(6, 8),
      const CellPosition(6, 9),
      const CellPosition(6, 10), // Goal
    ];

    final pitCells = <CellPosition>[
      const CellPosition(1, 3), // Pit in horizontal section
      const CellPosition(4, 5), // Pit in vertical section
    ];

    final walls = _generateWallsForPath(pathCells, gridRows, gridCols);

    return Level(
      levelNumber: 1,
      gridRows: gridRows,
      gridCols: gridCols,
      startCell: pathCells.first,
      goalCell: pathCells.last,
      pathCells: pathCells,
      pitCells: pitCells,
      walls: walls,
    );
  }

  /// Level 2: S-shaped path with 3 pits
  static Level _createLevel2() {
    const gridRows = 10;
    const gridCols = 14;

    final pathCells = <CellPosition>[
      // Start at top-right
      const CellPosition(1, 12),
      const CellPosition(1, 11),
      const CellPosition(1, 10),
      const CellPosition(1, 9),
      // Turn down
      const CellPosition(2, 9),
      const CellPosition(3, 9),
      const CellPosition(4, 9),
      const CellPosition(5, 9),
      // Turn left
      const CellPosition(5, 8),
      const CellPosition(5, 7),
      const CellPosition(5, 6),
      const CellPosition(5, 5),
      // Turn down again
      const CellPosition(6, 5),
      const CellPosition(7, 5),
      const CellPosition(8, 5),
      // Turn right to goal
      const CellPosition(8, 6),
      const CellPosition(8, 7),
      const CellPosition(8, 8),
      const CellPosition(8, 9), // Goal
    ];

    final pitCells = <CellPosition>[
      const CellPosition(1, 10),
      const CellPosition(5, 7),
      const CellPosition(7, 5),
    ];

    final walls = _generateWallsForPath(pathCells, gridRows, gridCols);

    return Level(
      levelNumber: 2,
      gridRows: gridRows,
      gridCols: gridCols,
      startCell: pathCells.first,
      goalCell: pathCells.last,
      pathCells: pathCells,
      pitCells: pitCells,
      walls: walls,
    );
  }

  /// Level 3: Zigzag path with 4 pits
  static Level _createLevel3() {
    const gridRows = 10;
    const gridCols = 15;

    final pathCells = <CellPosition>[
      // Start bottom-left
      const CellPosition(8, 1),
      const CellPosition(8, 2),
      const CellPosition(8, 3),
      const CellPosition(8, 4),
      // Up
      const CellPosition(7, 4),
      const CellPosition(6, 4),
      const CellPosition(5, 4),
      // Right
      const CellPosition(5, 5),
      const CellPosition(5, 6),
      const CellPosition(5, 7),
      // Down
      const CellPosition(6, 7),
      const CellPosition(7, 7),
      const CellPosition(8, 7),
      // Right
      const CellPosition(8, 8),
      const CellPosition(8, 9),
      const CellPosition(8, 10),
      // Up to goal
      const CellPosition(7, 10),
      const CellPosition(6, 10),
      const CellPosition(5, 10),
      const CellPosition(4, 10),
      const CellPosition(3, 10), // Goal
    ];

    final pitCells = <CellPosition>[
      const CellPosition(8, 2),
      const CellPosition(6, 4),
      const CellPosition(7, 7),
      const CellPosition(5, 10),
    ];

    final walls = _generateWallsForPath(pathCells, gridRows, gridCols);

    return Level(
      levelNumber: 3,
      gridRows: gridRows,
      gridCols: gridCols,
      startCell: pathCells.first,
      goalCell: pathCells.last,
      pathCells: pathCells,
      pitCells: pitCells,
      walls: walls,
    );
  }

  /// Level 4: Spiral path with 5 pits
  static Level _createLevel4() {
    const gridRows = 12;
    const gridCols = 16;

    final pathCells = <CellPosition>[
      // Outer ring - start top-left
      const CellPosition(2, 2),
      const CellPosition(2, 3),
      const CellPosition(2, 4),
      const CellPosition(2, 5),
      const CellPosition(2, 6),
      // Down right side
      const CellPosition(3, 6),
      const CellPosition(4, 6),
      const CellPosition(5, 6),
      const CellPosition(6, 6),
      const CellPosition(7, 6),
      // Left along bottom
      const CellPosition(7, 5),
      const CellPosition(7, 4),
      const CellPosition(7, 3),
      const CellPosition(7, 2),
      // Up left side
      const CellPosition(6, 2),
      const CellPosition(5, 2),
      const CellPosition(4, 2),
      // Inner spiral
      const CellPosition(4, 3),
      const CellPosition(4, 4),
      const CellPosition(5, 4),
      const CellPosition(5, 3), // Goal in center
    ];

    final pitCells = <CellPosition>[
      const CellPosition(2, 4),
      const CellPosition(5, 6),
      const CellPosition(7, 4),
      const CellPosition(5, 2),
      const CellPosition(4, 3),
    ];

    final walls = _generateWallsForPath(pathCells, gridRows, gridCols);

    return Level(
      levelNumber: 4,
      gridRows: gridRows,
      gridCols: gridCols,
      startCell: pathCells.first,
      goalCell: pathCells.last,
      pathCells: pathCells,
      pitCells: pitCells,
      walls: walls,
    );
  }

  /// Level 5: Complex maze with 6 pits
  static Level _createLevel5() {
    const gridRows = 12;
    const gridCols = 18;

    final pathCells = <CellPosition>[
      // Start bottom-right
      const CellPosition(10, 16),
      const CellPosition(10, 15),
      const CellPosition(10, 14),
      const CellPosition(9, 14),
      const CellPosition(8, 14),
      const CellPosition(7, 14),
      const CellPosition(7, 13),
      const CellPosition(7, 12),
      const CellPosition(7, 11),
      const CellPosition(6, 11),
      const CellPosition(5, 11),
      const CellPosition(4, 11),
      const CellPosition(4, 10),
      const CellPosition(4, 9),
      const CellPosition(5, 9),
      const CellPosition(6, 9),
      const CellPosition(7, 9),
      const CellPosition(8, 9),
      const CellPosition(8, 8),
      const CellPosition(8, 7),
      const CellPosition(7, 7),
      const CellPosition(6, 7),
      const CellPosition(5, 7),
      const CellPosition(4, 7),
      const CellPosition(3, 7),
      const CellPosition(2, 7),
      const CellPosition(2, 6),
      const CellPosition(2, 5), // Goal top-left area
    ];

    final pitCells = <CellPosition>[
      const CellPosition(10, 15),
      const CellPosition(8, 14),
      const CellPosition(5, 11),
      const CellPosition(6, 9),
      const CellPosition(7, 7),
      const CellPosition(3, 7),
    ];

    final walls = _generateWallsForPath(pathCells, gridRows, gridCols);

    return Level(
      levelNumber: 5,
      gridRows: gridRows,
      gridCols: gridCols,
      startCell: pathCells.first,
      goalCell: pathCells.last,
      pathCells: pathCells,
      pitCells: pitCells,
      walls: walls,
    );
  }

  /// Helper method to generate walls along the path
  /// This creates boundaries on both sides of the path
  static List<WallSegment> _generateWallsForPath(
    List<CellPosition> pathCells,
    int gridRows,
    int gridCols,
  ) {
    // For now, return empty list
    // Walls will be rendered based on whether adjacent cells are on the path
    return [];
  }
}
