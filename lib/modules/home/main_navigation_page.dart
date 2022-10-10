// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:top_bantz_2/constants/custom_colors.dart';
import 'package:top_bantz_2/modules/home/earn_coin_page.dart';
import 'package:top_bantz_2/modules/home/explore_page.dart';
import 'package:top_bantz_2/modules/home/settings_page.dart';
import 'package:top_bantz_2/modules/home/standings_page.dart';
import 'package:top_bantz_2/repositories/user_repository.dart';

import 'home_page.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({
    Key? key,
    required this.userRepository,
  }) : super(key: key);
  final UserRepository userRepository;

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
  }

  Widget bodyWidgets({required int index}) {
    final List<Widget> _pages = <Widget>[
      HomePage(
        userRepository: widget.userRepository,
      ),
      ExplaorePage(),
      EarnCoinPage(userRepository: widget.userRepository),
      StandingsPage(),
      Settings(
        userRepository: widget.userRepository,
      ),
    ];
    return _pages.elementAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.backGroundColor,
        body: bodyWidgets(index: _selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: (newIndex) {
            setState(() {
              _selectedIndex = newIndex;
            });
          },
          backgroundColor: CustomColors.backGroundColor,
          showUnselectedLabels: false,
          showSelectedLabels: true,
          unselectedItemColor: CustomColors.foreGroundColor,
          selectedItemColor: CustomColors.textYellowColor,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.explicit_outlined), label: 'Explore'),
            BottomNavigationBarItem(
                icon: Icon(Icons.currency_pound), label: 'Earn Coin'),
            BottomNavigationBarItem(
                icon: Icon(Icons.grading_sharp), label: 'Standings'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings')
          ],
        ),
      ),
    );
  }
}
