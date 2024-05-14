import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intel_traffic/home/screens/Admin/adminCategories.dart';
import 'package:intel_traffic/home/screens/Admin/homeDrawerForAdmin.dart';
import 'package:intel_traffic/home/widget/document_verification.dart';
import 'package:intel_traffic/home/widget/drawer.dart';
import 'package:intel_traffic/home/widget/grid_items.dart';
import 'package:intel_traffic/home/widget/image_content_home.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> photos = [
      "Fueling Road Safety through Tech Excellence.",
      "Tech for a Safer tommorow",
      "Our mission is Safer Roads"
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
              'Verify Documents',
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
            const AdminCategories(),
          ],
        ),
      ),
      drawer: homeDrawerForAdmin(),
    );
  }
}
