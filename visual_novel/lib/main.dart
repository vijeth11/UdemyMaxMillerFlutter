import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: GameWidget(game: MyGame()),
      ),
    );
  }
}

class MyGame extends FlameGame with HasTappables {
  SpriteComponent girl = SpriteComponent();
  SpriteComponent boy = SpriteComponent();
  SpriteComponent background = SpriteComponent();
  DialogButton dialogButton = DialogButton();
  final double characterSize = 200;
  bool turnAway = false;
  TextPaint dialogText = TextPaint(style: TextStyle(fontSize: 36));
  int dialogLevel = 0;
  final Vector2 buttonSize = Vector2(50.0, 50.0);
  int sceneLevel = 1;

  @override
  Future<void>? onLoad() async {
    final screenWidth = size[0];
    final screenHeight = size[1];
    final textBoxHeight = 100;

    await Flame.images.loadAll(['castle.jpg', 'battle.jpg']);
    background
      ..sprite = await loadSprite('background.png')
      ..size = Vector2(screenWidth, screenHeight - textBoxHeight);
    add(background);

    girl
      ..sprite = await loadSprite('girl.png')
      ..size = Vector2(characterSize, characterSize)
      ..y = screenHeight - characterSize - textBoxHeight
      ..anchor = Anchor.topCenter;

    add(girl);

    boy
      ..sprite = await loadSprite('boy.png')
      ..size = Vector2(characterSize, characterSize)
      ..y = screenHeight - characterSize - textBoxHeight
      ..x = screenWidth - characterSize
      ..anchor = Anchor.topCenter
      ..flipHorizontally();

    add(boy);

    dialogButton
      ..sprite = await loadSprite('next_button.png')
      ..x = screenWidth - buttonSize[0] - 10
      ..y = screenHeight - buttonSize[1] - 10
      ..size = buttonSize;

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (girl.x < size[0] / 2 - 100) {
      girl.x += 30 * dt;
      if (girl.x > 50 && dialogLevel == 0) {
        dialogLevel++;
      }
      if (girl.x > 150 && dialogLevel == 1) {
        dialogLevel++;
      }
    } else if (turnAway == false && sceneLevel == 1) {
      boy.flipHorizontally();
      turnAway = true;
      if (dialogLevel == 2) {
        dialogLevel++;
      }
    }

    if (boy.x > size[0] / 2 - 50 && sceneLevel == 1) {
      boy.x -= 30 * dt;
    }
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    switch (dialogLevel) {
      case 1:
        dialogText.render(canvas, 'Keiko: Ken, don\'t go... you\'ll die',
            Vector2(10, size[1] - 100));
        break;
      case 2:
        dialogText.render(canvas, 'Ken: I must fight for our village',
            Vector2(10, size[1] - 100));
        break;
      case 3:
        dialogText.render(
            canvas, 'Keiko: What about our child?', Vector2(10, size[1] - 100));
        if (!children.any((element) => element == dialogButton)) {
          add(dialogButton);
        }
        break;
    }
    switch (dialogButton.screen2Level) {
      case 1:
        sceneLevel = 2;
        canvas.drawRect(Rect.fromLTWH(0, size[1] - 100, size[0] - 60, 100),
            Paint()..color = Colors.black);
        dialogText.render(
            canvas, 'Ken: Child? I did not know', Vector2(10, size[1] - 100));
        if (turnAway) {
          boy.flipHorizontally();
          boy.x += 150;
          turnAway = false;
          // change scene background
          background.sprite = Sprite(images.fromCache('castle.jpg'));
        }
        break;
      case 2:
        canvas.drawRect(Rect.fromLTWH(0, size[1] - 100, size[0] - 60, 100),
            Paint()..color = Colors.black);
        dialogText.render(canvas, 'Keiko: Our child. Our future.',
            Vector2(10, size[1] - 100));
        break;
      case 3:
        canvas.drawRect(Rect.fromLTWH(0, size[1] - 100, size[0] - 60, 100),
            Paint()..color = Colors.black);
        dialogText.render(canvas, 'Ken: My future will be through you.',
            Vector2(10, size[1] - 100));
        break;
    }
    super.render(canvas);
  }
}

class DialogButton extends SpriteComponent with Tappable {
  int screen2Level = 0;
  @override
  bool onTapDown(TapDownInfo info) {
    screen2Level++;
    return super.onTapDown(info);
  }
}
