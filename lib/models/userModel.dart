class UserModel {
  String uId;
  String firstName;
  String lastName;
  String email;

  UserModel({this.uId, this.firstName, this.lastName, this.email});

  get getUId => this.uId;

  set setUId(uId) => this.uId = uId;

  get getFirstName => this.firstName;

  set setFirstName(firstName) => this.firstName = firstName;

  get getLastName => this.lastName;

  set setLastName(lastName) => this.lastName = lastName;
}
