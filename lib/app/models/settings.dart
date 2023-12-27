/// File: settings.dart
///
/// Deskripsi:
///   File ini berisi definisi kelas `Settings` yang digunakan untuk menyimpan
///   pengaturan permainan secara persisten. Kelas ini mengimplementasikan
///   GetX untuk manajemen state dan Hive untuk penyimpanan data lokal.
///
/// Import:
///   - `get/get.dart`: Import paket GetX untuk manajemen state.
///   - `hive/hive.dart`: Import paket Hive untuk penyimpanan data lokal.
///
/// Part:
///   - `settings.g.dart`: File ini digenerate otomatis oleh Hive untuk
///     membantu serialisasi/deserialisasi objek `Settings`.
///

import 'package:get/get.dart'; // Import GetX untuk manajemen state.
import 'package:hive/hive.dart';

// Bagian kode ini merupakan bagian dari penggunaan generator kode Hive.
part 'settings.g.dart';

/// Kelas `Settings` menyimpan pengaturan permainan secara persisten.
@HiveType(typeId: 1)
class Settings extends GetxController with HiveObjectMixin {
  /// Konstruktor untuk menginisialisasi pengaturan awal.
  Settings({bool bgm = false, bool sfx = false}) {
    _bgm = bgm;
    _sfx = sfx;
  }

  /// Atribut privat untuk menyimpan pengaturan musik latar.
  @HiveField(0)
  bool _bgm = false;

  /// Getter dan setter untuk pengaturan musik latar.
  bool get bgm => _bgm;
  set bgm(bool value) {
    _bgm = value;

    // Memberi tahu pendengar bahwa terjadi perubahan pada pengaturan musik latar.
    update();

    // Menyimpan data ke penyimpanan persisten menggunakan metode save().
    save();
  }

  /// Atribut privat untuk menyimpan pengaturan efek suara.
  @HiveField(1)
  bool _sfx = false;

  /// Getter dan setter untuk pengaturan efek suara.
  bool get sfx => _sfx;
  set sfx(bool value) {
    _sfx = value;

    // Memberi tahu pendengar bahwa terjadi perubahan pada pengaturan efek suara.
    update();

    // Menyimpan data ke penyimpanan persisten menggunakan metode save().
    save();
  }
}

// part 'settings.g.dart' digenerate oleh Hive untuk membantu
// serialisasi/deserialisasi objek `Settings`.
