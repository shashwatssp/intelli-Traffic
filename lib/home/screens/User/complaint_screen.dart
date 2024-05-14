import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import your CaseModel class
import 'package:intel_traffic/Backend/cloud_firebase_methods.dart';
import 'package:intel_traffic/Backend/models/complaint_model.dart'; // Import the function to fetch cases

class UserComplaints extends ConsumerStatefulWidget {
  final String aadharOrPhone;

  const UserComplaints({
    Key? key,
    required this.aadharOrPhone,
  }) : super(key: key);

  @override
  _UserComplaintsState createState() => _UserComplaintsState();
}

class _UserComplaintsState extends ConsumerState<UserComplaints> {
  late Future<List<ComplaintModel>> _casesFuture; // Declare future variable

  @override
  void initState() {
    super.initState();
    _casesFuture = CloudFirestoreClass().fetchUserComplaints(
        widget.aadharOrPhone); // Call function to fetch cases
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Complaints'),
      ),
      body: FutureBuilder<List<ComplaintModel>>(
        future: _casesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<ComplaintModel>? cases = snapshot.data;
            if (cases != null && cases.isNotEmpty) {
              return ListView.builder(
                itemCount: cases.length,
                itemBuilder: (BuildContext context, int index) {
                  final currentCase = cases[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.brown.shade400,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Aadhar/Phone: ${currentCase.aadharOrPhone}',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Subject: ₹${currentCase.subject}',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Complaint: ${currentCase.complaint}',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),

                            // Add more case details as needed
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text('No active cases found.'));
            }
          }
        },
      ),
    );
  }
}
