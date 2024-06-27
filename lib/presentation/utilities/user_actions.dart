import 'package:flutter/material.dart';
import 'package:quastions_game/data/api/api.dart';
import 'package:quastions_game/presentation/screens/login/signin.dart';
import 'package:quastions_game/presentation/utilities/shared_pref.dart';

import '../../constants/navigator.dart';



void userLogout(BuildContext context) async {
  await API().logout(
  );
  await removeString('token');
  if (context.mounted) navigateWithoutHistory(context,  Login());
}

Future<bool> checkLoggedIn() async {
  return await getString('token') != null ? true : false ;
}

