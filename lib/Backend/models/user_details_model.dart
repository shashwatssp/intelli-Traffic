class UserDetailsModel {
  final String name;
  final String address;
  final String password;
  final String phoneOrAadhar;
  final String vehicleMaker;
  final String vehicleModel;
  final String vehicleYear;
  final String dieselOrPetrol;
  final String engineType;

  UserDetailsModel({
    required this.name,
    required this.address,
    required this.password,
    required this.phoneOrAadhar,
    required this.vehicleMaker,
    required this.vehicleModel,
    required this.vehicleYear,
    required this.dieselOrPetrol,
    required this.engineType,
  });

  Map<String, dynamic> getJson() => {
        'name': name,
        'address': address,
        'password': password,
        'phoneOrAadhar': phoneOrAadhar,
        'vehicleMaker': vehicleMaker,
        'vehicleModel': vehicleModel,
        'vehicleYear': vehicleYear,
        'dieselOrPetrol': dieselOrPetrol,
        'engineType': engineType,
      };

  factory UserDetailsModel.getModelFromJson(Map<String, dynamic> json) {
    return UserDetailsModel(
      name: json["name"],
      address: json["address"],
      password: json["password"],
      phoneOrAadhar: json["phoneOrAadhar"],
      vehicleMaker: json["vehicleMaker"],
      vehicleModel: json["vehicleModel"],
      vehicleYear: json["vehicleYear"],
      dieselOrPetrol: json["dieselOrPetrol"],
      engineType: json["engineType"],
    );
  }
}
