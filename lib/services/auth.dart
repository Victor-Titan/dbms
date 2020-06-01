import 'package:dbms/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  //create user object based on FirebaseUser

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }
  //everytime sign in/out(or auth change) happens, we'll get a response down the stream, and mapping it into the app's user, which is returned here
  Stream<User> get user {
    return _auth.onAuthStateChanged
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);  //both lines do the same thing
  }

  //sign in anon
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future signInAnon() async {
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }




  //sign in with email and password

  //register with email and password

  //signout

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }

}