/// File: enemy.dart
///
/// Deskripsi:
///   File ini berisi definisi kelas [Enemy] yang mewakili karakter musuh
///   dalam dunia permainan menggunakan game engine Flame. Musuh ini adalah
///   bagian dari proyek yang menggabungkan Flame, Hive untuk database lokal,
///   dan GetX untuk manajemen state.
///
/// Import:
///   - 'package:flame/collisions.dart': Import Flame untuk mendukung deteksi tabrakan.
///   - 'package:flame/components.dart': Import Flame untuk komponen-komponen game.
///
/// Class:
///   - 'Enemy': Kelas ini mewakili musuh dalam dunia permainan. Menggunakan
///     Flame SpriteAnimationComponent untuk animasi, Flame CollisionCallbacks
///     untuk deteksi tabrakan, dan Flame HasGameReference untuk referensi ke game.
///
library;
import 'package:flame/collisions.dart'; // Deteksi tabrakan Flame.
import 'package:flame/components.dart'; // Komponen-komponen game Flame.

import '../models/enemy_data.dart'; // Import model data musuh.
import 'dedes_run.dart'; // Import objek game DedesRun.

// Ini mewakili musuh dalam dunia permainan.
class Enemy extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameReference<DedesRun> {
  // Data yang diperlukan untuk pembuatan musuh ini.
  final EnemyData enemyData;

  /// Konstruktor untuk membuat objek musuh.
  Enemy(this.enemyData) {
    // Membuat animasi musuh berdasarkan data yang diberikan.
    animation = SpriteAnimation.fromFrameData(
      enemyData.image,
      SpriteAnimationData.sequenced(
        amount: enemyData.nFrames,
        stepTime: enemyData.stepTime,
        textureSize: enemyData.textureSize,
      ),
    );
  }

  @override
  void onMount() {
    // Mengurangi ukuran musuh karena terlihat terlalu besar
    // dibandingkan dengan karakter utama.
    size *= 0.6;

    // Menambahkan hitbox untuk musuh ini.
    add(
      RectangleHitbox.relative(
        Vector2.all(0.8),
        parentSize: size,
        position: Vector2(size.x * 0.2, size.y * 0.2) / 2,
      ),
    );
    super.onMount();
  }

  @override
  void update(double dt) {
    // Menggerakkan posisi musuh ke kiri berdasarkan speedX.
    position.x -= enemyData.speedX * dt;

    // Menghapus musuh dan meningkatkan skor pemain
    // sebanyak 1 jika musuh telah melewati ujung kiri layar.
    if (position.x < -enemyData.textureSize.x) {
      removeFromParent();
      game.playerData.currentScore += 1;
    }

    super.update(dt);
  }
}
