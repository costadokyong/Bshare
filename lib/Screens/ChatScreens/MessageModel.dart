class ChatMessage {
  String messageContent;
  String messageType;
  final DateTime timeStamp;

  ChatMessage(
      {required this.messageContent,
      required this.messageType,
      required this.timeStamp});

  factory ChatMessage.fromRTDB(Map<String, dynamic> data) {
    return ChatMessage(
        messageContent: data['messageText'] ?? 'no Messages',
        messageType: data['messageType'] ?? 'no Type',
        timeStamp: (data['time'] != null)
            ? DateTime.fromMicrosecondsSinceEpoch(data['time'])
            : DateTime.now());
  }
}
