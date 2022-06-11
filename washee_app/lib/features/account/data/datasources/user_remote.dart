

abstract class IWebUserRemote{
  Future<Map<String,dynamic>> getUser(int userId);
  Future<List<Map<String,dynamic>>> getUsers(Map<String,dynamic> valuesToGet);
  Future<Map<String,dynamic>> postUser(Map<String,dynamic> userAsJson);
  Future<Map<String,dynamic>> updateUser(Map<String,dynamic> userAsJson, Map<String,dynamic> valuesToUpdate);
  Future<Map<String,dynamic>> deleteUser(Map<String,dynamic> userAsJson);
}

class WebUserRemote extends IWebUserRemote{
  @override
  Future<Map<String, dynamic>> deleteUser(Map<String, dynamic> userAsJson) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> getUser(int userId) {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> getUsers(Map<String, dynamic> valuesToGet) {
    // TODO: implement getUsers
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> postUser(Map<String, dynamic> userAsJson) {
    // TODO: implement postUser
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> updateUser(Map<String, dynamic> userAsJson, Map<String, dynamic> valuesToUpdate) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

}