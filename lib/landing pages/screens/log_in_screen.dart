import 'package:flutter/material.dart';
import 'package:intel_traffic/Backend/cloud_firebase_methods.dart';
import 'package:intel_traffic/bottom_bar.dart';
import 'package:intel_traffic/landing%20page/screens/log_in_admin.dart';

class LogInScreen extends StatelessWidget {
  final TextEditingController phoneOrAadhaarController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LogInScreen({Key? key}) : super(key: key);

  Future<void> _login(BuildContext context) async {
    final String phoneOrAadhaar = phoneOrAadhaarController.text;
    final String password = passwordController.text;

    bool isSuccessful = await CloudFirestoreClass()
        .checkPasswordMatches(phoneOrAadhaar, password);

    if (isSuccessful) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => BottomBar(phoneOrEmail: phoneOrAadhaar),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid credentials'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 5, 143, 223),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Color.fromARGB(255, 10, 244, 158),
                Color.fromARGB(255, 5, 143, 223)
              ],
            ),
          ),
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 130),
                Stack(
                  children: [
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 13, 113, 196),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Color.fromARGB(255, 10, 244, 158),
                              blurRadius: 1,
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 40),
                        margin: const EdgeInsets.all(40),
                        child: Form(
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              const Text(
                                'User Log In',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontStyle: FontStyle.italic),
                              ),
                              const SizedBox(height: 25),
                              Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                    ),
                                    child: TextFormField(
                                      controller: phoneOrAadhaarController,
                                      decoration: const InputDecoration(
                                        hintText: 'Phone or Aadhaar Number',
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                    ),
                                    child: TextFormField(
                                      controller: passwordController,
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                        hintText: 'Password',
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 36),
                                  ElevatedButton(
                                    onPressed: () => _login(context),
                                    child: Text('Log In'),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Are you an Admin?',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (ctx) =>
                                                  const AdminLogInScreen(),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          'Login Here',
                                          style: TextStyle(
                                              color: Colors.lightBlue),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 120,
                      top: 0,
                      child: Image(
                        image: NetworkImage(
                            'https://i.ibb.co/6YTL0W4/logo-project.jpg'),
                        fit: BoxFit.cover,
                        width: 137,
                        height: 37,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.mail,
                          size: 40, color: Colors.lightBlue.shade50),
                    ),
                    const SizedBox(width: 160),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.link,
                          size: 40, color: Colors.lightBlue.shade50),
                    )
                  ],
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
