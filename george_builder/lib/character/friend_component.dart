import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:george_builder/character/george_component.dart';
import 'package:george_builder/my_george_game.dart';

class FriendComponent extends PositionComponent
    with CollisionCallbacks, HasGameRef<MyGeorgeGame> {
  FriendComponent() {
    var hitbox = RectangleHitbox();
    add(hitbox);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is GeorgeComponent) {
      var message = '';
      if (gameRef.bakedGroupInventory.value > 0) {
        message = "Wow. Thanks so much. Please come over"
            " this weekend for dinner. I have to run now."
            " See you on Saturday at 7pm.";
        gameRef.friendNumber.value++;
        gameRef.bakedGroupInventory.value--;
        gameRef.applause.start();
        //if (gameRef.maxFriends == gameRef.friendNumber.value) {
        gameRef.sceneNumber++;
        gameRef.newScene();
        //}
      } else {
        message = 'Greate to meet you, I have to run to a meeting.';
      }
      gameRef.addDialog(message);
      gameRef.remove(this);
    }
    super.onCollision(intersectionPoints, other);
  }
}
