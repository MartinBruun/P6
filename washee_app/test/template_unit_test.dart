import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// class MockName extends Mock implements ThingToMock {}

void main() {
  //late ThingToTest thingToTest;
  //late ThingToMock thingToMock;
  //late SomeModel fakeModel;

  setUp() {
    //thingToMock = ThingToMock();
    //thingToTest = ThingToTest(inject: thingToMock);
    //fakeModel = SomeModel()
  }
  test(
      """
        When ThingToTest is using methodUnderTest with X,
        it should return/do Y,
        given ThingToMock is assumed to properly have done Z/thrown SomeFailure due to Z.
      """,
      () async {
    // arrange
    setUp();
    // arrange values for the test 
    // (arrangedInput, expectedDependencyInput, dependencyOutput, in this example)

    // arrange (dependencies)
    // setup mock =>
    //when(() => thingToMock.method(expectedDependencyInput)
    //    .thenAnswer((_) async => expectedDependencyOutput));

    // act
    // final result = await thingToTest.methodUnderTest(arrangedInput);

    // assert
    // expect (result, expectedValue);

    // assert (dependencies)
    // verify(() => thingToMock.method(dependencyInput)).called(expectedTimesAsInt);
  });
}