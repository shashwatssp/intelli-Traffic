import 'package:flutter/material.dart';
import 'package:intel_traffic/Backend/cloud_firebase_methods.dart'; // Import the necessary functions to fetch data

class HomeDrawer extends StatefulWidget {
  final String phoneOrAadharNumber;

  const HomeDrawer({
    Key? key,
    required this.phoneOrAadharNumber,
  }) : super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  String userName = ''; // To store the user's name
  int numberOfCases = 0; // To store the number of cases
  int numberOfComplaints = 0; // To store the number of complaints

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  // Function to fetch user data asynchronously
  Future<void> fetchUserData() async {
    try {
      // Fetch user name from the database
      userName =
          await CloudFirestoreClass().fetchUserName(widget.phoneOrAadharNumber);

      // Fetch number of cases
      numberOfCases = await CloudFirestoreClass()
          .fetchNumberOfCases(widget.phoneOrAadharNumber);

      // Fetch number of complaints
      numberOfComplaints = await CloudFirestoreClass()
          .fetchNumberOfComplaints(widget.phoneOrAadharNumber);

      setState(() {}); // Update the UI
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blue.shade400,
      child: Center(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://wallup.net/wp-content/uploads/2018/09/28/684893-color-pattern.jpg'),
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
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName.isNotEmpty
                              ? userName
                              : 'Loading...', // Display the user's name
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Phone/Aadhar: ${widget.phoneOrAadharNumber}', // Display the phone or Aadhar number
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Cases: $numberOfCases', // Display the number of cases
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Complaints: $numberOfComplaints', // Display the number of complaints
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    )
                  ],
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
            // Add other list tiles here

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
              leading: const Icon(
                Icons.language_outlined,
                size: 30,
              ),
              title: const Text(
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
          ],
        ),
      ),
    );
  }
}
