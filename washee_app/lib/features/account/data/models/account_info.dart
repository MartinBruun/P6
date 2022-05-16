class AccountInfo {
    factory AccountInfo() {
    return _singleton;
  }

  static AccountInfo _singleton = AccountInfo._internal();

  AccountInfo._internal();

}