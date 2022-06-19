import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:integration_test/integration_test.dart';

import '../lib/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<void> navigateToFeature() async {

  }

  tearDown(() async {
    // Reset dependencies for each test
    final getIt = GetIt.instance;

    await getIt.reset();
  });

  group('FEATURE Navigation Test', () {
    testWidgets("""
      Should be able to navigate to the given page
      """,
        (tester) async {
      // arrange
      app.main();
      await tester.pumpAndSettle();

      // act
      await navigateToFeature();

      // assert
    }, skip: true,
    tags: ["integrationtest","FEATURE","navigationtest"]);
  });

  group('FEATURE Acceptance Tests', () {
    testWidgets("""
      As a *User*
      I want *Benefit*
      Because of *Reason*
      """,
        (tester) async {
      // arrange
      app.main();
      await tester.pumpAndSettle();
      await navigateToFeature();

      // act

      // assert
    }, skip: true,
    tags: ["integrationtest","FEATURE","acceptance"]);
  });
  group('FEATURE Penetration Tests', () {
    testWidgets("""
      As an *Hacker*
      I will try *Attack*
      Because of *Reason*
      """,
        (tester) async {
      // arrange
      app.main();
      await tester.pumpAndSettle();
      await navigateToFeature();

      // act

      // assert
    }, skip: true,
    tags: ["integrationtest","FEATURE","penetration"]);
  });
}