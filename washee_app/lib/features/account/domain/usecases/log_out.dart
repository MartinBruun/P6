import 'package:equatable/equatable.dart';
import 'package:washee/features/account/data/models/web_user.dart';
import 'package:washee/core/externalities/web/authorizer.dart';
import 'package:washee/core/standards/base_usecase/usecase.dart';
import 'package:washee/injection_container.dart';

class LogOutUseCase implements UseCase<void, LogoutParams> {
  LogOutUseCase();

  @override
  Future<void> call(LogoutParams params) async {
    // not allowed. Instead this needs to be called on the repo impl!
    await sl<Authorizer>().removeAllCredentials();
    params.user.logOut();
    return;
  }
}

class LogoutParams extends Equatable {
  final ActiveUser user;

  LogoutParams({
    required this.user,
  });

  @override
  List<Object?> get props => [user];
}
