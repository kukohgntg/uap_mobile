// ignore_for_file: use_key_in_widget_constructors

import 'package:flame/camera.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:hive_flutter/hive_flutter.dart';

import 'app/game/dedes_run.dart';
import 'app/models/player_data.dart';
import 'app/models/settings.dart';
import 'app/widgets/game_over_menu.dart';
import 'app/widgets/hud.dart';
import 'app/widgets/main_menu.dart';
import 'app/widgets/pause_menu.dart';
import 'app/widgets/settings_menu.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initHive();
  runApp(const DedesRunApp());
}

Future<void> initHive() async {
  await Hive.initFlutter(); // Menggunakan initFlutter() dari hive_flutter

  Hive.registerAdapter<PlayerData>(PlayerDataAdapter());
  Hive.registerAdapter<Settings>(SettingsAdapter());
}

class DedesRunApp extends StatelessWidget {
  const DedesRunApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Menggunakan GetMaterialApp
      debugShowCheckedModeBanner: false,
      title: 'Dedes Run',
      theme: ThemeData(
        fontFamily: 'Audiowide',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            fixedSize: const Size(200, 60),
          ),
        ),
      ),
      home: Scaffold(
        body: GameWidget<DedesRun>.controlled(
          loadingBuilder: (context) => const Center(
            child: SizedBox(
              width: 200,
              child:
                  CircularProgressIndicator(), // Menggunakan CircularProgressIndicator
            ),
          ),
          overlayBuilderMap: {
            MainMenu.id: (_, game) => MainMenu(game),
            PauseMenu.id: (_, game) => PauseMenu(game),
            Hud.id: (_, game) => Hud(game),
            GameOverMenu.id: (_, game) => GameOverMenu(game),
            SettingsMenu.id: (_, game) => SettingsMenu(game),
          },
          initialActiveOverlays: const [MainMenu.id],
          gameFactory: () => DedesRun(
            camera: CameraComponent.withFixedResolution(
              width: 360,
              height: 180,
            ),
          ),
        ),
      ),
    );
  }
}
