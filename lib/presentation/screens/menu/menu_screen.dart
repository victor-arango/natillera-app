import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:natillera_app/config/colors/customColors.dart';
import 'package:natillera_app/presentation/screens/home/home_screen.dart';
import 'package:natillera_app/presentation/screens/settings/settings_screen.dart';

import '../../../config/colors/colors.dart';


class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _currentIndex = 0;

  void _handleIndexChanged(int i) {
    setState(() {
      _currentIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          HomeScreen(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 0, left: 50,right: 50),
        
        child: DotNavigationBar(
          enablePaddingAnimation: true,
          currentIndex: _currentIndex,
          duration: const Duration(milliseconds: 205),
          curve: Curves.bounceInOut,
          dotIndicatorColor: Colors.orange,
          selectedItemColor: Colors.orange,
          unselectedItemColor: getColorBasedOnTheme(
              context, CustomColors.textWhite, CustomColors.textWhite),
          enableFloatingNavBar: true,
          onTap: _handleIndexChanged,
          backgroundColor: getColorBasedOnTheme(
              context, CustomColors.bellGrey, CustomColors.menuGreyLight),
          items: [
            DotNavigationBarItem(
              icon: const Icon(Icons.person),
              selectedColor: MyColors.buttonColor,
            ),
            DotNavigationBarItem(
              icon: const Icon(Icons.settings),
              selectedColor: MyColors.buttonColor,
            ),
          ],
        ),
      ),
    );
  }
}
