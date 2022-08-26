import 'package:charlie_chicken/actors/level.dart';
import 'package:charlie_chicken/game.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_audio/flame_audio.dart';

class CheckPoint extends SpriteAnimationComponent
    with HasGameRef<CharliChickenGame>, ParentIsA<Level> {
  late SpriteAnimation idel;
  late SpriteAnimation flagOut;
  late AudioPool endOfGame;

  CheckPoint({required Vector2 size, required Vector2 position})
      : super(size: size, position: position);

  @override
  Future<void>? onLoad() async {
    endOfGame = await AudioPool.create('audio/sfx/gamewon.mp3', maxPlayers: 1);
    var idelSheet = SpriteSheet(
        image: Flame.images.fromCache(
          'world/Checkpoint.png',
        ),
        srcSize: Vector2.all(64));
    idel = idelSheet.createAnimation(row: 0, stepTime: 0.1, to: 1, from: 0);

    var flagSheet = SpriteSheet(
        image: Flame.images.fromCache(
          'world/CheckpointFlagOut.png',
        ),
        srcSize: Vector2.all(64));
    flagOut = flagSheet.createAnimation(
        row: 0, stepTime: 0.1, to: 26, from: 0, loop: false)
      ..onComplete = () {
        parent.displaFlagOver = true;
        parent.gameOver();
      };
    animation = idel;

    parent.gameOverFlag.addListener(loadFlag);
    return super.onLoad();
  }

  void loadFlag() {
    if (gameRef.gameOver && gameRef.lifeLeft > 0) {
      FlameAudio.bgm.stop();
      endOfGame.start(volume: 0.8);
      animation = flagOut;
    }
  }

  @override
  void onRemove() {
    parent.gameOverFlag.removeListener(loadFlag);
    super.onRemove();
  }
}
