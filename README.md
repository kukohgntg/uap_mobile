# Dedes Run - Dokumentasi

## Pendahuluan

"Dedes Run" adalah aplikasi game Flutter yang menggunakan game engine Flame, database Hive, dan state management GetX. Berikut adalah dokumentasi untuk setiap file dalam proyek ini.

## File: dedes.dart

### Cuplikan Code:

```dart
// Dedes class sebagai representasi karakter utama.
class Dedes extends SpriteComponent {
  Dedes(Image image, this.playerData) : super.fromImage(image);

  // Metode untuk membuat karakter melompat.
  void jump() {
    // Implementasi melompat...
  }
}
```

### Penjelasan Singkat:

- Kelas `Dedes` merupakan representasi karakter utama dalam game.
- Memiliki metode `jump()` untuk mengimplementasikan perilaku melompat.

## File: dedes_run.dart

### Cuplikan Code:

```dart
// Kelas DedesRun sebagai kelas utama permainan Flame.
class DedesRun extends FlameGame with TapDetector, HasCollisionDetection {
  DedesRun({super.camera});

  // Metode onLoad() untuk persiapan permainan.
  @override
  Future<void> onLoad() async {
    // Implementasi persiapan permainan...
  }

  // Metode update() dipanggil setiap tick/frame permainan.
  @override
  void update(double dt) {
    // Implementasi logika update permainan...
  }

  // Metode onTapDown() dipanggil untuk setiap tap pada layar.
  @override
  void onTapDown(TapDownInfo info) {
    // Implementasi respons terhadap tap pada layar...
  }
}
```

### Penjelasan Singkat:

- Kelas `DedesRun` merupakan kelas utama permainan Flame.
- Memiliki metode `onLoad()` untuk persiapan permainan dan metode `update()` untuk logika permainan.
- Menggunakan mixin seperti `TapDetector` dan `HasCollisionDetection`.
- Metode `onTapDown()` untuk menangani setiap tap pada layar.

## File: main_menu.dart

### Cuplikan Code:

```dart
// Kelas MainMenu sebagai tampilan menu utama.
class MainMenu extends StatelessWidget {
  const MainMenu(this.game, {super.key});

  // Metode build() untuk membangun tampilan.
  @override
  Widget build(BuildContext context) {
    // Implementasi tampilan menu utama...
  }
}
```

### Penjelasan Singkat:

- Kelas `MainMenu` adalah tampilan untuk menu utama game.
- Menggunakan widget `InkWell` dan `Image.asset` untuk membuat tampilan tombol.

## File: settings_menu.dart

### Cuplikan Code:

```dart
// Kelas SettingsMenu sebagai tampilan menu pengaturan.
class SettingsMenu extends StatelessWidget {
  const SettingsMenu(this.game, {super.key});

  // Metode build() untuk membangun tampilan.
  @override
  Widget build(BuildContext context) {
    // Implementasi tampilan menu pengaturan...
  }
}
```

### Penjelasan Singkat:

- Kelas `SettingsMenu` adalah tampilan untuk menu pengaturan game.
- Menggunakan widget `SwitchListTile` untuk pengaturan musik dan efek suara.

## File: hud.dart

### Cuplikan Code:

```dart
// Kelas Hud sebagai tampilan kepala atas permainan.
class Hud extends StatelessWidget {
  const Hud(this.game, {super.key});

  // Metode build() untuk membangun tampilan.
  @override
  Widget build(BuildContext context) {
    // Implementasi tampilan kepala atas (HUD) permainan...
  }
}
```

### Penjelasan Singkat:

- Kelas `Hud` adalah tampilan kepala atas (HUD) dalam game.
- Menampilkan skor, nyawa, dan tombol menu pause.

## File: pause_menu.dart

### Cuplikan Code:

```dart
// Kelas PauseMenu sebagai tampilan menu pause.
class PauseMenu extends StatelessWidget {
  const PauseMenu(this.game, {super.key});

  // Metode build() untuk membangun tampilan.
  @override
  Widget build(BuildContext context) {
    // Implementasi tampilan menu pause...
  }
}
```

### Penjelasan Singkat:

- Kelas `PauseMenu` adalah tampilan untuk menu pause dalam permainan.
- Menampilkan skor dan tombol untuk melanjutkan, mereset, atau keluar.

## File: game_over_menu.dart

### Cuplikan Code:

```dart
// Kelas GameOverMenu sebagai tampilan menu game over.
class GameOverMenu extends StatelessWidget {
  const GameOverMenu(this.game, {super.key});

  // Metode build() untuk membangun tampilan.
  @override
  Widget build(BuildContext context) {
    // Implementasi tampilan menu game over...
  }
}
```

### Penjelasan Singkat:

- Kelas `GameOverMenu` adalah tampilan untuk menu game over.
- Menampilkan skor dan tombol untuk memulai kembali atau keluar.

## File: main.dart

### Cuplikan Code:

```dart
// Kelas DedesRunApp sebagai kelas utama aplikasi.
class DedesRunApp extends StatelessWidget {
  const DedesRunApp({Key? key});

  // Metode build() untuk membangun tampilan.
  @override
  Widget build(BuildContext context) {
    // Implementasi konfigurasi utama aplikasi...
  }
}
```

### Penjelasan Singkat:

- Kelas `DedesRunApp` adalah kelas utama aplikasi Flutter.
- Menggunakan `GetMaterialApp` dan `GameWidget<DedesRun>.controlled` untuk menampilkan game.
- Menginisialisasi Hive, mendaftarkan adapter, dan menyiapkan konfigurasi tampilan aplikasi.

## Penutup

Dengan dokumentasi ini, diharapkan memudahkan pemahaman dan pengembangan lebih lanjut pada proyek "Dedes Run".
