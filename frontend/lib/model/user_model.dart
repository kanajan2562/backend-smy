class UserModel {
  final int id;
  final String nameuser;
  final String email;
  final String password;
  final String type;
  final String token;

  set id(int _id) {
    id = _id;
  }

  set nameuser(String _nameuser) {
    nameuser = _nameuser;
  }

  set email(String _email) {
    email = _email;
  }

  set password(String _password) {
    password = _password;
  }

  set type(String _type) {
    type = _type;
  }

  set token(String _token) {
    token = _token;
  }

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nameuser = json['nameuser'],
        email = json['email'],
        password = json['password'],
        type = json['type'],
        token = json['token'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nameuser'] = this.nameuser;
    data['email'] = this.email;
    data['password'] = this.password;
    data['type'] = this.type;
    data['token'] = this.token;

    return data;
  }
}
