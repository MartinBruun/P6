import 'package:washee/core/network/network_info.dart';
import 'package:washee/features/recommendation/data/datasources/recommendation_remote.dart';
import 'package:washee/features/recommendation/data/models/recommendation_model.dart';
import 'package:washee/features/recommendation/domain/repositories/recommendation_repository.dart';

class RecommendationRepoImpl implements RecommendationRepository {
  final NetworkInfo networkInfo;
  final RecommendationRemote remote;

  RecommendationRepoImpl({required this.networkInfo, required this.remote});

  @override
  Future<RecommendationModel> getRecommendation() async {
    return await remote.getRecommendation();
  }
}
