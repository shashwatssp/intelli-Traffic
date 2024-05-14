class CommunityFeedbackModel {
  final String feedback;

  CommunityFeedbackModel({
    required this.feedback,
  });

  Map<String, dynamic> toJson() {
    return {
      'feedback': feedback,
    };
  }

  factory CommunityFeedbackModel.fromJson(Map<String, dynamic> json) {
    return CommunityFeedbackModel(
      feedback: json['feedback'],
    );
  }
}
