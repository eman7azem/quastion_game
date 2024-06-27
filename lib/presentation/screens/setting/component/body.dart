import 'package:flutter/material.dart';
import 'package:quastions_game/constants/navigator.dart';

import '../../../../constants/colors.dart';
import '../../../utilities/user_actions.dart';
import '../../../widgets/b.dart';
import '../../wallet/wallet_screen.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool progressLogout = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.9,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            child: Image.asset(
              'assets/images/bg1.png',
              height: size.height * 0.3,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: size.height * 0.08,
            left: size.width * 0.05,
            child: Container(
              height: size.height * 0.81,
              width: size.width * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(40),
                ),
                border: Border.all(color: Colors.transparent),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height*0.06,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: size.width*0.04),
                    child: Text(
                      'الإعدادات',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'Kohinoor Arabic',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height*0.03,),

                  GestureDetector(
                    onTap: (){
                      navigateTo(context, WalletScreen());
                    },
                    child: ListTile(
                      title: Row(
                        children: [
                          Icon(Icons.wallet, color: kPrimaryColor),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              'المحفظة',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'Kohinoor Arabic',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Icon(Icons.share, color: kPrimaryColor),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'شارك التطبيق',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Kohinoor Arabic',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      // shareApp();
                      print('print the share');
                    },
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Icon(Icons.telegram, color: kPrimaryColor),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Telegram',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Kohinoor Arabic',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      // _openURL('https://t.me/+GgcfJm5PBFczN2U0');
                    },
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Icon(Icons.logout, color: kPrimaryColor),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'تسجيل الخروج',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Kohinoor Arabic',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () => logout(),
                  ),
                  // CustomPaint(
                  //   size: Size(268, 126),
                  //   painter: RPSCustomPainter(),
                  // )


                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void logout() async {
    setState(() {
      progressLogout = true;
    });
    userLogout(context);
    setState(() {
      progressLogout = false;
    });
  }
}
