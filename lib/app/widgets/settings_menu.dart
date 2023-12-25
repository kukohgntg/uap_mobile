import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../game/audio_manager.dart';
import '../game/dedes_run.dart';
import '../models/settings.dart';
import 'main_menu.dart';

// Ini overlay untuk layar menu pengaturan.
class SettingsMenu extends StatelessWidget {
  // Identifier unik untuk overlay ini.
  static const id = 'SettingsMenu';

  // Referensi ke game induk.
  final DedesRun game;

  const SettingsMenu(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: game.settings,
      child: Center(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.black.withAlpha(100),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Selector<Settings, bool>(
                      selector: (_, settings) => settings.bgm,
                      builder: (context, bgm, __) {
                        return SwitchListTile(
                          title: const Image(
                            image: AssetImage(
                                'assets/images/btn-nusanta/MUSIC.png'),
                            height: 60,
                            alignment: Alignment.centerLeft,
                          ),
                          value: bgm,
                          onChanged: (bool value) {
                            Provider.of<Settings>(context, listen: false).bgm =
                                value;
                            if (value) {
                              AudioManager.instance
                                  .startBgm('8BitPlatformerLoop.wav');
                            } else {
                              AudioManager.instance.stopBgm();
                            }
                          },
                        );
                      },
                    ),
                    Selector<Settings, bool>(
                      selector: (_, settings) => settings.sfx,
                      builder: (context, sfx, __) {
                        return SwitchListTile(
                          title: const Image(
                            image: AssetImage(
                                'assets/images/btn-nusanta/EFFECT.png'),
                            height: 60,
                            alignment: Alignment.centerLeft,
                          ),
                          // const Text(
                          //   'Effects',
                          //   style: TextStyle(
                          //     fontSize: 30,
                          //     color: Colors.white,
                          //   ),
                          // ),
                          value: sfx,
                          onChanged: (bool value) {
                            Provider.of<Settings>(context, listen: false).sfx =
                                value;
                          },
                        );
                      },
                    ),
                    InkWell(
                      onTap: () {
                        game.overlays.remove(SettingsMenu.id);
                        game.overlays.add(MainMenu.id);
                      },
                      child: Ink.image(
                        image: const AssetImage(
                            'assets/images/btn-nusanta/OUT.png'),
                        height: 60,
                        width: 58.5,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
