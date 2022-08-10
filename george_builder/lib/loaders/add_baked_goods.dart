import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:george_builder/character/baked_good_component.dart';
import 'package:george_builder/my_george_game.dart';
import 'package:tiled/tiled.dart';

void addBakedGoods(TiledComponent homeMap, MyGeorgeGame game) {
  final bakedGoodGroup = homeMap.tileMap.getLayer<ObjectGroup>('BakedGoods');
  for (TiledObject bakedGood in bakedGoodGroup?.objects ?? []) {
    if (bakedGood.class_.isNotEmpty) {
      game.add(BakedComponent()
        ..sprite = Sprite(Flame.images.fromCache('${bakedGood.class_}.png'))
        ..position = Vector2(bakedGood.x, bakedGood.y)
        ..anchor = Anchor.bottomLeft
        ..size = Vector2(bakedGood.width, bakedGood.height));
    }
  }
}
