import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import '../game/audio_manager.dart';
import '../game/dedes_run.dart';
import '../models/player_data.dart';
import 'hud.dart';
import 'main_menu.dart';

class GameOverMenu extends StatelessWidget {
  static const id = 'GameOverMenu';

  final DedesRun game;

  const GameOverMenu(this.game, {super.key});

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
                  const Text(
                    'Game Over',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  GetBuilder<PlayerData>(
                    init: game.playerData, // Inisialisasi instance PlayerData
                    builder: (playerData) {
                      return Text(
                        'You Score: ${playerData.currentScore}',
                        style: const TextStyle(fontSize: 30, color: Colors.white),
                      );
                    },
                  ),
                  InkWell(
                    onTap: () {
                      game.overlays.remove(GameOverMenu.id);
                      game.overlays.add(Hud.id);
                      game.resumeEngine();
                      game.reset();
                      game.startGamePlay();
                      AudioManager.instance.resumeBgm();
                    },
                    child: Ink.image(
                      image: const AssetImage('assets/images/btn-nusanta/NEW GAME.png'),
                      height: 55,
                      width: 175,
                      fit: BoxFit.cover,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      game.overlays.remove(GameOverMenu.id);
                      game.overlays.add(MainMenu.id);
                      game.resumeEngine();
                      game.reset();
                      AudioManager.instance.resumeBgm();
                    },
                    child: Ink.image(
                      image: const AssetImage('assets/images/btn-nusanta/EXIT.png'),
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
