import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import your CommunityFeedbackModel class
import 'package:intel_traffic/Backend/cloud_firebase_methods.dart';
import 'package:intel_traffic/Backend/models/feedback_model.dart'; // Import the function to fetch feedback

class AdminFeedbackScreen extends ConsumerStatefulWidget {
  const AdminFeedbackScreen({Key? key}) : super(key: key);

  @override
  _AdminFeedbackScreenState createState() => _AdminFeedbackScreenState();
}

class _AdminFeedbackScreenState extends ConsumerState<AdminFeedbackScreen> {
  late Future<List<CommunityFeedbackModel>>
      _feedbackFuture; // Declare future variable

  @override
  void initState() {
    super.initState();
    _feedbackFuture = CloudFirestoreClass()
        .fetchAllFeedback(); // Call function to fetch feedback
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Feedback'),
      ),
      body: FutureBuilder<List<CommunityFeedbackModel>>(
        future: _feedbackFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<CommunityFeedbackModel>? feedback = snapshot.data;
            if (feedback != null && feedback.isNotEmpty) {
              return ListView.builder(
                itemCount: feedback.length,
                itemBuilder: (BuildContext context, int index) {
                  final currentFeedback = feedback[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green.shade400,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Feedback: ${currentFeedback.feedback}',
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
              return const Center(child: Text('No feedback found.'));
            }
          }
        },
      ),
    );
  }
}
