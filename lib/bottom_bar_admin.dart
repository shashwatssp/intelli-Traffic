import 'package:flutter/material.dart';
import 'package:intel_traffic/home/screens/Admin/adminHomeScreen.dart';
import 'package:intel_traffic/home/screens/homeScreen.dart';

class bottomBarAdmin extends StatefulWidget {
  const bottomBarAdmin({super.key});

  @override
  State<bottomBarAdmin> createState() => _bottomBarState();
}

class _bottomBarState extends State<bottomBarAdmin> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const AdminHomeScreen(),
    const AdminHomeScreen(),
    const AdminHomeScreen(),
  ];
  void pageUpdate(int a) {
    setState(() {
      _page = a;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color.fromARGB(255, 136, 194, 242),
        backgroundColor: Colors.blue.shade400,
        iconSize: 28,
        onTap: pageUpdate,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              child: const Icon(Icons.person_2_outlined),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              child: const Icon(Icons.video_collection_outlined),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              child: const Icon(Icons.history_outlined),
            ),
            label: "",
          ),
        ],
      ),
    );
  }
}
