class TileDetail {
  final String title;
  final String svgfile;

  TileDetail(this.title, this.svgfile);
}

final List<TileDetail> categoryTiles = [
  TileDetail('Fruits', "assets/images/grapes.svg"),
  TileDetail('Vegetables', 'assets/images/leaf.svg'),
  TileDetail('Condiments', 'assets/images/condiments.svg'),
  TileDetail('Diary', 'assets/images/diary.svg'),
  TileDetail('Cereals', 'assets/images/oats.svg'),
  TileDetail('Bread', 'assets/images/bread.svg'),
];
