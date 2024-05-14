import 'package:flutter/material.dart';
import 'package:intel_traffic/Backend/cloud_firebase_methods.dart';
import 'package:intel_traffic/home/screens/Admin/adminHomeScreen.dart';
import 'package:intel_traffic/landing%20page/widgets/form_box.dart';

class CreateCaseScreen extends StatelessWidget {
  const CreateCaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController speedingController = TextEditingController();
    TextEditingController runningRedLightController = TextEditingController();
    TextEditingController illegalParkingController = TextEditingController();
    TextEditingController noSeatBeltController = TextEditingController();
    TextEditingController triplingController = TextEditingController();
    TextEditingController personNameController = TextEditingController();
    TextEditingController personUidController = TextEditingController();
    TextEditingController fineAmountController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.black54,
        title: const Text('Create a Case'),
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
                              labelFormText: 'Speeding',
                              controller: speedingController,
                            ),
                            const SizedBox(height: 2),
                            FormBox2(
                              labelFormText: 'Running Red Light',
                              controller: runningRedLightController,
                            ),
                            const SizedBox(height: 4),
                            FormBox2(
                              labelFormText: 'Illegal Parking',
                              controller: illegalParkingController,
                            ),
                            const SizedBox(height: 8),
                            FormBox2(
                              labelFormText: 'No Seat Belt',
                              controller: noSeatBeltController,
                            ),
                            const SizedBox(height: 8),
                            FormBox2(
                              labelFormText: 'Tripling',
                              controller: triplingController,
                            ),
                            const SizedBox(height: 8),
                            FormBox2(
                              labelFormText: 'Vehicle Number',
                              controller: personNameController,
                            ),
                            const SizedBox(height: 8),
                            FormBox2(
                              labelFormText: 'Persons Phone or Aadhar Number',
                              controller: personUidController,
                            ),
                            const SizedBox(height: 8),
                            FormBox2(
                              labelFormText: 'Fine Amount',
                              controller: fineAmountController,
                            ),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: () async {
                                String speeding = speedingController.text;
                                String runningRedLight =
                                    runningRedLightController.text;
                                String illegalParking =
                                    illegalParkingController.text;
                                String noSeatBelt = noSeatBeltController.text;
                                String tripling = triplingController.text;
                                String personName = personNameController.text;
                                String personUid = personUidController.text;
                                int fineAmount =
                                    int.tryParse(fineAmountController.text) ??
                                        0;

                                String result = await CloudFirestoreClass()
                                    .uploadCaseToDatabase(
                                  speeding: speeding,
                                  runningRedLight: runningRedLight,
                                  illegalParking: illegalParking,
                                  noSeatBelt: noSeatBelt,
                                  tripling: tripling,
                                  personName: personName,
                                  personUid: personUid,
                                  fineAmount: fineAmount,
                                );
                                print(result);

                                if (result == "success") {
                                  // Case created successfully
                                  // Perform any additional actions here
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AdminHomeScreen(),
                                    ),
                                  );
                                } else {
                                  // Case creation failed
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
                                  'Create Case',
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
