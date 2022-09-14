// ignore_for_file: use_build_context_synchronously
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:revanced_manager/ui/views/home/home_view.dart';
import 'package:revanced_manager/ui/views/patcher/patcher_view.dart';
import 'package:revanced_manager/ui/views/settings/settings_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class NavigationViewModel extends IndexTrackingViewModel {
  void initialize(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('useDarkTheme') == null) {
      if (MediaQuery.of(context).platformBrightness == Brightness.light) {
        await prefs.setBool('useDarkTheme', false);
        DynamicTheme.of(context)!.setTheme(0);
      } else {
        await prefs.setBool('useDarkTheme', true);
        DynamicTheme.of(context)!.setTheme(1);
      }
    }
  }

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return const HomeView();
      case 1:
        return const PatcherView();
      case 2:
        return const SettingsView();
      default:
        return const HomeView();
    }
  }
}
