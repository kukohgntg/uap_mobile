// File: main_menu_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dedes_run/app/controllers/dedes_run.dart';
import 'package:dedes_run/app/widgets/hud.dart';
import 'package:dedes_run/app/widgets/main_menu.dart';
import 'package:dedes_run/app/widgets/settings_menu.dart';

class MockDedesRun extends Mock implements DedesRun {}

void main() {
  group('MainMenu Widget Test', () {
    // Inisialisasi mock untuk DedesRun
    late MockDedesRun mockGame;

    // Setup sebelum setiap pengujian
    setUp(() {
      mockGame = MockDedesRun();
    });

    // Test 1: Menguji apakah widget MainMenu dapat dibuat dengan benar
    testWidgets('MainMenu Widget Creation', (WidgetTester tester) async {
      // Bangun widget MainMenu
      await tester.pumpWidget(MaterialApp(
        home: MainMenu(mockGame),
      ));

      // Verifikasi apakah widget berhasil dibangun
      expect(find.byType(MainMenu), findsOneWidget);
    });

    // Test 2: Menguji apakah tombol "START" berfungsi dengan benar
    testWidgets('Start Game Button Press', (WidgetTester tester) async {
      // Bangun widget MainMenu
      await tester.pumpWidget(MaterialApp(
        home: MainMenu(mockGame),
      ));

      // Tekan tombol "START"
      await tester.tap(find.byKey(ValueKey('startButton')));
      await tester.pumpAndSettle();

      // Verifikasi apakah metode startGamePlay dipanggil di DedesRun
      verify(mockGame.startGamePlay()).called(1);

      // Verifikasi apakah overlay MainMenu dihapus dan overlay Hud ditambahkan
      verify(mockGame.overlays.remove(MainMenu.id)).called(1);
      verify(mockGame.overlays.add(Hud.id)).called(1);
    });

    // Test 3: Menguji apakah tombol "MENU" berfungsi dengan benar
    testWidgets('Settings Menu Button Press', (WidgetTester tester) async {
      // Bangun widget MainMenu
      await tester.pumpWidget(MaterialApp(
        home: MainMenu(mockGame),
      ));

      // Tekan tombol "MENU"
      await tester.tap(find.byKey(ValueKey('settingsButton')));
      await tester.pumpAndSettle();

      // Verifikasi apakah overlay MainMenu dihapus dan overlay SettingsMenu ditambahkan
      verify(mockGame.overlays.remove(MainMenu.id)).called(1);
      verify(mockGame.overlays.add(SettingsMenu.id)).called(1);
    });
  });
}
