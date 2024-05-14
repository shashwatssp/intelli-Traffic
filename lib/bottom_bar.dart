import 'package:flutter/material.dart';
import 'package:intel_traffic/home/screens/homeScreen.dart';

class BottomBar extends StatefulWidget {
  final String phoneOrEmail; // Add phoneOrEmail parameter

  const BottomBar({Key? key, required this.phoneOrEmail}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  late List<Widget> pages; // Declare pages list

  @override
  void initState() {
    super.initState();
    // Initialize pages list after widget is fully initialized
    pages = [
      HomeScreen(phoneOrAadhar: widget.phoneOrEmail),
      HomeScreen(phoneOrAadhar: widget.phoneOrEmail),
      HomeScreen(phoneOrAadhar: widget.phoneOrEmail),
    ];
  }

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
