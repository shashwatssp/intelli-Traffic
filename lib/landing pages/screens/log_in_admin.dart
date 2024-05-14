import 'package:flutter/material.dart';
import 'package:intel_traffic/bottom_bar_admin.dart';
import 'package:intel_traffic/landing%20page/widgets/function_button.dart';

class AdminLogInScreen extends StatelessWidget {
  const AdminLogInScreen({Key? key}) : super(key: key);

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
                // end: Alignment.bottomRight,
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
                  const SizedBox(
                    height: 130,
                  ),
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
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Admin Log In',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontStyle: FontStyle.italic),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
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
                                    child: const TextField(
                                      decoration: InputDecoration(
                                          hintText: 'Phone or Aadhaar Number',
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                    ),
                                    child: const TextField(
                                      decoration: InputDecoration(
                                          hintText: 'Password',
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 36,
                                  ),
                                  const FunctionButton(
                                      landingScreen: bottomBarAdmin(),
                                      textForButton: 'Log In'),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const Positioned(
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
                      const SizedBox(
                        height: 20,
                      )
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
                      const SizedBox(
                        width: 160,
                      ),
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
                  const SizedBox(
                    height: 60,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
