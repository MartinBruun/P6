import 'package:washee/features/recommendation/data/models/recommendation_model.dart';

abstract class RecommendationRepository {
  Future<RecommendationModel> getRecommendation();
}
