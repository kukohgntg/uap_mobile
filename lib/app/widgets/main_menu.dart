/// File: main_menu.dart
///
/// Deskripsi:
///   File ini berisi implementasi kelas [MainMenu], yang merupakan bagian dari antarmuka pengguna
///   utama untuk permainan [DedesRun]. Kelas ini menyediakan tampilan menu utama permainan
///   dengan opsi untuk memulai permainan atau masuk ke menu pengaturan.
///
library;

import 'dart:ui';

import 'package:flutter/material.dart';
import '../controllers/dedes_run.dart';
import 'hud.dart';
import 'settings_menu.dart';

class MainMenu extends StatelessWidget {
  static const id = 'MainMenu';

  final DedesRun game;

  const MainMenu(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.black.withAlpha(100),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
              child: Wrap(
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 10,
                children: [
                  Image.asset('assets/images/btn-nusanta/NUSANTARISE.png'),
                  InkWell(
                    onTap: () {
                      // Memulai permainan saat tombol "START" ditekan.
                      game.startGamePlay();

                      // Menghapus overlay MainMenu dan menambahkan overlay Hud.
                      game.overlays.remove(MainMenu.id);
                      game.overlays.add(Hud.id);
                    },
                    child: Ink.image(
                      image: const AssetImage('assets/images/btn-nusanta/START.png'),
                      height: 55,
                      width: 175,
                      fit: BoxFit.cover,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Beralih ke menu pengaturan saat tombol "MENU" ditekan.
                      game.overlays.remove(MainMenu.id);
                      game.overlays.add(SettingsMenu.id);
                    },
                    child: Ink.image(
                      image: const AssetImage('assets/images/btn-nusanta/MENU.png'),
                      height: 55,
                      width: 175,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
