import 'package:flutter/material.dart';
import 'package:intel_traffic/Backend/cloud_firebase_methods.dart';
import 'package:intel_traffic/home/screens/Admin/adminHomeScreen.dart';
import 'package:intel_traffic/landing%20page/widgets/form_box.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController phoneOrAadhaarNoController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController vehicleMakerController = TextEditingController();
    TextEditingController vehicleModelController = TextEditingController();
    TextEditingController vehicleYearController = TextEditingController();
    TextEditingController dieselOrPetrolController = TextEditingController();
    TextEditingController engineTypeController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.black54,
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
              const Text(
                'Create a User',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 5),
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
                      child: Column(
                        children: [
                          FormBox2(
                            labelFormText: 'Name',
                            controller: nameController,
                          ),
                          FormBox2(
                            labelFormText: 'Address',
                            controller: addressController,
                          ),
                          FormBox2(
                            labelFormText: 'Phone or Aadhaar No.',
                            controller: phoneOrAadhaarNoController,
                          ),
                          FormBox2(
                            labelFormText: 'Password',
                            controller: passwordController,
                          ),
                          FormBox2(
                            labelFormText: 'Vehicle Maker',
                            controller: vehicleMakerController,
                          ),
                          FormBox2(
                            labelFormText: 'Vehicle Model',
                            controller: vehicleModelController,
                          ),
                          FormBox2(
                            labelFormText: 'Vehicle Year',
                            controller: vehicleYearController,
                          ),
                          FormBox2(
                            labelFormText: 'Diesel or Petrol',
                            controller: dieselOrPetrolController,
                          ),
                          FormBox2(
                            labelFormText: 'Engine Type',
                            controller: engineTypeController,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              SizedBox(
                                height: 20,
                                width: 20,
                                child: Checkbox(
                                  value: true,
                                  onChanged: (value) {},
                                ),
                              ),
                              const Expanded(
                                child: Text.rich(
                                  TextSpan(children: [
                                    TextSpan(
                                      text: 'I agree to ',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    TextSpan(
                                      text: 'Privacy policy ',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.lightBlueAccent,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'and ',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    TextSpan(
                                      text: 'Terms of use ',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.lightBlueAccent,
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () async {
                              String name = nameController.text;
                              String address = addressController.text;
                              String phoneOrAadhaarNo =
                                  phoneOrAadhaarNoController.text;
                              String password = passwordController.text;
                              String vehicleMaker = vehicleMakerController.text;
                              String vehicleModel = vehicleModelController.text;
                              String vehicleYear = vehicleYearController.text;
                              String dieselOrPetrol =
                                  dieselOrPetrolController.text;
                              String engineType = engineTypeController.text;

                              if (name.isEmpty ||
                                  address.isEmpty ||
                                  phoneOrAadhaarNo.isEmpty ||
                                  password.isEmpty ||
                                  vehicleMaker.isEmpty ||
                                  vehicleModel.isEmpty ||
                                  vehicleYear.isEmpty ||
                                  dieselOrPetrol.isEmpty ||
                                  engineType.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('Please fill all fields.'),
                                ));
                              } else {
                                // Call signUpUser function

                                String result = await CloudFirestoreClass()
                                    .uploadUserToDatabase(
                                  name: name,
                                  address: address,
                                  emailOrAadhaar: phoneOrAadhaarNo,
                                  password: password,
                                  vehicleMaker: vehicleMaker,
                                  vehicleModel: vehicleModel,
                                  vehicleYear: vehicleYear,
                                  dieselOrPetrol: dieselOrPetrol,
                                  engineType: engineType,
                                );
                                print(result);

                                if (result == "success") {
                                  // Navigate to home screen
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AdminHomeScreen(),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(result),
                                  ));
                                }
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
                                'Create Account',
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
