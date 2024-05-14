import 'package:flutter/material.dart';

class FormBox extends StatelessWidget {
  const FormBox({super.key, required this.labelFormText});
  final String labelFormText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(80)),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: labelFormText,
            labelStyle: TextStyle(color: Colors.grey, fontSize: 20)),
        expands: false,
      ),
    );
  }
}

class FormBox2 extends StatelessWidget {
  const FormBox2(
      {Key? key, required this.labelFormText, required this.controller})
      : super(key: key);

  final String labelFormText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: controller, // Assigning the controller here
        decoration: InputDecoration(
          labelText: labelFormText,
          labelStyle: const TextStyle(color: Colors.grey, fontSize: 16),
        ),
      ),
    );
  }
}

class FormBox3 extends StatelessWidget {
  final String labelFormText;
  final TextEditingController controller;

  const FormBox3({
    Key? key,
    required this.labelFormText,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200, // Adjust the height as needed
      decoration: BoxDecoration(
        color: Colors.white, // Set the background color to white
        borderRadius: BorderRadius.circular(8), // Add border radius
        border: Border.all(color: Colors.grey), // Add border
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: controller,
        maxLines: 6, // Set the maximum number of lines
        decoration: InputDecoration(
          border: InputBorder.none, // Remove the border
        ),
      ),
    );
  }
}
