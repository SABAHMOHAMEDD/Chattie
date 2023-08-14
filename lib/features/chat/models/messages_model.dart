class MessagesModel {
  String? message;
  String? id;
  String? userName;

  MessagesModel({
    required this.message,
    required this.id,
    required this.userName,
  });

  factory MessagesModel.fromJason(jasonData) {
    return MessagesModel(
      message: jasonData['message'],
      id: jasonData['id'],
      userName: jasonData['userName'],
    );
  }
}
