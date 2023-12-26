import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import '../controllers/audio_manager.dart';
import '../controllers/dedes_run.dart';
import '../models/player_data.dart';
import 'pause_menu.dart';

class Hud extends StatelessWidget {
  static const id = 'Hud';

  final DedesRun game;

  const Hud(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlayerData>(
      init: game.playerData, // Inisialisasi instance PlayerData
      builder: (playerData) {
        return Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  game.overlays.remove(Hud.id);
                  game.overlays.add(PauseMenu.id);
                  game.pauseEngine();
                  AudioManager.instance.pauseBgm();
                },
                icon: Image.asset('assets/images/btn-nusanta/MENU HUD.png'),
                iconSize: 40,
              ),
              Column(
                children: [
                  Text(
                    'Score: ${playerData.currentScore}',
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Text(
                    'High: ${playerData.highScore}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              Row(
                children: List.generate(5, (index) {
                  if (index < playerData.lives) {
                    return const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    );
                  } else {
                    return const Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    );
                  }
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
