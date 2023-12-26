import 'dart:ui';

import 'package:flutter/material.dart';
// import 'package:get/get.dart'; // Import GetX
import '../game/dedes_run.dart';
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.black.withAlpha(100),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
              child: Wrap(
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 10,
                children: [
                  Image.asset('assets/images/btn-nusanta/NUSANTARISE.png'),
                  InkWell(
                    onTap: () {
                      game.startGamePlay();
                      game.overlays.remove(MainMenu.id);
                      game.overlays.add(Hud.id);
                      // Get.back(); // Menutup overlay MainMenu menggunakan GetX
                      // Get.toNamed(
                      //     Hud.id); // Menampilkan overlay Hud menggunakan GetX
                    },
                    child: Ink.image(
                      image: const AssetImage(
                          'assets/images/btn-nusanta/START.png'),
                      height: 55,
                      width: 175,
                      fit: BoxFit.cover,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      game.overlays.remove(MainMenu.id);
                      game.overlays.add(SettingsMenu.id);
                      // Get.back(); // Menutup overlay MainMenu menggunakan GetX
                      // Get.toNamed(SettingsMenu
                      //     .id); // Menampilkan overlay SettingsMenu menggunakan GetX
                    },
                    child: Ink.image(
                      image: const AssetImage(
                          'assets/images/btn-nusanta/MENU.png'),
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
