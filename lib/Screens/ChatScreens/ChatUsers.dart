// ignore_for_file: empty_constructor_bodies

class ChatUsers {
  String username;
  //String messageText;
  String userId;
  //String time;
  String lastMessage;

  ChatUsers(
      {required this.username,
      //required this.messageText,
      required this.userId,
      //required this.time
      required this.lastMessage});

  factory ChatUsers.fromRTDB(Map<String, dynamic> data) {
    return ChatUsers(
        username: data['contactUsername'] ?? 'Unknow',
        userId: data['contactID'] ?? 'Unknow',
        lastMessage: data['lastMessage'] ?? '');
  }
}
