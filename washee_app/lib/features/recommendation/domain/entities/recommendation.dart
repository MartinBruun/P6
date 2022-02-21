import 'package:equatable/equatable.dart';

class Recommendation extends Equatable {
  final String recommendationType;

  Recommendation({required this.recommendationType});

  @override
  List<Object?> get props => [recommendationType];
}
