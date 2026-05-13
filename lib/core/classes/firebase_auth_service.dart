import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<User?> signUpWithEmailAndPassword(
      String email,
      String password,
      String phone,
      String firstName,
      String lastName,
      int gender,
      String age,
      int selectedLang,
      List<String> chosenHobbies,
      int chosenMainGoal,
      int currentAccent) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      String uid = userCredential.user!.uid;

      var usersCollection = FirebaseFirestore.instance.collection('Users');

      await usersCollection.add({
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'gender': gender,
        'age': age,
        'selectedLang': selectedLang,
        "chosenHobbies": chosenHobbies,
        "chosenMainGoal": chosenMainGoal,
        "targetedAccent": 1,
        'email': email,
        'uid': uid,
        'currentAccent': currentAccent
      });

      // await FirebaseFirestore.instance.collection('Users').doc(uid).set({});

      print('User registered successfully!');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<Map<String, dynamic>?> logInUsingEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get user ID
      String uid = userCredential.user!.uid;

      // Retrieve user data from Firestore
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();

      if (!userDoc.exists) {
        print('User data not found!');
        return null;
      }

      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

      // Get Firebase Auth token
      String token = await userCredential.user!.getIdToken() ?? "";

      userData['token'] = token; // Add token to user data

      return userData;
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }

  Future<bool> isEmailAlreadyRegistered(String email) async {
    try {
      List<String> signInMethods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

      return signInMethods.isNotEmpty;
    } catch (e) {
      print('Error checking email: $e');
      return false;
    }
  }
}
