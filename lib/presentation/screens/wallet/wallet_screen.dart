import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quastions_game/presentation/screens/wallet/component/body.dart';

class WalletScreen extends StatelessWidget {
  WalletScreen({Key? key}) : super(key: key);

  // final _api = API();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return const Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold( body: Body()),
    );
  }
}
