import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intel_traffic/Backend/models/complaint_model.dart'; // Import your ComplaintModel class
import 'package:intel_traffic/Backend/cloud_firebase_methods.dart'; // Import the function to fetch complaints

class AdminComplaintsScreen extends ConsumerStatefulWidget {
  const AdminComplaintsScreen({Key? key}) : super(key: key);

  @override
  _AdminComplaintsScreenState createState() => _AdminComplaintsScreenState();
}

class _AdminComplaintsScreenState extends ConsumerState<AdminComplaintsScreen> {
  late Future<List<ComplaintModel>>
      _complaintsFuture; // Declare future variable

  @override
  void initState() {
    super.initState();
    _complaintsFuture = CloudFirestoreClass()
        .fetchAllComplaints(); // Call function to fetch complaints
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Complaints'),
      ),
      body: FutureBuilder<List<ComplaintModel>>(
        future: _complaintsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<ComplaintModel>? complaints = snapshot.data;
            if (complaints != null && complaints.isNotEmpty) {
              return ListView.builder(
                itemCount: complaints.length,
                itemBuilder: (BuildContext context, int index) {
                  final currentComplaint = complaints[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red.shade400,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Aadhar/Phone: ${currentComplaint.aadharOrPhone}',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Subject: ${currentComplaint.subject}',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Complaint: ${currentComplaint.complaint}',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text('No complaints found.'));
            }
          }
        },
      ),
    );
  }
}
