import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// class MockUSECASE_NAME extends Mock implements USECASE_NAME {}

void main() {

  void userPresses(String buttonText){

  }

  void userScrolls(String direction){

  }

  void userWrites(String text,{required String at}){
    
  }
  
  group("TEST_WIDGET USE_CASE",() {
    testWidgets(
      """
        Should XXX
        When YYY
        Given ZZZ
      """,
      (tester) async {
        // arrange

        // navigate
  
        // act
  
        // assert
    }, skip: true,
    tags: ["widgettest","FEATURE_NAME","widgets"]);
  });
}