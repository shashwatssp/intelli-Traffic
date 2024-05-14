class ComplaintModel {
  final String aadharOrPhone;
  final String subject;
  final String complaint;

  ComplaintModel({
    required this.aadharOrPhone,
    required this.subject,
    required this.complaint,
  });

  Map<String, dynamic> toJson() {
    return {
      'aadharOrPhone': aadharOrPhone,
      'subject': subject,
      'complaint': complaint,
    };
  }

  factory ComplaintModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError('Provided JSON cannot be null');
    }
    return ComplaintModel(
      aadharOrPhone: json['aadharOrPhone'] ?? '',
      subject: json['subject'] ?? '',
      complaint: json['complaint'] ?? '',
    );
  }
}
