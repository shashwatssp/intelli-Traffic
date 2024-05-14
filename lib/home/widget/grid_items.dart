import 'package:flutter/material.dart';
import 'package:intel_traffic/Backend/cloud_firebase_methods.dart';
import 'package:intel_traffic/common/active_cases.dart';
import 'package:intel_traffic/home/screens/complaint_raise_screen.dart';
import 'package:intel_traffic/home/screens/profileScreen.dart';
import 'package:intel_traffic/home/screens/uploadFeedBackScreen.dart';
import 'package:intel_traffic/home/widget/Category_grid_items.dart';
import 'package:intel_traffic/utils.dart';

class Categories extends StatefulWidget {
  final String emailOrPhone; // Add emailOrPhone parameter

  const Categories({Key? key, required this.emailOrPhone}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    void changeScreenToActiveCase() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => UserActiveCases(aadharOrPhone: widget.emailOrPhone),
        ),
      );
    }

    void changeScreenToComplaint() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => CreateComplaintScreen(),
        ),
      );
    }

    void changeScreenToFeedback() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => UploadFeedbackScreen(),
        ),
      );
    }

    void changeScreenToProfile(String emailOrPhone) async {
      Map<String, dynamic>? userData =
          await CloudFirestoreClass().getUserDetails(emailOrPhone);

      print(userData);

      if (userData != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => ProfileScreen(userData: userData),
          ),
        );
      } else {
        // Handle case where user data is not found
        print('User data not found for $emailOrPhone.');
      }
    }

    final List<Function> list = [
      () => changeScreenToProfile(widget
          .emailOrPhone), // Pass a closure that calls the function with emailOrPhone
      changeScreenToActiveCase,
      changeScreenToComplaint,
      changeScreenToFeedback,
      changeScreenToActiveCase,
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 0.7),
      itemCount: 5,
      itemBuilder: (context, index) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return GestureDetector(
              onTap: () {
                list[index]();
              },
              child: CategoryGridItems(
                imageUrl: gridImageLink[index],
                text: gridName[index],
                size: constraints,
              ),
            );
          },
        );
      },
    );
  }
}
