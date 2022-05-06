import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:washee/core/washee_box/washee_entity.dart';
import 'package:washee/core/washee_box/washee_model.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  test(
    'should be a subclass of WasheeBox entity',
    () async {
      // arrange
      final tWasheeBoxModel =
          WasheeBoxModel(ssid: "test1", name: "testName", machines: []);

      // assert
      expect(tWasheeBoxModel, isA<WasheeBox>());
    },
  );
  test(
    'should return a valid WasheeBoxModel from json',
    () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture("washeeBox.json"));
      final tWasheeBoxModel =
          WasheeBoxModel(ssid: "test1", name: "testName", machines: []);

      // act
      final result = WasheeBoxModel.fromJson(jsonMap);

      // assert
      expect(result, tWasheeBoxModel);
    },
  );
}
