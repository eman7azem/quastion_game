import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:quastions_game/constants/colors.dart';
import 'package:quastions_game/presentation/screens/login/signin.dart';

import '../presentation/screens/home/home.dart';
import '../presentation/screens/profile/profile.dart';
import '../presentation/screens/setting/setting.dart';

class BottomNavBar extends StatefulWidget {
  static const String routeName = 'bottom bar';
final int page;

  const BottomNavBar({super.key, this.page=1});
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int _page;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _page = widget.page; // Initialize _page with the value from the widget parameter
    _pageController = PageController(initialPage: _page);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(

        key: _bottomNavigationKey,
        index: _page,
        height: 60.0,
        items: <Widget>[
          Icon(Icons.person, size: 30, color: _page == 0 ? kPrimaryDark : Colors.white),
          Icon(Icons.home_filled, size: 30, color: _page == 1 ? kPrimaryDark : Colors.white),
          Icon(Icons.settings, size: 30, color: _page == 2 ?kPrimaryDark : Colors.white),
        ],
        color: kPrimaryColor,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeIn,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 300), curve: Curves.ease);
          });
        },
        letIndexChange: (index) => true,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _page = index;
          });
        },
        children: <Widget>[
          Profile(),
          Home(),
          Setting(),
        ],
      ),
    );
  }
}

// Define your Screen1, Screen2, and Screen3 widgets here
