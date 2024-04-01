import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:page_transition/page_transition.dart';

import 'Log_Sign/LogSign.dart';

class Bottom extends StatefulWidget {
  @override
  State<Bottom> createState() => _Bottom();
}

class _Bottom extends State<Bottom> {
  int _bottomNavIndex = 0;

  //List of the pages
  List<Widget> _widgetOptions() {
    return [
      // const HomeScreen(),
      // Settings(),
    ];
  }

  //List of the pages icons
  List<IconData> iconList = [
    Icons.home,
    Icons.settings, // Changed the person icon to settings icon
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _bottomNavIndex,
        children: _widgetOptions(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              child: LogSign(), // Navigate to BluetoothScreen
              type: PageTransitionType.bottomToTop,
            ),
          );
        },
        child: Icon(Icons.bluetooth, size: 35,), // Change the icon to Bluetooth
        backgroundColor: Color(0xFF006400),
        foregroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.green, // Adjust border color as needed
              width: 2.0, // Adjust border width as needed
            ),
          ),
        ),
        child: AnimatedBottomNavigationBar(
          splashColor: Color(0xff296e48),
          activeColor: Color(0xFF006400),
          inactiveColor: Colors.black.withOpacity(.5),
          icons: iconList,
          activeIndex: _bottomNavIndex,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.softEdge,
          iconSize: 38, // Increase the size of the icons
          onTap: (index) {
            setState(() {
              _bottomNavIndex = index;
            });
          },
        ),
      ),
    );
  }
}
