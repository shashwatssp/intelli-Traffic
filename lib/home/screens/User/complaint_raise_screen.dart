import 'package:flutter/material.dart';
import 'package:intel_traffic/Backend/cloud_firebase_methods.dart';
import 'package:intel_traffic/home/screens/Admin/adminHomeScreen.dart';
import 'package:intel_traffic/landing%20page/widgets/form_box.dart';

class CreateComplaintScreen extends StatelessWidget {
  const CreateComplaintScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController aadharOrPhoneController = TextEditingController();
    TextEditingController subjectController = TextEditingController();
    TextEditingController complaintController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.black54,
        title: const Text('Create a Complaint'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [Color.fromARGB(255, 34, 107, 192), Colors.blue.shade400],
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[900],
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.blue.shade800,
                          blurRadius: 4,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    margin: const EdgeInsets.all(10),
                    child: Form(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            FormBox2(
                              labelFormText: 'Aadhar/Phone',
                              controller: aadharOrPhoneController,
                            ),
                            const SizedBox(height: 8),
                            FormBox2(
                              labelFormText: 'Subject',
                              controller: subjectController,
                            ),
                            const SizedBox(height: 8),
                            // Make the complaint box 5 times bigger
                            SizedBox(
                              height: 200, // Adjust the height as needed
                              child: FormBox3(
                                labelFormText: 'Complaint',
                                controller: complaintController,
                              ),
                            ),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: () async {
                                String aadharOrPhone =
                                    aadharOrPhoneController.text;
                                String subject = subjectController.text;
                                String complaint = complaintController.text;

                                String result = await CloudFirestoreClass()
                                    .uploadComplaintToDatabase(
                                  aadharOrPhone: aadharOrPhone,
                                  subject: subject,
                                  complaint: complaint,
                                );
                                print(result);

                                if (result == "success") {
                                  // Complaint created successfully
                                  // Perform any additional actions here
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AdminHomeScreen(),
                                    ),
                                  );
                                } else {
                                  // Complaint creation failed
                                  // Handle the error accordingly
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(result),
                                  ));
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Create Complaint',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}
