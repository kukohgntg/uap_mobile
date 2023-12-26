import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../models/enemy_data.dart';
import 'dedes_run.dart';

// Ini mewakili musuh dalam dunia permainan.
class Enemy extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameReference<DedesRun> {
  // Data yang diperlukan untuk pembuatan musuh ini.
  final EnemyData enemyData;

  Enemy(this.enemyData) {
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
