class CaseModel {
  final String speeding;
  final String runningRedLight;
  final String illegalParking;
  final String noSeatBelt;
  final String tripling;
  final String personName;
  final String personUid;
  final int fineAmount;

  CaseModel({
    required this.speeding,
    required this.runningRedLight,
    required this.illegalParking,
    required this.noSeatBelt,
    required this.tripling,
    required this.personName,
    required this.personUid,
    required this.fineAmount,
  });

  Map<String, dynamic> getJson() {
    return {
      'speeding': speeding,
      'runningRedLight': runningRedLight,
      'illegalParking': illegalParking,
      'noSeatBelt': noSeatBelt,
      'tripling': tripling,
      'personName': personName,
      'personUid': personUid,
      'fineAmount': fineAmount,
    };
  }

  factory CaseModel.getModelFromJson(Map<String, dynamic> json) {
    return CaseModel(
      speeding: json["speeding"],
      runningRedLight: json["runningRedLight"],
      illegalParking: json["illegalParking"],
      noSeatBelt: json["noSeatBelt"],
      tripling: json["tripling"],
      personName: json["personName"],
      personUid: json["personUid"],
      fineAmount: json["fineAmount"],
    );
  }
}
