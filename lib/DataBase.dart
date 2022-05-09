import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

final database = FirebaseDatabase(
        databaseURL:
            "https://bshare-a25c4-default-rtdb.asia-southeast1.firebasedatabase.app/")
    .ref();
final userTable = database.child('UsersInfo/');
final FirebaseAuth _auth = FirebaseAuth.instance;

Future<int> register(
    String username, String email, String password, String major) async {
  //String text
  try {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    await userTable.child(_auth.currentUser!.uid).set({
      'password': password,
      'major': major,
      'email': email,
      'username': username,
    });
    return 1;
  } on FirebaseAuthException catch (singUpError) {
    if (singUpError.code.contains('email-already-in-use')) {
      return 2;
    }
  }
  return 1;
}

Future<String> getUserData(String dataKey) async {
  final User? _user = await _auth.currentUser!;
  String userId = _user!.uid;
  String dataValue;

  DataSnapshot? result = await userTable.child('$userId/$dataKey').get();
  dataValue = result.value.toString();

  return dataValue;
}

Future<User?> logIn(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    User? user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    getUserData('username');

    if (user != null) {
      return user;
    } else {
      print("Login failed");
      return user;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future logOut() async {
  try {
    await _auth.signOut();
  } catch (e) {
    print("error");
    print(e);
  }
}
