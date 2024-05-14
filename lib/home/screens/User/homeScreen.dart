import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intel_traffic/home/widget/document_verification.dart';
import 'package:intel_traffic/home/widget/grid_items.dart';
import 'package:intel_traffic/home/widget/image_content_home.dart';

import '../widget/drawer.dart';

class HomeScreen extends StatefulWidget {
  final String phoneOrAadhar; // Define phoneOrAadhar as a final parameter

  const HomeScreen({Key? key, required this.phoneOrAadhar}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final List<String> photos = [
      widget.phoneOrAadhar,
      //"Drive like your loved ones are on the road with you.",
      "Safe driving isn't just about rules; it's about responsibility.",
      "Your destination can wait; safety cannot.",
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade400,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider.builder(
              itemCount: 3,
              options: CarouselOptions(
                height: 200,
                viewportFraction: 1,
              ),
              itemBuilder: (context, index, realIndex) {
                return ImageContainer(
                  text: photos[index],
                  img: "assets/images/car.png",
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Document Verification ',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 5,
            ),
            const TopCategories(),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Categories ',
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(
              height: 10,
            ),
            Categories(emailOrPhone: widget.phoneOrAadhar),
          ],
        ),
      ),
      drawer: HomeDrawer(
        phoneOrAadharNumber: widget.phoneOrAadhar,
      ),
    );
  }
}
