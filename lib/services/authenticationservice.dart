import 'package:firebase_auth/firebase_auth.dart';
import 'package:syncup/models/userModel.dart';
import 'package:syncup/services/DatabaseService.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  UserModel _userFromFirebaseUser(User user) {
    return user != null ? UserModel(uId: user.uid) : null;
  }

  Stream<UserModel> get user {
    return _firebaseAuth
        .authStateChanges()
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      await DatabaseService(uId: user.uid).getOrganizer();
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password,
      String firstName, String lastName, String organizer) async {
    try {
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      // create a new document for the user with the uid
      // await DatabaseService(uid: user.uid)
      //     .updateUserData('0', 'new crew member', 100);
      await DatabaseService(
              uId: user.uid,
              firstName: firstName,
              lastName: lastName,
              organizer: organizer)
          .createUserData();
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
