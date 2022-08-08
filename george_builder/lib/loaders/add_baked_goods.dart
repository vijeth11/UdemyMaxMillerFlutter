import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:george_builder/character/baked_good_component.dart';
import 'package:george_builder/main.dart';
import 'package:tiled/tiled.dart';

void addBakedGoods(TiledComponent homeMap, MyGeorgeGame game) {
  final bakedGoodGroup = homeMap.tileMap.getLayer<ObjectGroup>('baked_goods');
  for (TiledObject bakedGood in bakedGoodGroup?.objects ?? []) {
    if (bakedGood.class_.isNotEmpty) {
      game.add(BakedComponent()
        ..sprite = Sprite(Flame.images.fromCache('${bakedGood.class_}.png'))
        ..position = Vector2(bakedGood.x, bakedGood.y)
        ..size = Vector2(bakedGood.width, bakedGood.height));
    }
  }
}
