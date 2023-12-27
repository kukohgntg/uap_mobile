/// File: player_data.dart
///
/// Deskripsi:
///   File ini berisi definisi kelas `PlayerData` yang digunakan untuk merepresentasikan
///   data pemain dalam game. Kelas ini mengimplementasikan fungsi-fungsi untuk
///   manajemen skor, nyawa, serta menggunakan GetX untuk manajemen state, dan Hive
///   untuk penyimpanan data lokal.
///
/// Import:
///   - `get/get.dart`: Import paket GetX untuk manajemen state.
///   - `hive/hive.dart`: Import paket Hive untuk penyimpanan data lokal.
///
/// Part:
///   - `player_data.g.dart`: File ini digenerate otomatis oleh Hive untuk
///     membantu serialisasi/deserialisasi objek `PlayerData`.
///

import 'package:get/get.dart'; // Import GetX untuk manajemen state.
import 'package:hive/hive.dart'; // Import Hive untuk penyimpanan data lokal.

part 'player_data.g.dart'; // Part file yang digenerate oleh Hive.

/// Kelas `PlayerData` merepresentasikan data pemain dalam game.
@HiveType(typeId: 0)
class PlayerData extends GetxController with HiveObjectMixin {
  /// Field `highScore` merupakan skor tertinggi yang pernah dicapai pemain.
  @HiveField(1)
  int highScore = 0;

  /// Jumlah nyawa pemain.
  int _lives = 5;

  /// Getter untuk mendapatkan jumlah nyawa.
  int get lives => _lives;

  /// Setter untuk mengatur jumlah nyawa dengan batasan 0 hingga 5.
  set lives(int value) {
    if (value <= 5 && value >= 0) {
      _lives = value;
      update(); // Menggunakan update() untuk memberi tahu GetX tentang perubahan.
    }
  }

  /// Skor saat ini pemain.
  int _currentScore = 0;

  /// Getter untuk mendapatkan skor saat ini.
  int get currentScore => _currentScore;

  /// Setter untuk mengatur skor saat ini.
  set currentScore(int value) {
    _currentScore = value;

    // Memperbarui highScore jika skor saat ini lebih tinggi.
    if (highScore < _currentScore) {
      highScore = _currentScore;
    }

    update(); // Menggunakan update() untuk memberi tahu GetX tentang perubahan.

    save(); // Menyimpan data pemain ke Hive.
  }
}

// part 'player_data.g.dart' digenerate oleh Hive untuk membantu
// serialisasi/deserialisasi objek `PlayerData`.
