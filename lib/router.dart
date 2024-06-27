import 'package:flutter/material.dart';
import 'package:quastions_game/bottom_bar/bottom_bar.dart';
import 'package:quastions_game/presentation/screens/login/signin.dart';
import 'package:quastions_game/presentation/utilities/user_actions.dart';
import 'constants/navigator.dart';
import 'data/api/api.dart';

class MyRouter {
  MyRouter({required this.context, required this.api});

  final API api;
  final BuildContext context;

  void route() async {
    if (await checkLoggedIn()) {
      var userData = await api.getDataProfile();
      if (userData != null) {
        navigateWithoutHistory(context, BottomNavBar());
      } else {
        if (context.mounted) userLogout(context);
        // if (context.mounted) showToast(AppLocalizations.of(context)!.errorConnecting, error: true);
      }
    } else {
      if (context.mounted) navigateWithoutHistory(context,  Login());
    }
  }
}
