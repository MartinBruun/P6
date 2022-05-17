import 'package:equatable/equatable.dart';

// The base usecase all UseCases inherit from

abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
