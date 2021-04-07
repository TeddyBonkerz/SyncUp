class UserModel {
  String uId;
  String firstName;
  String lastName;
  String email;
  String password;
  // String organizer;

  UserModel(
      {this.uId,
      this.firstName,
      this.lastName,
      // this.organizer,
      this.email,
      this.password});

  get getUId => this.uId;

  set setUId(uId) => this.uId = uId;

  get getFirstName => this.firstName;

  set setFirstName(firstName) => this.firstName = firstName;

  get getLastName => this.lastName;

  set setLastName(lastName) => this.lastName = lastName;

  get getEmail => this.email;

  set setEmail(email) => this.email = email;

  // get getOrganization => this.organizer;
  //
  // set setOrganization(organization) => this.organizer = organizer;

  get getPassword => this.password;

  set setPassword(password) => this.password = password;
}
