/// File: settings_menu.dart
///
/// Deskripsi:
///   File ini berisi implementasi kelas SettingsMenu, yang merupakan bagian dari antarmuka pengguna
///   untuk menu pengaturan permainan DedesRun. Kelas ini memungkinkan pemain untuk mengonfigurasi
///   pengaturan suara permainan seperti latar belakang dan efek suara.
///

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import '../controllers/audio_manager.dart';
import '../controllers/dedes_run.dart';
import '../models/settings.dart';
import 'main_menu.dart';

class SettingsMenu extends StatelessWidget {
  static const id = 'SettingsMenu';

  final DedesRun game;

  const SettingsMenu(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Settings>(
      init: game.settings, // Inisialisasi instance Settings
      builder: (settings) {
        return Center(
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
                      SwitchListTile(
                        title: const Image(
                          image:
                              AssetImage('assets/images/btn-nusanta/MUSIC.png'),
                          height: 60,
                          alignment: Alignment.centerLeft,
                        ),
                        value: settings.bgm,
                        onChanged: (bool value) {
                          // Mengubah pengaturan latar belakang musik (BGM) berdasarkan nilai switch.
                          settings.bgm = value;
                          if (value) {
                            AudioManager.instance
                                .startBgm('8BitPlatformerLoop.wav');
                          } else {
                            AudioManager.instance.stopBgm();
                          }
                        },
                      ),
                      SwitchListTile(
                        title: const Image(
                          image: AssetImage(
                              'assets/images/btn-nusanta/EFFECT.png'),
                          height: 60,
                          alignment: Alignment.centerLeft,
                        ),
                        value: settings.sfx,
                        onChanged: (bool value) {
                          // Mengubah pengaturan efek suara berdasarkan nilai switch.
                          settings.sfx = value;
                        },
                      ),
                      InkWell(
                        onTap: () {
                          // Kembali ke menu utama saat tombol "OUT" ditekan.
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
        );
      },
    );
  }
}
