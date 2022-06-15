import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:washee/features/account/presentation/provider/account_language_provider.dart';

void main() {
  group("AccountLanguageProvider shownText",() {
    test(
      """
        Should have an english and danish translation for all the shown text
      """,
      () async {
      // arrange
      AccountLanguageProvider testProvider = AccountLanguageProvider();
      // act
      // assert
      testProvider.shownText.forEach(
        (widgetKey, widgetValue) { 
          widgetValue.forEach((key,value) {
            List listOfLanguages = value.keys.toList();
            expect(listOfLanguages[0], "english");
            expect(listOfLanguages[1], "danish");
        });
      });
    },
    tags: ["unittest","account","providers"]);
  });
}