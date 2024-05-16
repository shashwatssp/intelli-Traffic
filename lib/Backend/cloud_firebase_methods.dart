import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intel_traffic/Backend/models/case_model.dart';
import 'package:intel_traffic/Backend/models/complaint_model.dart';
import 'package:intel_traffic/Backend/models/feedback_model.dart';
import 'package:intel_traffic/Backend/models/user_details_model.dart';

class CloudFirestoreClass {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _usersCollection = 'users';

  Future<String> uploadCaseToDatabase({
    required String speeding,
    required String runningRedLight,
    required String illegalParking,
    required String noSeatBelt,
    required String tripling,
    required String personName,
    required String personUid,
    required int fineAmount,
  }) async {
    personName.trim();
    speeding.trim();
    String output = "Something went wrong";

    if (personName != "" && fineAmount != 0) {
      try {
        String uid = getUid();
        CaseModel caseModel = CaseModel(
          speeding: speeding,
          runningRedLight: runningRedLight,
          illegalParking: illegalParking,
          noSeatBelt: noSeatBelt,
          tripling: tripling,
          personName: personName,
          personUid: personUid,
          fineAmount: fineAmount,
        );

        await firebaseFirestore
            .collection("cases")
            .doc(uid)
            .set(caseModel.getJson());
        output = "success";
      } catch (e) {
        output = e.toString();
      }
    } else {
      output = "Please make sure all the fields are not empty";
    }

    return output;
  }

  Future<List<CaseModel>> fetchCasesFromDatabase() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('cases').get();

