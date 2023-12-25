import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'player_data.g.dart';

// Kelas ini menyimpan kemajuan pemain secara persisten.
@HiveType(typeId: 0)
class PlayerData extends ChangeNotifier with HiveObjectMixin {
  // High score pemain, diatur oleh pemain secara dinamis.
  @HiveField(1)
  int highScore = 0;

  // Jumlah nyawa pemain, defaultnya adalah 5.
  int _lives = 5;

  // Getter dan setter untuk nyawa pemain dengan batasan nilai antara 0 dan 5.
  int get lives => _lives;
  set lives(int value) {
    if (value <= 5 && value >= 0) {
      _lives = value;
      notifyListeners();
    }
  }

  // Skor saat ini yang sedang dimainkan.
  int _currentScore = 0;

  // Getter dan setter untuk skor saat ini dengan pemantauan perubahan.
  int get currentScore => _currentScore;
  set currentScore(int value) {
    _currentScore = value;

    // Jika skor saat ini melebihi high score, perbarui high score.
    if (highScore < _currentScore) {
      highScore = _currentScore;
    }

    // Memperingatkan pendengar bahwa terjadi perubahan pada skor atau high score.
    notifyListeners();

    // Menyimpan data ke penyimpanan persisten menggunakan metode save().
    save();
  }
}
