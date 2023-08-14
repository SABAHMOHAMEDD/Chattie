class MessagesModel {
  String? message;
  String? id;

  MessagesModel({
    required this.message,
    required this.id,
  });

  factory MessagesModel.fromJason(jasonData) {
    return MessagesModel(
      message: jasonData['message'],
      id: jasonData['id'],
    );
  }
}
