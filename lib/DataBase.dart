import 'package:firebase_database/firebase_database.dart';

final database = FirebaseDatabase(
        databaseURL:
            "https://bshare-a25c4-default-rtdb.asia-southeast1.firebasedatabase.app/")
    .ref();
final userTable = database.child('UsersInfo/');

Future<void> register(String username, String email, String password,
    String university, String major) async {
  //String text
  try {
    await userTable.child(username).set({
      'password': password,
      'University': university,
      'major': major,
    });
    print('users info added successfull');
  } catch (e) {
    print('you got an error $e');
  }
}
