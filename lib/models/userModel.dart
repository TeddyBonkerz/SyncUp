class UserModel {
  String uId;
  String firstName;
  String lastName;
  String email;
  String password;

  UserModel(
      {this.uId, this.firstName, this.lastName, this.email, this.password});

  get getUId => this.uId;

  set setUId(uId) => this.uId = uId;

  get getFirstName => this.firstName;

  set setFirstName(firstName) => this.firstName = firstName;

  get getLastName => this.lastName;

  set setLastName(lastName) => this.lastName = lastName;

  get getEmail => this.email;

  set setEmail(email) => this.email = email;

  get getPassword => this.password;

  set setPassword(password) => this.password = password;
}
