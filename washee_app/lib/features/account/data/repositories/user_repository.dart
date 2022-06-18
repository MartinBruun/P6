
import 'package:washee/features/account/data/datasources/user_remote.dart';
import 'package:washee/features/account/data/models/web_user_model.dart';
import 'package:washee/features/account/domain/entities/user_entity.dart';

abstract class IUserRepository {
  Future<UserEntity> getUser(int userId);
  Future<List<UserEntity>> getUsers(Map<String,dynamic> valuesToGet);
  Future<UserEntity> postUser(UserEntity userEntity);
  Future<UserEntity> updateUser(UserEntity userEntity, Map<String,dynamic> valuesToUpdate);
  Future<UserEntity> deleteUser(UserEntity userEntity);
  Future<UserEntity> signIn(String username, String password);
  Future<UserEntity> signOut(UserEntity userLoggingOut);
  Future<UserEntity> autoSignIn();
}

class UserRepository extends IUserRepository{
  late IWebUserRemote userRemote;

  UserRepository({required this.userRemote});

  @override
  Future<UserEntity> deleteUser(UserEntity userEntity) async {
    Map<String,dynamic> userAsJson = await userRemote.deleteUser(userEntity.id);
    UserEntity result = WebUserModel.fromJson(userAsJson);
    return result;
  }

  @override
  Future<UserEntity> getUser(int userId) async {
    Map<String,dynamic> userAsJson = await userRemote.getUser(userId);
    UserEntity result = WebUserModel.fromJson(userAsJson);
    return result;
  }

  @override
  Future<List<UserEntity>> getUsers(Map<String, dynamic> valuesToGet) async {
    List<Map<String,dynamic>> userListAsJson = await userRemote.getUsers(valuesToGet);
    List<UserEntity> userList = [];
    for(Map<String,dynamic> userJson in userListAsJson){
      userList.add(WebUserModel.fromJson(userJson));
    }
    return userList;
  }

  @override
  Future<UserEntity> postUser(UserEntity userEntity) async {
    WebUserModel serializableUser = WebUserModel.fromEntity(userEntity);
    Map<String,dynamic> userAsJson = await userRemote.postUser(serializableUser.toJson());
    UserEntity result = WebUserModel.fromJson(userAsJson);
    return result;
  }

  @override
  Future<UserEntity> updateUser(UserEntity userEntity, Map<String, dynamic> valuesToUpdate) async {
    Map<String,dynamic> userAsJson = await userRemote.updateUser(userEntity.id, valuesToUpdate);
    UserEntity result = WebUserModel.fromJson(userAsJson);
    return result;
  }

  @override
  Future<UserEntity> signIn(String username, String password) async {
    Map<String,dynamic> userAsJson = await userRemote.signIn(username, password);
    UserEntity result = WebUserModel.fromJson(userAsJson);
    return result;
  }

  @override
  Future<UserEntity> signOut(UserEntity userLoggingOut) async {
    // TODO: Should probably also send a request to the backend, so it get notified the user is logged out!
    UserEntity signedOutUser = UserEntity.anonymousUser();
    return signedOutUser;
  }

  @override
  Future<UserEntity> autoSignIn() async {
    Map<String,dynamic> userAsJson = await userRemote.autoSignIn();
    UserEntity currentUser = userAsJson.isEmpty ? UserEntity.anonymousUser() : WebUserModel.fromJson(userAsJson);
    return currentUser;
  }
}