import 'package:flutter/material.dart';
import 'package:intel_traffic/home/screens/Admin/adminActiveCases.dart';
import 'package:intel_traffic/home/screens/Admin/adminComplaints.dart';
import 'package:intel_traffic/home/screens/Admin/adminFeedBackScreen.dart';
import 'package:intel_traffic/home/widget/Category_grid_items.dart';
import 'package:intel_traffic/landing%20page/screens/create_case_screen.dart';
import 'package:intel_traffic/landing%20page/screens/register_screen.dart';
import 'package:intel_traffic/utils.dart';

class AdminCategories extends StatelessWidget {
  const AdminCategories({super.key});

  @override
  Widget build(BuildContext context) {
    void changeScreenToActiveCase() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const AdminActiveCaseScreen(),
        ),
      );
    }

    void changeScreenToCreateCase() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const CreateCaseScreen(),
        ),
      );
    }

    void changeScreenToAdminComplaintsScreen() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const AdminComplaintsScreen(),
        ),
      );
    }

    void changeScreenToAdminFeedback() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const AdminFeedbackScreen(),
        ),
      );
    }

    void createNewUser() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const RegisterScreen(),
        ),
      );
    }

    final List<Function> list = [
      changeScreenToActiveCase,
      changeScreenToAdminComplaintsScreen,
      createNewUser,
      changeScreenToCreateCase,
      changeScreenToAdminFeedback,
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
                imageUrl: adminGridImageLink[index],
                text: adminGridName[index],
                size: constraints,
              ),
            );
          },
        );
      },
    );
  }
}
