import 'package:flutter/material.dart';
import 'package:washee/features/account/domain/entities/user_entity.dart';

class UserProvider extends ChangeNotifier {
  UserEntity currentUser;

  UserProvider({required this.currentUser});
}
