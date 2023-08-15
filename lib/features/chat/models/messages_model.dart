class MessagesModel {
  String? message;
  String? id;
  String? userName;
  int? userColor;

  MessagesModel({
    required this.message,
    required this.id,
    required this.userName,
    required this.userColor,
  });

  factory MessagesModel.fromJason(jasonData) {
    return MessagesModel(
      message: jasonData['message'],
      id: jasonData['id'],
      userName: jasonData['userName'],
      userColor: jasonData['userColor'],
    );
  }
}