      return querySnapshot.docs.map((doc) {
        return CaseModel(
          speeding: doc['speeding'],
          runningRedLight: doc['runningRedLight'],
          illegalParking: doc['illegalParking'],
          noSeatBelt: doc['noSeatBelt'],
          tripling: doc['tripling'],
          personName: doc['personName'],
          personUid: doc['personUid'],
          fineAmount: doc['fineAmount'],
        );
      }).toList();
    } catch (e) {
      print('Error fetching cases: $e');
      return []; // Return empty list on error
    }
  }

  Future<List<CaseModel>> fetchUserCasesFromDatabase(
      String aadharOrPhone) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('cases')
          .where('personUid', isEqualTo: aadharOrPhone)
          .get();

      return querySnapshot.docs.map((doc) {
        return CaseModel(
          speeding: doc['speeding'],
          runningRedLight: doc['runningRedLight'],
          illegalParking: doc['illegalParking'],
          noSeatBelt: doc['noSeatBelt'],
          tripling: doc['tripling'],
          personName: doc['personName'],
          personUid: doc['personUid'],
          fineAmount: doc['fineAmount'],
        );
      }).toList();
    } catch (e) {
      print('Error fetching cases: $e');
      return []; // Return empty list on error
    }
  }

  Future<String> uploadUserToDatabase({
    required String name,
    required String address,
    required String password,
    required String emailOrAadhaar,
    required String vehicleMaker,
    required String vehicleModel,
    required String vehicleYear,
    required String dieselOrPetrol,
    required String engineType,
  }) async {
    name.trim();
    address.trim();
    password.trim();
    emailOrAadhaar.trim();
    vehicleMaker.trim();
    vehicleModel.trim();
    vehicleYear.trim();
    dieselOrPetrol.trim();
    engineType.trim();

    String output = "Something went wrong";
    if (name.isNotEmpty &&
        address.isNotEmpty &&
        password.isNotEmpty &&
        emailOrAadhaar.isNotEmpty &&
        vehicleMaker.isNotEmpty &&
        vehicleModel.isNotEmpty &&
        vehicleYear.isNotEmpty &&
        dieselOrPetrol.isNotEmpty &&
        engineType.isNotEmpty) {
      try {
        UserDetailsModel user = UserDetailsModel(
          name: name,
          address: address,
          password: password,
          phoneOrAadhar: emailOrAadhaar,
          vehicleMaker: vehicleMaker,
          vehicleModel: vehicleModel,
          vehicleYear: vehicleYear,
          dieselOrPetrol: dieselOrPetrol,
          engineType: engineType,
        );

        String uid = emailOrAadhaar;

        await firebaseFirestore
            .collection(_usersCollection)
            .doc(uid)
            .set(user.getJson());

        output = "success";
      } catch (e) {
        output = e.toString();
      }
    } else {
      output = "Please fill up all the fields.";
    }
    return output;
  }

  Future<bool> checkPasswordMatches(
      String emailOrAadhaar, String password) async {
    try {
      DocumentSnapshot documentSnapshot = await _firestore
          .collection(_usersCollection)
          .doc(emailOrAadhaar) // Assuming emailOrAadhaar is the UID
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> userData =
            documentSnapshot.data() as Map<String, dynamic>;
        String storedPassword = userData['password'];

        if (storedPassword == password) {
          print('Password matched for user $emailOrAadhaar.');
          return true;
        } else {
          print('Password does not match for user $emailOrAadhaar.');
          return false;
        }
      } else {
        print('User $emailOrAadhaar not found.');
        return false;
      }
    } catch (e) {
      print('Error checking password matches: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>?> getUserDetails(String phoneOrAadhaar) async {
    try {
      DocumentSnapshot documentSnapshot = await _firestore
          .collection(_usersCollection)
          .doc(phoneOrAadhaar) // Assuming phoneOrAadhaar is the UID
          .get();

      if (documentSnapshot.exists) {
        return documentSnapshot.data() as Map<String, dynamic>;
      } else {
        print('User $phoneOrAadhaar not found.');
        return null;
      }
    } catch (e) {
      print('Error getting user details: $e');
      return null;
    }
  }

  String getUid() {
    return (100000 + Random().nextInt(10000)).toString();
  }

  Future<List<ComplaintModel>> fetchUserComplaints(String userName) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('complaints')
          .where('aadharOrPhone', isEqualTo: userName)
          .get();

      return querySnapshot.docs.map((doc) {
        return ComplaintModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Error fetching user complaints: $e');
      return [];
    }
  }

  Future<List<ComplaintModel>> fetchAllComplaints() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('complaints').get();

      return querySnapshot.docs.map((doc) {
        return ComplaintModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Error fetching all complaints: $e');
      return [];
    }
  }

  Future<String> uploadComplaintToDatabase({
    required String aadharOrPhone,
    required String subject,
    required String complaint,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('complaints').add({
        'aadharOrPhone': aadharOrPhone,
        'subject': subject,
        'complaint': complaint,
      });
      return 'success';
    } catch (e) {
      print('Error uploading complaint: $e');
      return 'Failed to upload complaint. Please try again later.';
    }
  }

  Future<String> fetchUserName(String phoneOrAadharNumber) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(phoneOrAadharNumber)
          .get();

      if (documentSnapshot.exists) {
        return documentSnapshot.get('name');
      } else {
        return ''; // Return empty string if user not found
      }
    } catch (e) {
      print('Error fetching user name: $e');
      return ''; // Return empty string on error
    }
  }

  Future<int> fetchNumberOfCases(String phoneOrAadharNumber) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('cases')
          .where('personUid', isEqualTo: phoneOrAadharNumber)
          .get();

      return querySnapshot.size;
    } catch (e) {
      print('Error fetching number of cases: $e');
      return 0; // Return 0 on error
    }
  }

  Future<int> fetchNumberOfComplaints(String phoneOrAadharNumber) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('complaints')
          .where('aadharOrPhone', isEqualTo: phoneOrAadharNumber)
          .get();

      return querySnapshot.size;
    } catch (e) {
      print('Error fetching number of complaints: $e');
      return 0; // Return 0 on error
    }
  }

  Future<List<CommunityFeedbackModel>> fetchAllFeedback() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('feedback').get();

      return querySnapshot.docs.map((doc) {
        return CommunityFeedbackModel.fromJson(
            doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Error fetching all feedback: $e');
      return [];
    }
  }

  Future<String> uploadFeedbackToDatabase(String feedback) async {
    try {
      await FirebaseFirestore.instance.collection('feedback').add({
        'feedback': feedback,
      });
      return 'success';
    } catch (e) {
      print('Error uploading feedback: $e');
      return 'Failed to upload feedback. Please try again later.';
    }
  }

  Future<String> uploadImageToDatabase({
    required File imageFile,
    required String phoneOrAadhar,
    required String type,
  }) async {
    try {
      String uid = getUid();

      // Upload image file to Firebase Storage
      Reference storageReference =
          FirebaseStorage.instance.ref().child('images/$uid');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      await uploadTask;

      // Get download URL of the uploaded image
      String imageURL = await storageReference.getDownloadURL();

      // Save image details to the 'images' collection
      await FirebaseFirestore.instance.collection("images").doc(uid).set({
        'image_url': imageURL,
        'phone_or_aadhar': phoneOrAadhar,
        'type': type,
      });

      return imageURL;
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }

  Future<String?> getPhoneOrAadharFromImageUrl(String imageUrl) async {
    try {
      // Query the 'images' collection based on the imageURL
      QuerySnapshot querySnapshot = await _firestore
          .collection('images')
          .where('image_url', isEqualTo: imageUrl)
          .limit(1) // Limit the result to 1 document
          .get();

      // Check if any document is found
      if (querySnapshot.docs.isNotEmpty) {
        // Extract and return the 'phone_or_aadhar' value
        return querySnapshot.docs.first.get('phone_or_aadhar') as String?;
      } else {
        // Return null if no document is found
        return null;
      }
    } catch (e) {
      print('Error fetching phone_or_aadhar: $e');
      return null; // Return null on error
    }
  }

  Future<bool> isAadhaarCardVerified(String phoneOrAadhar) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('images')
          .where('phone_or_aadhar', isEqualTo: phoneOrAadhar)
          .where('type', isEqualTo: 'AADHAAR CARD VERIFIED')
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking AADHAAR CARD verification: $e');
      return false;
    }
  }

  Future<bool> isDocVerified(String phoneOrAadhar, String type) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('images')
          .where('phone_or_aadhar', isEqualTo: phoneOrAadhar)
          .where('type', isEqualTo: '$type VERIFIED')
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking $type verification: $e');
      return false;
    }
  }

  Future<bool> isAadhaarCardFound(String phoneOrAadhar) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('images')
          .where('phone_or_aadhar', isEqualTo: phoneOrAadhar)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error finding AADHAAR CARD: $e');
      return false;
    }
  }

  Future<bool> isDocFound(String phoneOrAadhar, String type) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('images')
          .where('phone_or_aadhar', isEqualTo: phoneOrAadhar)
          .where('type', isEqualTo: type)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error finding $type : $e');
      return false;
    }
  }

  //.where('type', isEqualTo: '$type VERIFIED')

  Future<String?> fetchImage(String phoneOrAadhar) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('images')
          .where('phone_or_aadhar', isEqualTo: phoneOrAadhar)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first['image_url'];
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching image: $e');
      return "";
    }
  }

  Future<void> markDocumentAsVerified(String imageUrl) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('images')
          .where('image_url', isEqualTo: imageUrl)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        String documentId = documentSnapshot.id;
        String currentType = documentSnapshot['type'];

        await FirebaseFirestore.instance
            .collection('images')
            .doc(documentId)
            .update({'type': '$currentType VERIFIED'});
      } else {
        throw ('Document not found for image URL: $imageUrl');
      }
    } catch (e) {
      throw ('Error marking document as verified: $e');
    }
  }

  Future<List<String>> fetchImagesByType(String type) async {
    try {
      QuerySnapshot querySnapshot = await firebaseFirestore
          .collection('images')
          .where('type', isEqualTo: type)
          .get();

      List<String> imageUrls = querySnapshot.docs
          .map((doc) => doc.get('image_url') as String)
          .toList();

      return imageUrls;
    } catch (e) {
      print('Error fetching images: $e');
      return [];
    }
  }
}
