class TileDetail {
  final String title;
  final int itemCount;
  final String svgfile;

  TileDetail(this.title, this.itemCount, this.svgfile);
}


final List<TileDetail> categoryTiles = [
    TileDetail('Fruits', 87, "assets/images/grapes.svg"),
    TileDetail('Vegetables', 24, 'assets/images/leaf.svg'),
    TileDetail('Mushroom', 43, 'assets/images/mushroom.svg'),
    TileDetail('Diary', 22, 'assets/images/diary.svg'),
    TileDetail('Oats', 64, 'assets/images/oats.svg'),
    TileDetail('Bread', 43, 'assets/images/bread.svg'),
  ];