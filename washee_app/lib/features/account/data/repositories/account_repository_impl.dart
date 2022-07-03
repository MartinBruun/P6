

import 'package:washee/features/account/data/datasources/web_account_remote.dart';
import 'package:washee/features/account/data/models/web_account_model.dart';
import 'package:washee/features/account/domain/entities/account_entity.dart';

abstract class IAccountRepository {
  Future<AccountEntity> getAccount(int accountId);
  Future<List<AccountEntity>> getAccounts(Map<String,dynamic> valuesToGet);
  Future<AccountEntity> postAccount(AccountEntity accountEntity);
  Future<AccountEntity> updateAccount(AccountEntity accountEntity, Map<String,dynamic> valuesToUpdate);
  Future<AccountEntity> deleteAccount(AccountEntity accountEntity);
}

class AccountRepository extends IAccountRepository{
  late IWebAccountRemote accountRemote;

  AccountRepository({required this.accountRemote});

  @override
  Future<AccountEntity> deleteAccount(AccountEntity accountEntity) async {
    Map<String,dynamic> accountAsJson = await accountRemote.deleteAccount(accountEntity.id);
    AccountEntity result = WebAccountModel.fromJson(accountAsJson);
    return result;
  }

  @override
  Future<AccountEntity> getAccount(int accountId) async {
    Map<String,dynamic> accountAsJson = await accountRemote.getAccount(accountId);
    AccountEntity accountEntity = WebAccountModel.fromJson(accountAsJson);
    return accountEntity;
  }

  @override
  Future<List<AccountEntity>> getAccounts(Map<String, dynamic> valuesToGet) async {
    List<Map<String,dynamic>> accountsAsJson = await accountRemote.getAccounts(valuesToGet);
    List<AccountEntity> accountsList = [];
    for(Map<String,dynamic> account in accountsAsJson){
      accountsList.add(WebAccountModel.fromJson(account));
    }
    return accountsList;
  }

  @override
  Future<AccountEntity> postAccount(AccountEntity accountEntity) async {
    WebAccountModel serializableAccount = WebAccountModel.fromEntity(accountEntity);
    Map<String,dynamic> accountAsJson = await accountRemote.postAccount(serializableAccount.toJson());
    AccountEntity newAccount = WebAccountModel.fromJson(accountAsJson);
    return newAccount;
  }

  @override
  Future<AccountEntity> updateAccount(AccountEntity accountEntity, Map<String, dynamic> valuesToUpdate) async {
    Map<String,dynamic> accountAsJson = await accountRemote.updateAccount(accountEntity.id, valuesToUpdate);
    AccountEntity newAccount = WebAccountModel.fromJson(accountAsJson);
    return newAccount;
  }
}