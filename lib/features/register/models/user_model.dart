class UserModel {
  String? name;
  String? email;
  String? uId;
  int? userBubbleColorId;

  UserModel({
    this.name,
    this.email,
    this.uId,
    this.userBubbleColorId,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : this(
          name: json['name'],
          email: json['email'],
          uId: json['uId'],
          userBubbleColorId: json['userBubbleColorId'],
        );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'uId': uId,
      'userBubbleColorId': userBubbleColorId,
    };
  }
}
