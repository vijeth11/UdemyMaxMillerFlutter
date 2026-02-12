import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'controllers/game_state_controller.dart';
import 'controllers/audio_controller.dart';
import 'services/storage_service.dart';
import 'services/audio_service.dart';
import 'screens/main_menu_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock orientation to landscape
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // Initialize services
  final storageService = StorageService();
  await storageService.init();
  
  final audioService = AudioService();
  await audioService.init(
    bgMusicEnabled: storageService.isBGMusicEnabled(),
    sfxEnabled: storageService.isSFXEnabled(),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => GameStateController(storageService),
        ),
        ChangeNotifierProvider(
          create: (_) => AudioController(audioService, storageService),
        ),
      ],
      child: const TiltPathMasterApp(),
    ),
  );
}

class TiltPathMasterApp extends StatelessWidget {
  const TiltPathMasterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tilt Path Master',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        fontFamily: 'Roboto',
      ),
      home: const MainMenuScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
