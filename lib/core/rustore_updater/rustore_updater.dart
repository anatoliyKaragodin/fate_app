import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_rustore_update/const.dart';
import 'package:flutter_rustore_update/flutter_rustore_update.dart';

import 'dart:developer' as dev;

final updaterRustoreProvider =
    StateNotifierProvider<RustoreUpdater, bool>((ref) => RustoreUpdater());

class RustoreUpdater extends StateNotifier<bool> {
  RustoreUpdater() : super(false) {
    checkForUpdates();
  }

  Future<void> checkForUpdates() async {
    RustoreUpdateClient.info().then((info) {
      // dev.log(info.updateAvailability.toString());

      if (info.updateAvailability == UPDATE_AILABILITY_AVAILABLE) {
        state = true;
      }
    }).catchError((err) {
      dev.log(err.toString());
    });
  }

  void update() {
    RustoreUpdateClient.info().then((info) {
      if (info.updateAvailability == UPDATE_AILABILITY_AVAILABLE) {
        RustoreUpdateClient.listener((value) {
          

          if (value.installStatus == INSTALL_STATUS_DOWNLOADED) {
            RustoreUpdateClient.completeUpdateFlexible().catchError((err) {
            });
          }
        });
        RustoreUpdateClient.download().then((value) {
          dev.log("download code ${value.code}");

          if (value.code == ACTIVITY_RESULT_CANCELED) {
            dev.log("user cancel update");
          }
        }).catchError((err) {
          dev.log("download err $err");
        });
      }
    }).catchError((err) {
      dev.log(err.toString());
    });
  }
}
