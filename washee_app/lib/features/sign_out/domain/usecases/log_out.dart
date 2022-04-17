import 'package:equatable/equatable.dart';
import 'package:washee/core/account/user.dart';
import 'package:washee/core/helpers/authorizer.dart';
import 'package:washee/core/usecases/usecase.dart';
import 'package:washee/injection_container.dart';

class LogOutUseCase implements UseCase<void, LogoutParams> {

  LogOutUseCase();

  @override
  Future<void> call(LogoutParams params) async {
    await sl<Authorizer>().removeAllCredentials();
    params.user.logOut();
    params.updatePage();
    return;
  }
}

class LogoutParams extends Equatable {
  final Function updatePage;
  final ActiveUser user;
  

  LogoutParams({required this.user, required this.updatePage});

  @override
  List<Object?> get props => [user];
}