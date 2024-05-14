import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final Map<String, dynamic> userData; // Store user data

  // Constructor to initialize user data
  const ProfileScreen({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              'Owner Name: ${userData['name']}', // Display owner name
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            _buildInfoItem(
                'Address:', userData['address']), // Display vehicle make

            const SizedBox(height: 10),
            const SizedBox(height: 20),
            Text(
              'Vehicle Information:',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildInfoItem('Vehicle Make:',
                userData['vehicleMaker']), // Display vehicle make
            _buildInfoItem('Vehicle Model:',
                userData['vehicleModel']), // Display vehicle model
            _buildInfoItem('Vehicle Year:', userData['vehicleYear']),
            _buildInfoItem('Diesel or Petrol:', userData['dieselOrPetrol']),
            _buildInfoItem('Engine Type:', userData['engineType']),
            // Display vehicle year
            const SizedBox(height: 20),
            Text(
              'Documents:',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildDocumentItem('Driver\'s License'),
            _buildDocumentItem('Vehicle Registration'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your edit button functionality here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
              ),
              child: const Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentItem(String documentName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          const Icon(Icons.description),
          const SizedBox(width: 10),
          Text(
            documentName,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
