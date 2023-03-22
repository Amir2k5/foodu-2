class Users {
  late String uid;
  late String? userName;
  late String? userEmail;
  late String? userPassword;
  late String? userNickname;
  late String? userBirthday;
  late String? userGender;
  late String? userImage;
  late Map<String, List<String?>>? userData;

  Users({
    required this.uid,
    this.userName,
    this.userNickname,
    this.userBirthday,
    this.userEmail,
    this.userPassword,
    this.userGender,
    this.userImage,
    this.userData,
  });
  Map<String, dynamic> toMap() {
    {
      return {
        'uid': uid,
        'userName': userName,
        'userNickname': userNickname,
        'userBirthday': userBirthday,
        'userEmail': userEmail,
        'userPassword': userPassword,
        'userGender': userGender,
        'userImage': userImage,
        'userData': userData,
      };
    }
  }

  Users.fromMap(Map<String, dynamic> map) {
    uid = map['uid'];
    userName = map['userName'];
    userNickname = map['userNickname'];
    userBirthday = map['userBirthday'];
    userEmail = map['userEmail'];
    userPassword = map['userPassword'];
    userGender = map['userGender'];
    userImage = map['userImage'];
    userData = (map['userData'] as Map<String, dynamic>?)?.map((key, value) =>
        MapEntry(key, value is List ? List<String>.from(value) : <String>[]));
  }
}
