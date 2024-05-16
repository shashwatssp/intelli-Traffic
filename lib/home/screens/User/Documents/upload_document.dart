import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intel_traffic/Backend/cloud_firebase_methods.dart';

class UploadDoc extends StatefulWidget {
  final String phoneOrAadhar;
  final String docType;

  const UploadDoc({
    Key? key,
    required this.phoneOrAadhar,
    required this.docType,
  }) : super(key: key);

  @override
  _UploadDocState createState() => _UploadDocState();
}

class _UploadDocState extends State<UploadDoc> {
  File? _image;
  String _verificationPending = "L";

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    checkVerificationStatus();
  }

  Future<void> checkVerificationStatus() async {
    bool verified = await CloudFirestoreClass()
        .isDocVerified(widget.phoneOrAadhar, widget.docType);

    if (verified) print("VERIFICATION_DONE");

    setState(() {
      _verificationPending = verified ? "NO" : "YES";
    });

    bool found = await CloudFirestoreClass()
        .isDocFound(widget.phoneOrAadhar, widget.docType);

    bool foundverified = await CloudFirestoreClass()
        .isDocFound(widget.phoneOrAadhar, widget.docType + " VERIFIED");

    found = found | foundverified;

    if (found) print("FOUND");

    if (!found) {
      setState(() {
        _verificationPending = "";
      });
    }
  }

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  void uploadImageToDatabase() {
    if (_image != null) {
      CloudFirestoreClass().uploadImageToDatabase(
        imageFile: _image!,
        phoneOrAadhar: widget.phoneOrAadhar,
        type: widget.docType,
      );

      setState(() {
        _verificationPending = "YES";
      });
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _verificationPending == ""
              ? 'Upload ${widget.docType}'
              : '${widget.docType} Verification',
          style: TextStyle(fontSize: 17), // Adjust the font size as needed
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              if (_verificationPending == "" && _image != null)
                Container(
                  height: 200,
                  child: Image.file(_image!),
                ),
              SizedBox(height: 20),
              if (_verificationPending == "NO")
                Text('${widget.docType} HAS BEEN VERIFIED.'),
              if (_verificationPending == "L") Text('Loading ...'),
              if (_verificationPending == "YES")
                Text('${widget.docType} VERIFICATION IS PENDING.'),
              SizedBox(height: 20),
              if (_verificationPending == "")
                Center(
                  child: ElevatedButton(
                    onPressed: getImage,
                    child: const Text('Select Image'),
                  ),
                ),
              SizedBox(height: 10),
              if (_verificationPending == "")
                Center(
                  child: ElevatedButton(
                    onPressed: uploadImageToDatabase,
                    child: const Text('Upload Image'),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
