/// File: main.dart
///
/// Deskripsi:
///   File ini adalah titik masuk utama untuk aplikasi "Dedes Run" yang dibangun dengan Flutter dan Flame.
///   Aplikasi ini menggunakan game engine Flame, database Hive, dan state management GetX.
///

// Import beberapa pustaka yang diperlukan
import 'package:flame/camera.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:hive_flutter/hive_flutter.dart';

// Import file-file yang dibutuhkan dari aplikasi
import 'app/controllers/dedes_run.dart';
import 'app/models/player_data.dart';
import 'app/models/settings.dart';
import 'app/widgets/game_over_menu.dart';
import 'app/widgets/hud.dart';
import 'app/widgets/main_menu.dart';
import 'app/widgets/pause_menu.dart';
import 'app/widgets/settings_menu.dart';

// Fungsi main() yang dijalankan pertama kali saat aplikasi dimulai
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Hive untuk penggunaan database lokal
  await initHive();

  // Menjalankan aplikasi utama DedesRunApp
  runApp(const DedesRunApp());
}

// Fungsi untuk inisialisasi Hive
Future<void> initHive() async {
  await Hive.initFlutter(); // Menggunakan initFlutter() dari hive_flutter

  // Mendaftarkan adapter untuk mengonversi objek PlayerData dan Settings ke dalam bentuk Hive
  Hive.registerAdapter<PlayerData>(PlayerDataAdapter());
  Hive.registerAdapter<Settings>(SettingsAdapter());
}

// Kelas DedesRunApp sebagai root dari aplikasi Flutter
class DedesRunApp extends StatelessWidget {
  const DedesRunApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Menggunakan GetMaterialApp untuk memanfaatkan fitur GetX
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
          // Widget GameWidget digunakan untuk menampilkan game engine Flame dalam Flutter
          loadingBuilder: (context) => const Center(
            child: SizedBox(
              width: 200,
              child:
                  CircularProgressIndicator(), // Menampilkan indikator loading saat inisialisasi game
            ),
          ),
          overlayBuilderMap: {
            // Peta overlay yang menyediakan instance widget untuk setiap overlay yang mungkin muncul
            MainMenu.id: (_, game) => MainMenu(game),
            PauseMenu.id: (_, game) => PauseMenu(game),
            Hud.id: (_, game) => Hud(game),
            GameOverMenu.id: (_, game) => GameOverMenu(game),
            SettingsMenu.id: (_, game) => SettingsMenu(game),
          },
          initialActiveOverlays: const [
            MainMenu.id
          ], // Overlay yang ditampilkan saat aplikasi pertama kali dimulai
          gameFactory: () => DedesRun(
            camera: CameraComponent.withFixedResolution(
              width: 360,
              height: 180,
            ),
          ), // Fungsi pembuat game (gameFactory) untuk membuat instance DedesRun
        ),
      ),
    );
  }
}
