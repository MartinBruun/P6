import 'package:flutter/material.dart';
import 'package:washee/core/account/user.dart';
import 'package:washee/features/Account/presentation/log_in_button.dart';
import 'package:washee/features/Account/presentation/user_info.dart';

class LogInStatus extends StatefulWidget {
  const LogInStatus({ Key? key }) : super(key: key);

  @override
  State<LogInStatus> createState() => _LogInStatusState();
}

class _LogInStatusState extends State<LogInStatus> {
  ActiveUser user = ActiveUser();
  
  @override
  Widget build(BuildContext context) {
    return user.loggedIn ? 
    UserInfo() : 
    LogInButton();
    
  }
}