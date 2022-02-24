import 'package:washee/features/recommendation/data/models/recommendation_model.dart';
import 'package:http/http.dart' as http;

abstract class RecommendationRemote {
  Future<RecommendationModel> getRecommendation();
}

class RecommendationRemoteImpl implements RecommendationRemote {
  final http.Client client;
  RecommendationRemoteImpl({required this.client});

  @override
  Future<RecommendationModel> getRecommendation() {
    return Future.delayed(Duration(seconds: 3)).then((value) =>
        new RecommendationModel(recommendationType: "recommendationType"));
  }
}
