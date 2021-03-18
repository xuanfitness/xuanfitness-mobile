class User{
  String id, firstName, lastName, email;
  User(this.id, this.firstName, this.lastName, this.email);
  User.fromJson(Map<String, dynamic>json):
        id = json["id"],
        firstName = json["firstName"],
        lastName = json["lastName"],
        email = json["email"];
}