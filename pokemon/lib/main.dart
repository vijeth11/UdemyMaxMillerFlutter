import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

import 'game_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon',
      debugShowCheckedModeBanner: false,
      home: GamePage(),
    );
  }
}
