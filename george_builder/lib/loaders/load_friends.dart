
import 'package:flame/components.dart';
import 'package:george_builder/character/friend_component.dart';
import 'package:tiled/tiled.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:george_builder/my_george_game.dart';


loadFriends(TiledComponent homeMap, MyGeorgeGame game){
  final friendGroup = homeMap.tileMap.getLayer<ObjectGroup>('Friends');
    for (TiledObject friendBox in friendGroup?.objects ?? []) {
      final friend = FriendComponent()
        ..position = Vector2(friendBox.x, friendBox.y)
        ..width = friendBox.width
        ..height = friendBox.height
        ..debugMode = true;
      game.add(friend);
    }
}