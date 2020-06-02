import 'package:flutter/material.dart';
import 'package:ml_text_recognition/camerapage.dart';

import 'package:ml_text_recognition/src/todo/HomeSetter.dart';
import 'package:ml_text_recognition/src/todo/crop/image_editor.dart';
import 'package:ml_text_recognition/src/ui/camera/camera.dart';
import 'package:ml_text_recognition/src/todo/custom_widget.dart';

import 'package:ml_text_recognition/src/todo/temp_screen.dart';
import 'package:persistent_bottom_nav_bar/models/persisten-bottom-nav-item.widget.dart';
import 'package:persistent_bottom_nav_bar/models/persistent-bottom-nav-bar-styles.widget.dart';
import 'package:persistent_bottom_nav_bar/models/persistent-nav-bar-scaffold.widget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.widget.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Persistent Bottom Navigation Bar example project',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: HomeSetter(),
    );
  }
}

class MyHome extends StatefulWidget {
  MyHome({Key key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);

  }

  List<Widget> _buildScreens() {
    return [
      Temp(),
      Camera(),
      Temp(),

    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.refresh),
        title: (" "),
        activeColor: Colors.pinkAccent,
        inactiveColor: Colors.grey,
        isTranslucent: false,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: (" "),
        activeColor: Colors.pinkAccent,
        inactiveColor: Colors.grey,
        isTranslucent: false,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: (" "),
        activeColor: Colors.pinkAccent,
        inactiveColor: Colors.grey,
        isTranslucent: false,
      ),

    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
        controller: _controller,
        screens: _buildScreens(),
        items:
        _navBarsItems(), // Redundant here but defined to demonstrate for other than custom style
        confineInSafeArea: true,
        backgroundColor: Colors.white,

        handleAndroidBackButtonPress: true,
        iconSize: 40,
        onItemSelected: (int) {
          setState(
                  () {}); // This is required to update the nav bar if Android back button is pressed
        },
        customWidget: CustomNavBarWidget(
          items: _navBarsItems(),
          onItemSelected: (index) {
            setState(() {
              _controller.index = index; // THIS IS CRITICAL!! Don't miss it!
            });
          },
          selectedIndex: _controller.index,
        ),
        itemCount: 3,
        navBarStyle:
        NavBarStyle.style3 // Choose the nav bar style with this property
    );
  }
}
