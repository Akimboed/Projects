  import 'package:firebase_auth/firebase_auth.dart';

  class Auth {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    // Method to get the current user
    User? getCurrentUser() {
      return _firebaseAuth.currentUser;
    }

    // Method to sign in the user
    Future<UserCredential> signIn(String email, String password) async {
      try {
        UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        return userCredential;
      } on FirebaseAuthException catch (e) {
        throw Exception(e.code);
      }
    }

    // Method to sign up the user
    Future<UserCredential> signUp(String email, String password) async {
      try {
        UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        return userCredential;
      } on FirebaseAuthException catch (e) {
        throw Exception(e.code);
      }
    }

    // Method to sign out the user
    Future<void> signOut() async {
      return _firebaseAuth.signOut();
    }
  }


  //
  // import 'package:firebase_auth/firebase_auth.dart';
  //
  // class Auth{
  //   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //
  //   User? getCurentUser(){
  //     return _firebaseAuth.currentUser;
  //   }
  //   Future<UserCredential>signIn(String email, password) async {
  //     try{
  //       UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  //       return userCredential;
  //
  //     }on FirebaseAuthException catch (e){
  //       throw Exception(e.code);
  //     }
  //   }
  //   Future<UserCredential>signUp(String email, password) async {
  //     try{
  //       UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  //       return userCredential;
  //
  //     }on FirebaseAuthException catch (e){
  //       throw Exception(e.code);
  //     }
  //   }
  //   Future<void>signOut() async{
  //     return _firebaseAuth.signOut();
  // }
  //
  // }