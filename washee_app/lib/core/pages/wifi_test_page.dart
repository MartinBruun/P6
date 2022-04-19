import 'package:flutter/material.dart';
import 'package:washee/core/errors/error_handler.dart';
import 'package:washee/core/errors/http_error_prompt.dart';
import 'package:washee/core/presentation/themes/colors.dart';
import 'package:washee/core/presentation/themes/dimens.dart';
import 'package:washee/core/presentation/themes/themes.dart';
import 'package:washee/injection_container.dart';

import '../../features/unlock/domain/usecases/connect_box_wifi.dart';
import '../usecases/usecase.dart';

class TestWifiPage extends StatefulWidget {
  TestWifiPage({Key? key}) : super(key: key);

  @override
  State<TestWifiPage> createState() => _TestWifiPageState();
}

class _TestWifiPageState extends State<TestWifiPage> {
  bool _connected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      body: Column(
        children: [
          Center(
            child: Container(
              child: Text(
                _connected ? "CONNECTED" : "NOT CONNECTED",
                style: textStyle.copyWith(fontSize: textSize_29),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                var result = await sl<ConnectBoxWifiUsecase>().call(NoParams());
                if (!result) {
                  ErrorHandler.errorHandlerView(
                      context: context,
                      prompt: HTTPErrorPrompt(
                          message: "Vi kunne ikke finde boxen!!"));
                }
                setState(() {
                  _connected = result;
                });
              },
              child: Text("Connect"))
        ],
      ),
    );
  }
}
