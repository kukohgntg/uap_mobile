import 'package:get/get.dart'; // Import GetX
import 'package:hive/hive.dart';

part 'player_data.g.dart';

@HiveType(typeId: 0)
class PlayerData extends GetxController with HiveObjectMixin {
  @HiveField(1)
  int highScore = 0;

  int _lives = 5;

  int get lives => _lives;
  set lives(int value) {
    if (value <= 5 && value >= 0) {
      _lives = value;
      update(); // Menggunakan update() untuk memberi tahu GetX tentang perubahan.
    }
  }

  int _currentScore = 0;

  int get currentScore => _currentScore;
  set currentScore(int value) {
    _currentScore = value;

    if (highScore < _currentScore) {
      highScore = _currentScore;
    }

    update(); // Menggunakan update() untuk memberi tahu GetX tentang perubahan.

    save();
  }
}
