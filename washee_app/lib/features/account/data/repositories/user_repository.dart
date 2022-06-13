

import 'package:path/path.dart';
import 'package:washee/features/account/data/datasources/user_remote.dart';
import 'package:washee/features/account/data/models/web_user_model.dart';
import 'package:washee/features/account/domain/entities/user_entity.dart';

abstract class IUserRepository {
  late UserEntity currentUser;
  Future<UserEntity> getUser(int userId);
  Future<List<UserEntity>> getUsers(Map<String,dynamic> valuesToGet);
  Future<UserEntity> postUser(UserEntity userEntity);
  Future<UserEntity> updateUser(UserEntity userEntity, Map<String,dynamic> valuesToUpdate);
  Future<UserEntity> deleteUser(UserEntity userEntity);
  Future<UserEntity> signIn(String username, String password);
  Future<UserEntity> autoSignIn();
}

class UserRepository extends IUserRepository{
  late IWebUserRemote webRemote;
  late UserEntity currentUser;

  UserRepository({required this.webRemote}){
    currentUser = UserEntity.anonymousUser();
  }

  @override
  Future<UserEntity> deleteUser(UserEntity userEntity) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> getUser(int userId) {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<List<UserEntity>> getUsers(Map<String, dynamic> valuesToGet) {
    // TODO: implement getUsers
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> postUser(UserEntity userEntity) {
    // TODO: implement postUser
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> updateUser(UserEntity userEntity, Map<String, dynamic> valuesToUpdate) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> signIn(String username, String password) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> autoSignIn() async {
    Map<String,dynamic>? userAsJson = await webRemote.autoSignIn();
    if(userAsJson.isEmpty){
      currentUser = UserEntity.anonymousUser();
      currentUser.loggedIn = false;
    }
    else{
      currentUser = WebUserModel.fromJson(userAsJson);
      currentUser.loggedIn = true;
    }
    return currentUser;
  }
}