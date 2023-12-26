import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import '../controllers/audio_manager.dart';
import '../controllers/dedes_run.dart';
import '../models/player_data.dart';

import 'hud.dart';
import 'main_menu.dart';

class PauseMenu extends StatelessWidget {
  static const id = 'PauseMenu';

  final DedesRun game;

  const PauseMenu(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlayerData>(
      init: game.playerData, // Inisialisasi instance PlayerData
      builder: (playerData) {
        return Center(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
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
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'Score: ${playerData.currentScore}',
                          style: const TextStyle(
                              fontSize: 40, color: Colors.white),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          game.overlays.remove(PauseMenu.id);
                          game.overlays.add(Hud.id);
                          // Get.back(); // Menutup overlay PauseMenu menggunakan GetX
                          // Get.toNamed(Hud
                          //     .id); // Menampilkan overlay Hud menggunakan GetX
                          game.resumeEngine();
                          AudioManager.instance.resumeBgm();
                        },
                        child: Ink.image(
                          image: const AssetImage(
                              'assets/images/btn-nusanta/CONTINUE.png'),
                          height: 55,
                          width: 175,
                          fit: BoxFit.cover,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          game.overlays.remove(PauseMenu.id);
                          game.overlays.add(Hud.id);
                          // Get.back(); // Menutup overlay PauseMenu menggunakan GetX
                          // Get.toNamed(Hud
                          //     .id); // Menampilkan overlay Hud menggunakan GetX
                          game.resumeEngine();
                          game.reset();
                          game.startGamePlay();
                          AudioManager.instance.resumeBgm();
                        },
                        child: Ink.image(
                          image: const AssetImage(
                              'assets/images/btn-nusanta/RESET.png'),
                          height: 55,
                          width: 175,
                          fit: BoxFit.cover,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          game.overlays.remove(PauseMenu.id);
                          game.overlays.add(MainMenu.id);
                          // Get.back(); // Menutup overlay PauseMenu menggunakan GetX
                          // Get.toNamed(MainMenu
                          //     .id); // Menampilkan overlay MainMenu menggunakan GetX
                          game.resumeEngine();
                          game.reset();
                          AudioManager.instance.resumeBgm();
                        },
                        child: Ink.image(
                          image: const AssetImage(
                              'assets/images/btn-nusanta/EXIT.png'),
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
      },
    );
  }
}
