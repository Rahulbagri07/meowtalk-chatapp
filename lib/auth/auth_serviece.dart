import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServiece{
  //instance of auth
  final FirebaseAuth userAuth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  User? getCurruntUsre(){
    return userAuth.currentUser;
  }
  //login
  Future<UserCredential> signInWithEmailPassword(String email, password) async{
    try{
      UserCredential userCredential = await userAuth.signInWithEmailAndPassword(
          email: email, password: password);

      fireStore.collection("Users").doc(userCredential.user!.uid).set(
          {
            'uid': userCredential.user!.uid,'email':email
          }
      );

      return userCredential;
    }on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
  //signup

  Future<UserCredential> signUpWithEmailPassword(String email,password)async{
    try{
      UserCredential userCredential = await userAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      fireStore.collection("Users").doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid,'email':email
        }
      );
      return userCredential;
    }on FirebaseAuthException catch (e){
      throw Exception(e.code);
    }
  }
  //logout
  Future<void> signOut()async{
    return await userAuth.signOut();
  }
}