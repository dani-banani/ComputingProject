class UserData {
  final String userId;

  UserData({required this.userId});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(userId: json['uid'] ?? "");
  }
}

