class User {
  String username;
  String accessToken;
  String did;

  User.fromMap(String userName, Map<String, dynamic> data) {
    accessToken = data['accessToken'];
    did = data['did'];
    username = userName;
  }
}
