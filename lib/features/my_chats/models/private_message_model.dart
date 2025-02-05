class PrivateMessageModel {
  String? message;
  String? senderId;
  String? receiverId;
  String? dateTime;

  PrivateMessageModel(
      {this.message, this.senderId, this.receiverId, this.dateTime});

  factory PrivateMessageModel.fromJason(jasonData) {
    return PrivateMessageModel(
      message: jasonData['message'],
      senderId: jasonData['senderId'],
      receiverId: jasonData['receiverId'],
      dateTime: jasonData['dateTime'],
    );
  }

  Map<String, dynamic> toJason() {
    return {
      'message': message,
      'senderId': senderId,
      'receiverId': receiverId,
      'dateTime': dateTime,
    };
  }
}
