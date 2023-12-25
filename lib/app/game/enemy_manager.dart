import 'dart:math';

import 'package:flame/components.dart';

import '../models/enemy_data.dart';
import 'dedes_run.dart';
import 'enemy.dart';

// Kelas ini bertanggung jawab untuk membuat musuh secara acak pada
// interval waktu tertentu tergantung pada skor pemain saat ini.
class EnemyManager extends Component with HasGameReference<DedesRun> {
  // Sebuah list untuk menyimpan data musuh-musuh.
  final List<EnemyData> _data = [];

  // Generator acak diperlukan untuk memilih tipe musuh secara acak.
  final Random _random = Random();

  // Timer untuk menentukan kapan musuh selanjutnya akan muncul.
  final Timer _timer = Timer(2, repeat: true);

  EnemyManager() {
    _timer.onTick = spawnRandomEnemy;
  }

  // Metode ini bertanggung jawab untuk membuat musuh secara acak.
  void spawnRandomEnemy() {
    /// Menghasilkan indeks acak dalam [_data] dan mendapatkan [EnemyData].
    final randomIndex = _random.nextInt(_data.length);
    final enemyData = _data.elementAt(randomIndex);
    final enemy = Enemy(enemyData);

    // Membantu menetapkan semua musuh di tanah.
    enemy.anchor = Anchor.bottomLeft;
    enemy.position = Vector2(
      game.virtualSize.x + 32,
      game.virtualSize.y - 24,
    );

    // Jika musuh ini bisa terbang, atur posisi y-nya secara acak.
    if (enemyData.canFly) {
      final newHeight = _random.nextDouble() * 2 * enemyData.textureSize.y;
      enemy.position.y -= newHeight;
    }

    // Karena ukuran viewport kita, kita dapat
    // menggunakan textureSize sebagai ukuran komponen.
    enemy.size = enemyData.textureSize;
    game.world.add(enemy);
  }

  @override
  void onMount() {
    if (isMounted) {
      removeFromParent();
    }

    // Jangan isi list lagi dan lagi setiap kali dipasang.
    if (_data.isEmpty) {
      // Begitu komponen ini dipasang, inisialisasikan semua data.
      _data.addAll([
        EnemyData(
          image: game.images.fromCache('AngryPig/Walk (36x30).png'),
          nFrames: 16,
          stepTime: 0.1,
          textureSize: Vector2(36, 30),
          speedX: 80,
          canFly: false,
        ),
        EnemyData(
          image: game.images.fromCache('Bat/Flying (46x30).png'),
          nFrames: 7,
          stepTime: 0.1,
          textureSize: Vector2(46, 30),
          speedX: 100,
          canFly: true,
        ),
        EnemyData(
          image: game.images.fromCache('Rino/Run (52x34).png'),
          nFrames: 6,
          stepTime: 0.09,
          textureSize: Vector2(52, 34),
          speedX: 150,
          canFly: false,
        ),
      ]);
    }
    _timer.start();
    super.onMount();
  }

  @override
  void update(double dt) {
    _timer.update(dt);
    super.update(dt);
  }

  void removeAllEnemies() {
    final enemies = game.world.children.whereType<Enemy>();
    for (var enemy in enemies) {
      enemy.removeFromParent();
    }
  }
}
