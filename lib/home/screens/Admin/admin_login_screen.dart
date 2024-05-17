import 'package:flutter/material.dart';
import 'package:intel_traffic/bottom_bar_admin.dart';
import 'package:intel_traffic/landingPages/widgets/function_button.dart';

class AdminLogInScreen extends StatefulWidget {
  const AdminLogInScreen({Key? key}) : super(key: key);

  @override
  _AdminLogInScreenState createState() => _AdminLogInScreenState();
}

class _AdminLogInScreenState extends State<AdminLogInScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (username == '1111' && password == '1111') {
      // Navigate to the admin dashboard
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => bottomBarAdmin()),
      );
    } else {
      // Show error message or perform other actions for invalid credentials
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Invalid Credentials'),
            content: Text('Please enter correct username and password.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 130),
                Stack(
                  children: [
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 13, 113, 196),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              color: Color.fromARGB(255, 10, 244, 158),
                              blurRadius: 1,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 40),
                        margin: const EdgeInsets.all(40),
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            const Text(
                              'Admin Log In',
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
                                  child: TextField(
                                    controller: _usernameController,
                                    decoration: const InputDecoration(
                                      hintText: 'Phone or Aadhaar Number',
                                      hintStyle: TextStyle(color: Colors.grey),
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
                                  child: TextField(
                                    controller: _passwordController,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      hintText: 'Password',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 36),
                                FunctionButton(
                                  onPressed: _login,
                                  textForButton: 'Log In',
                                ),
                                const SizedBox(height: 16),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 90,
                      top: 0,
                      child: Image(
                        image: AssetImage('assets/images/logo_new.jpg'),
                        fit: BoxFit.cover,
                        width: 186,
                        height: 50,
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
                      icon: Icon(
                        Icons.mail,
                        size: 40,
                        color: Colors.lightBlue.shade50,
                      ),
                    ),
                    const SizedBox(width: 160),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.link,
                        size: 40,
                        color: Colors.lightBlue.shade50,
                      ),
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
