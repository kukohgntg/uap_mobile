import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:hive/hive.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';

import '../models/player_data.dart';
import '../models/settings.dart';
import '../widgets/game_over_menu.dart';
import '../widgets/hud.dart';
import '../widgets/pause_menu.dart';
import 'audio_manager.dart';
import 'dedes.dart';
import 'enemy_manager.dart';

// Ini adalah kelas utama permainan Flame.
class DedesRun extends FlameGame with TapDetector, HasCollisionDetection {
  DedesRun({super.camera});

  // Daftar semua aset gambar.
  static const _imageAssets = [
    'main char.png',
    'AngryPig/Walk (36x30).png',
    'Bat/Flying (46x30).png',
    'Rino/Run (52x34).png',
    'jgl-temple-v3/solid-colour.png',
    'jgl-temple-v3/candi.png',
    'jgl-temple-v3/tree3.png',
    'jgl-temple-v3/bush4.png',
    'jgl-temple-v3/bush3.png',
    'jgl-temple-v3/tree2.png',
    'jgl-temple-v3/bush2.png',
    'jgl-temple-v3/tree1.png',
    'jgl-temple-v3/ground.png',
    'jgl-temple-v3/bush.png',
  ];

  // Daftar semua aset audio.
  static const _audioAssets = [
    '8BitPlatformerLoop.wav',
    'hurt7.wav',
    'jump14.wav',
  ];

  late Dedes _dedes;
  late Settings settings;
  late PlayerData playerData;
  late EnemyManager _enemyManager;

  Vector2 get virtualSize => camera.viewport.virtualSize;

  // Metode ini dipanggil saat Flame mempersiapkan permainan ini.
  @override
  Future<void> onLoad() async {
    // Mengatur permainan menjadi layar penuh dan hanya mode landscape.
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();

    /// Membaca [PlayerData] dan [Settings] dari hive.
    playerData = await _readPlayerData();
    settings = await _readSettings();

    /// Menginisialisasi [AudioManager].
    await AudioManager.instance.init(_audioAssets, settings);

    // Mulai memutar musik latar belakang.
    AudioManager.instance.startBgm('8BitPlatformerLoop.wav');

    // Cache semua gambar.
    await images.loadAll(_imageAssets);

    // Ini membuat kamera fokus pada tengah tampilan.
    camera.viewfinder.position = camera.viewport.virtualSize * 0.5;

    /// Membuat [ParallaxComponent] dan menambahkannya ke permainan.
    final parallaxBackground = await loadParallaxComponent(
      [
        ParallaxImageData('jgl-temple-v3/solid-colour.png'),
        ParallaxImageData('jgl-temple-v3/candi.png'),
        ParallaxImageData('jgl-temple-v3/tree3.png'),
        ParallaxImageData('jgl-temple-v3/bush4.png'),
        ParallaxImageData('jgl-temple-v3/bush3.png'),
        ParallaxImageData('jgl-temple-v3/tree2.png'),
        ParallaxImageData('jgl-temple-v3/bush2.png'),
        ParallaxImageData('jgl-temple-v3/tree1.png'),
        ParallaxImageData('jgl-temple-v3/ground.png'),
        ParallaxImageData('jgl-temple-v3/bush.png'),
      ],
      baseVelocity: Vector2(10, 0),
      velocityMultiplierDelta: Vector2(1.2, 0),
    );

    // Menambahkan parallax sebagai latar belakang.
    camera.backdrop.add(parallaxBackground);
  }

  /// Metode ini menambahkan [Dedes] yang sudah dibuat
  /// dan [EnemyManager] ke permainan ini.
  void startGamePlay() {
    _dedes = Dedes(images.fromCache('main char.png'), playerData);
    _enemyManager = EnemyManager();

    world.add(_dedes);
    world.add(_enemyManager);
  }

  // Metode ini menghapus semua aktor dari permainan.
  void _disconnectActors() {
    _dedes.removeFromParent();
    _enemyManager.removeAllEnemies();
    _enemyManager.removeFromParent();
  }

  // Metode ini mereset seluruh dunia permainan ke keadaan awal.
  void reset() {
    // Pertama-tama putuskan semua aksi dari dunia permainan.
    _disconnectActors();

    // Reset data pemain ke nilai awal.
    playerData.currentScore = 0;
    playerData.lives = 5;
  }

  // Metode ini dipanggil untuk setiap tick/frame dari permainan.
  @override
  void update(double dt) {
    // Jika jumlah nyawa adalah 0 atau kurang, permainan berakhir.
    if (playerData.lives <= 0) {
      overlays.add(GameOverMenu.id);
      overlays.remove(Hud.id);
      pauseEngine();
      AudioManager.instance.pauseBgm();
    }
    super.update(dt);
  }

  // Metode ini dipanggil untuk setiap tap pada layar.
  @override
  void onTapDown(TapDownInfo info) {
    // Membuat dedes melompat hanya saat permainan sedang berlangsung.
    // Saat permainan berlangsung, hanya Hud yang menjadi overlay aktif.
    if (overlays.isActive(Hud.id)) {
      _dedes.jump();
    }
    super.onTapDown(info);
  }

  /// Metode ini membaca [PlayerData] dari kotak hive.
  Future<PlayerData> _readPlayerData() async {
    final playerDataBox =
        await Hive.openBox<PlayerData>('DedesRun.PlayerDataBox');
    final playerData = playerDataBox.get('DedesRun.PlayerData');

    // Jika data null, ini mungkin peluncuran pertama permainan.
    if (playerData == null) {
      // Dalam kasus seperti itu, simpan nilai default di hive.
      await playerDataBox.put('DedesRun.PlayerData', PlayerData());
    }

    // Sekarang aman untuk mengembalikan nilai yang disimpan.
    return playerDataBox.get('DedesRun.PlayerData')!;
  }

  /// Metode ini membaca [Settings] dari kotak hive.
  Future<Settings> _readSettings() async {
    final settingsBox = await Hive.openBox<Settings>('DedesRun.SettingsBox');
    final settings = settingsBox.get('DedesRun.Settings');

    // Jika data null, ini mungkin peluncuran pertama permainan.
    if (settings == null) {
      // Dalam kasus seperti itu, simpan nilai default di hive.
      await settingsBox.put(
        'DedesRun.Settings',
        Settings(bgm: true, sfx: true),
      );
    }

    // Sekarang aman untuk mengembalikan nilai yang disimpan.
    return settingsBox.get('DedesRun.Settings')!;
  }

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        // Saat di-resume, jika overlay aktif bukan PauseMenu,
        // resume engine (biarkan efek parallax bermain).
        if (!(overlays.isActive(PauseMenu.id)) &&
            !(overlays.isActive(GameOverMenu.id))) {
          resumeEngine();
        }
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
        // Jika permainan aktif, maka hapus Hud dan tambahkan PauseMenu
        // sebelum menjeda permainan.
        if (overlays.isActive(Hud.id)) {
          overlays.remove(Hud.id);
          overlays.add(PauseMenu.id);
        }
        pauseEngine();
        break;
    }
    super.lifecycleStateChange(state);
  }
}
