import '../../domain/entities/recommendation.dart';

class RecommendationModel extends Recommendation {
  final String recommendationType;

  RecommendationModel({required this.recommendationType})
      : super(recommendationType: recommendationType);

  @override
  List<Object?> get props => [recommendationType];

  factory RecommendationModel.fromJSON(Map<String, dynamic> json) {
    return RecommendationModel(recommendationType: json['recommendationType']);
  }
}
