import 'dart:ui';

import 'package:flutter/material.dart';

import '../game/dedes_run.dart';
import 'hud.dart';
import 'settings_menu.dart';

// Ini overlay untuk layar menu utama.
class MainMenu extends StatelessWidget {
  // Identifier unik untuk overlay ini.
  static const id = 'MainMenu';

  // Referensi ke game induk.
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
                  const Text(
                    'NusantaRise ',
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      game.startGamePlay();
                      game.overlays.remove(MainMenu.id);
                      game.overlays.add(Hud.id);
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
