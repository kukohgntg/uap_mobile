import '../models/settings.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';

/// Kelas ini merupakan antarmuka umum antara [DedesRun]
/// dan API audio dari engine [Flame].
class AudioManager {
  late Settings settings;
  AudioManager._internal();

  /// [_instance] merepresentasikan instance tunggal statis dari [AudioManager].
  static final AudioManager _instance = AudioManager._internal();

  /// Sebuah getter untuk mengakses instance tunggal dari [AudioManager].
  static AudioManager get instance => _instance;

  /// Metode ini bertanggung jawab untuk menginisialisasi caching dari daftar [files],
  /// dan menginisialisasi pengaturan.
  Future<void> init(List<String> files, Settings settings) async {
    this.settings = settings;
    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.loadAll(files);
  }

  // Memulai file audio tertentu sebagai BGM dengan mode loop.
  void startBgm(String fileName) {
    if (settings.bgm) {
      FlameAudio.bgm.play(fileName, volume: 0.4);
    }
  }

  // Menjeda BGM yang sedang diputar jika ada.
  void pauseBgm() {
    if (settings.bgm) {
      FlameAudio.bgm.pause();
    }
  }

  // Melanjutkan pemutaran BGM yang sedang dijeda jika ada.
  void resumeBgm() {
    if (settings.bgm) {
      FlameAudio.bgm.resume();
    }
  }

  // Menghentikan BGM yang sedang diputar jika ada.
  void stopBgm() {
    FlameAudio.bgm.stop();
  }

  // Memutar file audio tertentu satu kali.
  void playSfx(String fileName) {
    if (settings.sfx) {
      FlameAudio.play(fileName);
    }
  }
}
