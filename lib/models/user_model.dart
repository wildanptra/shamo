class UserModel {
  late int id;
  late String name;
  late String email;
  late String username;
  late String profilePhotoUrl;
  late String? token;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.profilePhotoUrl,
    required this.token
  });

  UserModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    profilePhotoUrl = json['profile_photo_url'];
    token = json['token'];
  }

  Map<String, dynamic> toJson(){
    return {
      'id'    : id,
      'name'  : name,
      'email' : email,
      'username' : username,
      'profile_photo_url': profilePhotoUrl,
      'token' : token,
    };
  }
}