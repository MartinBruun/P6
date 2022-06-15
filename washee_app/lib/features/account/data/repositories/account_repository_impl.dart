

import 'package:washee/features/account/data/datasources/account_remote.dart';
import 'package:washee/features/account/data/models/web_account_model.dart';
import 'package:washee/features/account/domain/entities/account_entity.dart';

abstract class IAccountRepository {
  Future<AccountEntity> getAccount(int accountId);
  Future<List<AccountEntity>> getAccounts(Map<String,dynamic> valuesToGet);
  Future<AccountEntity> postAccount(AccountEntity accountEntity);
  Future<AccountEntity> updateAccunt(AccountEntity accountEntity, Map<String,dynamic> valuesToUpdate);
  Future<AccountEntity> deleteAccount(AccountEntity accountEntity);
}

class AccountRepository extends IAccountRepository{
  late IWebAccountRemote accountRemote;

  AccountRepository({required this.accountRemote});

  @override
  Future<AccountEntity> deleteAccount(AccountEntity accountEntity) {
    // TODO: implement deleteAccount
    throw UnimplementedError();
  }

  @override
  Future<AccountEntity> getAccount(int accountId) async {
    Map<String,dynamic> accountAsJson = await accountRemote.getAccount(accountId);
    AccountEntity accountEntity = WebAccountModel.fromJson(accountAsJson);
    return accountEntity;
  }

  @override
  Future<List<AccountEntity>> getAccounts(Map<String, dynamic> valuesToGet) {
    // TODO: implement getAccounts
    throw UnimplementedError();
  }

  @override
  Future<AccountEntity> postAccount(AccountEntity accountEntity) {
    // TODO: implement postAccount
    throw UnimplementedError();
  }

  @override
  Future<AccountEntity> updateAccunt(AccountEntity accountEntity, Map<String, dynamic> valuesToUpdate) {
    // TODO: implement updateAccunt
    throw UnimplementedError();
  }
}