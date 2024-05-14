import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final String text;
  final String img;
  const ImageContainer({Key? key, required this.text, required this.img});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.blue.shade400,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(210.0),
          bottomLeft: Radius.circular(50),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: size.width * 0.5,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  text,
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(210.0),
              bottomLeft: Radius.circular(40),
            ),
            child: SizedBox(
              width: 180, // Adjust width as needed
              height: 80,
              child: Image.asset(
                img,
                fit: BoxFit.cover, // Ensure the image fits within the container
              ),
            ),
          ),
        ],
      ),
    );
  }
}
