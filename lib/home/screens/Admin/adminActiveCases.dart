import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intel_traffic/Backend/models/case_model.dart'; // Import your CaseModel class
import 'package:intel_traffic/Backend/cloud_firebase_methods.dart'; // Import the function to fetch cases

class AdminActiveCaseScreen extends ConsumerStatefulWidget {
  const AdminActiveCaseScreen({Key? key}) : super(key: key);

  @override
  _AdminActiveCaseScreenState createState() => _AdminActiveCaseScreenState();
}

class _AdminActiveCaseScreenState extends ConsumerState<AdminActiveCaseScreen> {
  late Future<List<CaseModel>> _casesFuture; // Declare future variable

  @override
  void initState() {
    super.initState();
    _casesFuture = CloudFirestoreClass()
        .fetchCasesFromDatabase(); // Call function to fetch cases
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Cases'),
      ),
      body: FutureBuilder<List<CaseModel>>(
        future: _casesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<CaseModel>? cases = snapshot.data;
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
                              'Speeding: ${currentCase.speeding}',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Penalty: ₹${currentCase.fineAmount}',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Aadhar/Phone: ${currentCase.personUid}',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Running Red Light: ${currentCase.runningRedLight}',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Illegal Parking: ${currentCase.illegalParking}',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'No Seat Belt: ${currentCase.noSeatBelt}',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Tripling: ${currentCase.tripling}',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Person Name: ${currentCase.personName}',
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
