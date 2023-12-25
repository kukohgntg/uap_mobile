import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';

// Bagian kode ini merupakan bagian dari penggunaan generator kode Hive.
part 'settings.g.dart';

// Kelas ini menyimpan pengaturan permainan secara persisten.
@HiveType(typeId: 1)
class Settings extends ChangeNotifier with HiveObjectMixin {
  // Konstruktor untuk menginisialisasi pengaturan awal.
  Settings({bool bgm = false, bool sfx = false}) {
    _bgm = bgm;
    _sfx = sfx;
  }

  // Atribut private untuk menyimpan pengaturan musik latar.
  @HiveField(0)
  bool _bgm = false;

  // Getter dan setter untuk pengaturan musik latar.
  bool get bgm => _bgm;
  set bgm(bool value) {
    _bgm = value;

    // Memberi tahu pendengar bahwa terjadi perubahan pada pengaturan musik latar.
    notifyListeners();

    // Menyimpan data ke penyimpanan persisten menggunakan metode save().
    save();
  }

  // Atribut private untuk menyimpan pengaturan efek suara.
  @HiveField(1)
  bool _sfx = false;

  // Getter dan setter untuk pengaturan efek suara.
  bool get sfx => _sfx;
  set sfx(bool value) {
    _sfx = value;

    // Memberi tahu pendengar bahwa terjadi perubahan pada pengaturan efek suara.
    notifyListeners();

    // Menyimpan data ke penyimpanan persisten menggunakan metode save().
    save();
  }
}
