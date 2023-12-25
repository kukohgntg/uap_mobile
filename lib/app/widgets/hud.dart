import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../game/audio_manager.dart';
import '../game/dedes_run.dart';
import '../models/player_data.dart';
import 'pause_menu.dart';

// Ini mewakili tampilan dalam game.
// Terdiri dari, skor saat ini, skor tinggi,
// tombol jeda dan jumlah sisa nyawa.
class Hud extends StatelessWidget {
  // Identifier unik untuk overlay ini.
  static const id = 'Hud';

  // Referensi ke game induk.
  final DedesRun game;

  const Hud(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: game.playerData,
      child: Padding(
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
                Selector<PlayerData, int>(
                  selector: (_, playerData) => playerData.currentScore,
                  builder: (_, score, __) {
                    return Text(
                      'Score: $score',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    );
                  },
                ),
                Selector<PlayerData, int>(
                  selector: (_, playerData) => playerData.highScore,
                  builder: (_, highScore, __) {
                    return Text(
                      'High: $highScore',
                      style: const TextStyle(color: Colors.white),
                    );
                  },
                ),
              ],
            ),
            Selector<PlayerData, int>(
              selector: (_, playerData) => playerData.lives,
              builder: (_, lives, __) {
                return Row(
                  children: List.generate(5, (index) {
                    if (index < lives) {
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
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
