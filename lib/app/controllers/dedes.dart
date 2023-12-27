/// File: dedes.dart
///
/// Deskripsi:
///   File ini berisi definisi kelas [Dedes] yang merepresentasikan karakter utama
///   dalam permainan ini. Kelas ini menggunakan animasi sprite dan mengimplementasikan
///   collision callbacks untuk interaksi dengan objek lain dalam permainan.
///
library;

import 'dart:ui'; // Import pustaka dasar UI.
import 'package:flame/collisions.dart'; // Import pustaka Flame untuk collision.
import 'package:flame/components.dart'; // Import komponen-komponen Flame.

import '../models/player_data.dart'; // Import model data pemain.
import 'audio_manager.dart'; // Import manajer audio.
import 'dedes_run.dart'; // Import objek game DedesRun.
import 'enemy.dart'; // Import kelas musuh.

/// Enum ini merepresentasikan keadaan animasi dari [Dedes].
enum DedesAnimationStates {
  idle,
  run,
  kick,
  hit,
  sprint,
}

// Ini merepresentasikan karakter dedes dalam permainan ini.
class Dedes extends SpriteAnimationGroupComponent<DedesAnimationStates>
    with CollisionCallbacks, HasGameReference<DedesRun> {
  // Peta dari semua keadaan animasi dan animasi mereka yang sesuai.
  static final _animationMap = {
    DedesAnimationStates.idle: SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.1,
      textureSize: Vector2.all(24),
    ),
    DedesAnimationStates.run: SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.1,
      textureSize: Vector2.all(24),
      texturePosition: Vector2((4) * 24, 0),
    ),
    DedesAnimationStates.kick: SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.1,
      textureSize: Vector2.all(24),
      texturePosition: Vector2((4 + 6) * 24, 0),
    ),
    DedesAnimationStates.hit: SpriteAnimationData.sequenced(
      amount: 3,
      stepTime: 0.1,
      textureSize: Vector2.all(24),
      texturePosition: Vector2((4 + 6 + 4) * 24, 0),
    ),
    DedesAnimationStates.sprint: SpriteAnimationData.sequenced(
      amount: 7,
      stepTime: 0.1,
      textureSize: Vector2.all(24),
      texturePosition: Vector2((4 + 6 + 4 + 3) * 24, 0),
    ),
  };

  // Jarak maksimum dari atas layar di mana
  // dedes seharusnya tidak pernah pergi. Pada dasarnya tinggi layar - tinggi tanah
  double yMax = 0.0;

  // Kecepatan Y saat ini dari dedes.
  double speedY = 0.0;

  // Mengontrol berapa lama animasi hit akan dimainkan.
  final Timer _hitTimer = Timer(1);

  static const double gravity = 800;

  final PlayerData playerData;

  bool isHit = false;

  Dedes(Image image, this.playerData)
      : super.fromFrameData(image, _animationMap);

  @override
  void onMount() {
    // Pertama-tama, reset semua properti penting, karena onMount()
    // akan dipanggil bahkan ketika me-restart permainan.
    _reset();

    // Tambahkan hitbox untuk dedes.
    add(
      RectangleHitbox.relative(
        Vector2(0.5, 0.7),
        parentSize: size,
        position: Vector2(size.x * 0.5, size.y * 0.3) / 2,
      ),
    );
    yMax = y;

    /// Tetapkan callback untuk [_hitTimer].
    _hitTimer.onTick = () {
      current = DedesAnimationStates.run;
      isHit = false;
    };

    super.onMount();
  }

  @override
  void update(double dt) {
    // v = u + at
    speedY += gravity * dt;

    // d = s0 + s * t
    y += speedY * dt;

    /// Kode ini memastikan bahwa dedes tidak pernah melewati [yMax].
    if (isOnGround) {
      y = yMax;
      speedY = 0.0;
      if ((current != DedesAnimationStates.hit) &&
          (current != DedesAnimationStates.run)) {
        current = DedesAnimationStates.run;
      }
    }

    _hitTimer.update(dt);
    super.update(dt);
  }

  // Dipanggil ketika dedes bertabrakan dengan Collidable lain.
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // Panggil hit hanya jika komponen lain adalah Enemy dan dedes
    // belum berada dalam keadaan hit.
    if ((other is Enemy) && (!isHit)) {
      hit();
    }
    super.onCollision(intersectionPoints, other);
  }

  // Mengembalikan true jika dedes berada di tanah.
  bool get isOnGround => (y >= yMax);

  // Membuat dedes loncat.
  void jump() {
    // Loncat hanya jika dedes berada di tanah.
    if (isOnGround) {
      speedY = -300;
      current = DedesAnimationStates.idle;
      AudioManager.instance.playSfx('jump14.wav');
    }
  }

  // Metode ini mengubah keadaan animasi menjadi
  /// [DedesAnimationStates.hit], memainkan suara hit
  /// dan mengurangi nyawa pemain sebanyak 1.
  void hit() {
    isHit = true;
    AudioManager.instance.playSfx('hurt7.wav');
    current = DedesAnimationStates.hit;
    _hitTimer.start();
    playerData.lives -= 1;
  }

  // Metode ini mereset beberapa properti penting
  // dari komponen ini kembali ke keadaan normal.
  void _reset() {
    if (isMounted) {
      removeFromParent();
    }
    anchor = Anchor.bottomLeft;
    position = Vector2(32, game.virtualSize.y - 22);
    size = Vector2.all(24);
    current = DedesAnimationStates.run;
    isHit = false;
    speedY = 0.0;
  }
}
