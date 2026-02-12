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
      CellPosition(1, 1),
      CellPosition(1, 2),
      CellPosition(1, 3),
      CellPosition(1, 4),
      CellPosition(1, 5),
      // Turn down
      CellPosition(2, 5),
      CellPosition(3, 5),
      CellPosition(4, 5),
      CellPosition(5, 5),
      CellPosition(6, 5),
      // Turn right to goal
      CellPosition(6, 6),
      CellPosition(6, 7),
      CellPosition(6, 8),
      CellPosition(6, 9),
      CellPosition(6, 10), // Goal
    ];

    final pitCells = <CellPosition>[
      CellPosition(1, 3), // Pit in horizontal section
      CellPosition(4, 5), // Pit in vertical section
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
      CellPosition(1, 12),
      CellPosition(1, 11),
      CellPosition(1, 10),
      CellPosition(1, 9),
      // Turn down
      CellPosition(2, 9),
      CellPosition(3, 9),
      CellPosition(4, 9),
      CellPosition(5, 9),
      // Turn left
      CellPosition(5, 8),
      CellPosition(5, 7),
      CellPosition(5, 6),
      CellPosition(5, 5),
      // Turn down again
      CellPosition(6, 5),
      CellPosition(7, 5),
      CellPosition(8, 5),
      // Turn right to goal
      CellPosition(8, 6),
      CellPosition(8, 7),
      CellPosition(8, 8),
      CellPosition(8, 9), // Goal
    ];

    final pitCells = <CellPosition>[
      CellPosition(1, 10),
      CellPosition(5, 7),
      CellPosition(7, 5),
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
      CellPosition(8, 1),
      CellPosition(8, 2),
      CellPosition(8, 3),
      CellPosition(8, 4),
      // Up
      CellPosition(7, 4),
      CellPosition(6, 4),
      CellPosition(5, 4),
      // Right
      CellPosition(5, 5),
      CellPosition(5, 6),
      CellPosition(5, 7),
      // Down
      CellPosition(6, 7),
      CellPosition(7, 7),
      CellPosition(8, 7),
      // Right
      CellPosition(8, 8),
      CellPosition(8, 9),
      CellPosition(8, 10),
      // Up to goal
      CellPosition(7, 10),
      CellPosition(6, 10),
      CellPosition(5, 10),
      CellPosition(4, 10),
      CellPosition(3, 10), // Goal
    ];

    final pitCells = <CellPosition>[
      CellPosition(8, 2),
      CellPosition(6, 4),
      CellPosition(7, 7),
      CellPosition(5, 10),
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
      CellPosition(2, 2),
      CellPosition(2, 3),
      CellPosition(2, 4),
      CellPosition(2, 5),
      CellPosition(2, 6),
      // Down right side
      CellPosition(3, 6),
      CellPosition(4, 6),
      CellPosition(5, 6),
      CellPosition(6, 6),
      CellPosition(7, 6),
      // Left along bottom
      CellPosition(7, 5),
      CellPosition(7, 4),
      CellPosition(7, 3),
      CellPosition(7, 2),
      // Up left side
      CellPosition(6, 2),
      CellPosition(5, 2),
      CellPosition(4, 2),
      // Inner spiral
      CellPosition(4, 3),
      CellPosition(4, 4),
      CellPosition(5, 4),
      CellPosition(5, 3), // Goal in center
    ];

    final pitCells = <CellPosition>[
      CellPosition(2, 4),
      CellPosition(5, 6),
      CellPosition(7, 4),
      CellPosition(5, 2),
      CellPosition(4, 3),
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
      CellPosition(10, 16),
      CellPosition(10, 15),
      CellPosition(10, 14),
      CellPosition(9, 14),
      CellPosition(8, 14),
      CellPosition(7, 14),
      CellPosition(7, 13),
      CellPosition(7, 12),
      CellPosition(7, 11),
      CellPosition(6, 11),
      CellPosition(5, 11),
      CellPosition(4, 11),
      CellPosition(4, 10),
      CellPosition(4, 9),
      CellPosition(5, 9),
      CellPosition(6, 9),
      CellPosition(7, 9),
      CellPosition(8, 9),
      CellPosition(8, 8),
      CellPosition(8, 7),
      CellPosition(7, 7),
      CellPosition(6, 7),
      CellPosition(5, 7),
      CellPosition(4, 7),
      CellPosition(3, 7),
      CellPosition(2, 7),
      CellPosition(2, 6),
      CellPosition(2, 5), // Goal top-left area
    ];

    final pitCells = <CellPosition>[
      CellPosition(10, 15),
      CellPosition(8, 14),
      CellPosition(5, 11),
      CellPosition(6, 9),
      CellPosition(7, 7),
      CellPosition(3, 7),
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
