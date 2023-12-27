/// File: enemy_data.dart
///
/// Deskripsi:
///   File ini berisi definisi kelas [EnemyData] yang digunakan untuk
///   menyimpan semua data yang diperlukan dalam pembuatan musuh dalam permainan.
///
/// Import:
///   - `flame/extensions.dart`: Import paket Flame untuk penggunaan extension dan
///     fungsionalitas tambahan dalam pengembangan game.
///
library;

import 'package:flame/extensions.dart';

// Kelas ini menyimpan semua data yang diperlukan
// untuk membuat musuh dalam permainan.
class EnemyData {
  // Gambar yang digunakan untuk musuh.
  final Image image;

  // Jumlah frame dalam animasi musuh.
  final int nFrames;

  // Waktu setiap langkah animasi musuh.
  final double stepTime;

  // Ukuran tekstur musuh.
  final Vector2 textureSize;

  // Kecepatan pergerakan musuh horizontal.
  final double speedX;

  // Apakah musuh dapat terbang atau tidak.
  final bool canFly;

  // Konstruktor untuk menginisialisasi data musuh.
  const EnemyData({
    required this.image,
    required this.nFrames,
    required this.stepTime,
    required this.textureSize,
    required this.speedX,
    required this.canFly,
  });
}
