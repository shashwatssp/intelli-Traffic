import 'package:flutter/material.dart';
import 'package:intel_traffic/home/screens/Admin/chauraha_screen.dart';
import 'package:intel_traffic/home/screens/live_footage.dart';
import 'package:intel_traffic/landing%20pages/screens/log_in_admin.dart';

class homeDrawerForAdmin extends StatelessWidget {
  const homeDrawerForAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blue.shade400,
      child: Center(
        child: Column(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://images.pexels.com/photos/1031698/pexels-photo-1031698.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Align the Column vertically
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Admin',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'id : 217XXXXXXX',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),

            // PlayVideoPage
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => ChaurahaListPage(),
                  ),
                );
              },
              child: const ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                leading: Icon(
                  Icons.tv,
                  size: 30,
                ),
                title: Text(
                  'Live Footage',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),

            ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              leading: Icon(
                Icons.person_2_outlined,
                size: 30,
              ),
              title: Text(
                'Account',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            ListTile(
              onTap: () {
                //changeScreenToNotification(context);
              },
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              leading: Icon(
                Icons.notifications_active_outlined,
                size: 30,
              ),
              title: Text(
                'Notification',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            ListTile(
              onTap: () {
                // changeScreenToSettingsScreen(context);
              },
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              leading: Icon(
                Icons.settings_outlined,
                size: 30,
              ),
              title: Text(
                'Settings',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            ListTile(
              onTap: () {
                //changeScreenToTransactionScreen(context);
              },
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              leading: Icon(
                Icons.wallet_outlined,
                size: 30,
              ),
              title: Text(
                'Payments',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            ListTile(
              onTap: () {
                //changeScreenToLanguage(context);
              },
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              leading: Icon(
                Icons.language_outlined,
                size: 30,
              ),
              title: Text(
                'Language',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            const ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              leading: Icon(
                Icons.chat_outlined,
                size: 30,
              ),
              title: Text(
                'Ask a Question',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => AdminLogInScreen(),
                  ),
                );
              },
              child: const ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                leading: Icon(
                  Icons.logout,
                  size: 30,
                ),
                title: Text(
                  'Log Out',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
