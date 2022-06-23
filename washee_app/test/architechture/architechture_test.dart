import 'dart:core';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;

void main() {

  Future<List<String>> upholdsArchitechture(File fileToCheck, Map<String,dynamic> layersAllowed) async {
    List<String> dependenciesBroken = [];

    List<String> fileContent = await fileToCheck.readAsLines();
    int i = 0;
    while(i < fileContent.length && !fileContent[i].contains("class ")){ // Runs until it hits a class in the sourcecode or EOF, since we are only interested in analyzing the packages at the start of the file
      if(fileContent[i].contains("injection_container.dart")){ // No code other than main may use the dependency injector!
        dependenciesBroken.add(fileContent[i]);
      }
      else if(fileContent[i].contains("import")){
        layersAllowed.forEach((layerName, layerAllowed) {
          if(layerAllowed ==  false){
            if(fileContent[i].contains("/"+layerName+"/")){ // Ie. the layer is importet in some way thereby breaking the architechture
              dependenciesBroken.add(fileContent[i]);
            }
          }
        });
      };
      i += 1;
    };
    return dependenciesBroken;
  }

  group("Architechture Check Core",() {
    test(
      """
        Should only depend on other packages in core.
        Core is used to standardize and generalize implementation details.
        It is therefore important it never gets muddled up with the features and actual business logic!
        If something needs to depend on something in the layers, it probably belong as part of that feature.
      """,
      () async {
      // arrange
      String filename = "SomeName";
      File file = File(filename);
      Map<String,dynamic> allowedDependencies = {
        "core": true,
        "datasources": false,
        "models": false,
        "repositories": false,
        "entities": false,
        "usecases": false,
        "providers": false,
        "pages": false,
        "widgets": false
      };

      // act
      List<String> dependenciesBroken = await upholdsArchitechture(file, allowedDependencies);

      // assert
      expect(dependenciesBroken, []);
    }, skip: true,
    tags: ["architechture", "core"]);
  });
  group("Architechture Check Datasources",() {
    test(
      """
        Should only be allowed to depend on core (not even other remotes!).
        Remotes handle raw data and the communication with datasources.
        It only serves as an intermediary, making sure the connection to the datasource is ok and works.
        It makes no interpretation of the data, other than converting it into 
        maybe a String or Map<String,dynamic> or other native, low level data representation
        Cross dependency between remotes is also confusing and should therefore be kept seperate.
      """,
      () async {
            // arrange
      String filename = "SomeName";
      File file = File(filename);
      Map<String,dynamic> allowedDependencies = {
        "core": true,
        "datasources": false,
        "models": false,
        "repositories": false,
        "entities": false,
        "usecases": false,
        "providers": false,
        "pages": false,
        "widgets": false
      };

      // act
      List<String> dependenciesBroken = await upholdsArchitechture(file, allowedDependencies);

      // assert
      expect(dependenciesBroken.isEmpty, true, reason: "Filename " + filename + " wrongly depends on " + dependenciesBroken.toString());
    }, skip: true,
    tags: ["architechture", "datasources"]);
  });
  group("Architechture Check Models",() {
    test(
      """
        Should only be allowed to depend on other models and core.
        A model is generally just a serializer transforming raw data received by the remote, into an entity type object.
      """,
      () async {
      // arrange
      String filename = "SomeName";
      File file = File(filename);
      Map<String,dynamic> allowedDependencies = {
        "core": true,
        "datasources": false,
        "models": true,
        "repositories": false,
        "entities": false,
        "usecases": false,
        "providers": false,
        "pages": false,
        "widgets": false
      };

      // act
      List<String> dependenciesBroken = await upholdsArchitechture(file, allowedDependencies);

      // assert
      expect(dependenciesBroken, true, reason: "Filename " + filename + " wrongly depends on " + dependenciesBroken.toString());
    }, skip: true,
    tags: ["architechture", "models"]);
  });
  group("Architechture Check Repositories",() {
    test(
      """
        Should only be allowed to depend on other remotes, models and core. (not other repositories!)
        The repository handles serialization (to remotes) and deserialization (back to usecases) using models as serializers.
        The repository generally handles all the logic containing "transforming" outside raw data (from remotes)
        into internal entities that is useful for the usecase to understand.
        Cross dependency between repositories is also confusing and should therefore be kept seperate.
      """,
      () async {
      // arrange
      String filename = "SomeName";
      File file = File(filename);
      Map<String,dynamic> allowedDependencies = {
        "core": true,
        "datasources": true,
        "models": true,
        "repositories": false,
        "entities": false,
        "usecases": false,
        "providers": false,
        "pages": false,
        "widgets": false
      };

      // act
      List<String> dependenciesBroken = await upholdsArchitechture(file, allowedDependencies);

      // assert
      expect(dependenciesBroken.isEmpty, true, reason: "Filename " + filename + " wrongly depends on " + dependenciesBroken.toString());
    }, skip: true,
    tags: ["architechture", "repositories"]);
  });
  group("Architechture Check Usecases",() {
    test(
      """
        Should only depend on repositories. May not depend on anything else (not even core or other usecases!).
        Usecases define the business logic, signifying a representation of "what can be done in the domain".
        Usecases should be seen as just as abstract as entities. A Usecase is a model of what a user want to do.
        A Usecase (in the code) is NOT the thing the user actually wants to do! It is just a model of it.
        Just as an Entity (in the code) is NOT the actual thing that exists in the domain!
      """,
      () async {
            // arrange
      String filename = "SomeName";
      File file = File(filename);
      Map<String,dynamic> allowedDependencies = {
        "core": false,
        "datasources": false,
        "models": false,
        "repositories": true,
        "entities": false,
        "usecases": false,
        "providers": false,
        "pages": false,
        "widgets": false
      };

      // act
      List<String> dependenciesBroken = await upholdsArchitechture(file, allowedDependencies);

      // assert
      expect(dependenciesBroken.isEmpty, true, reason: "Filename " + filename + " wrongly depends on " + dependenciesBroken.toString());
    }, skip: true,
    tags: ["architechture", "usecases"]);
  });
  group("Architechture Check Entities",() {
    test(
      """
        Should only be possible to depend on other entities, nothing else at all (not even core!).
        Entities should be as abstract as possible, signifying a representation of "what exists in the domain".
        Entities are models of what exists in the domain, which is important to remember.
        An Entity (in the code) is NOT the actual thing that exists in the domain!
        Just as a Usecase (in the code) is NOT the actual thing a user wants to achieve! It is only a model of it.
      """,
      () async {
      // arrange
      String filename = "SomeName";
      File file = File(filename);
      Map<String,dynamic> allowedDependencies = {
        "core": false,
        "datasources": false,
        "models": false,
        "repositories": false,
        "entities": true,
        "usecases": false,
        "providers": false,
        "pages": false,
        "widgets": false
      };

      // act
      List<String> dependenciesBroken = await upholdsArchitechture(file, allowedDependencies);

      // assert
      expect(dependenciesBroken.isEmpty, true, reason: "Filename " + filename + " wrongly depends on " + dependenciesBroken.toString());
    }, skip: true,
    tags: ["architechture", "entities"]);
  });
  group("Architechture Check Providers",() {
    test(
      """
        Should only be allowed to depend on usecases and core. (not even other providers)
        Providers handle all the state of the UI, but actions that change the state is the business logic defined in the usecases.
        Cross dependency between providers is also confusing and should therefore be kept seperate.
      """,
      () async {
            // arrange
      String filename = "SomeName";
      File file = File(filename);
      Map<String,dynamic> allowedDependencies = {
        "core": true,
        "datasources": false,
        "models": false,
        "repositories": false,
        "entities": false,
        "usecases": true,
        "providers": false,
        "pages": false,
        "widgets": false
      };

      // act
      List<String> dependenciesBroken = await upholdsArchitechture(file, allowedDependencies);

      // assert
      expect(dependenciesBroken.isEmpty, true, reason: "Filename " + filename + " wrongly depends on " + dependenciesBroken.toString());
    }, skip: true,
    tags: ["architechture", "providers"]);
  });
  group("Architechture Check Pages",() {
    test(
      """
        Should only be allowed to depend on other widgets (not pages!), providers or core.
        The reason is the UI layer should have no logic or computation. 
        All state is handled by the Provider.
      """,
      () async {
      // arrange
      Map<String,dynamic> allowedDependencies = {
        "core": true,
        "datasources": false,
        "models": false,
        "repositories": false,
        "entities": false,
        "usecases": false,
        "providers": true,
        "pages": false,
        "widgets": true
      };
      Stream<FileSystemEntity> featureDir = await Directory(path.join(Directory.current.path, "lib", "features")).list();
      featureDir.forEach((element) async {
        if(element is Directory){
          Stream<FileSystemEntity> pagesList = await Directory(path.join(element.path, "presentation","widgets")).list();
          pagesList.forEach((element) async {
            // arrange
            File pageFile = (element as File);

            // act
            List<String> dependenciesBroken = await upholdsArchitechture(pageFile, allowedDependencies);

            // assert
            expect(dependenciesBroken, [], reason: "Filename " + pageFile.path + " breaks the architechture in the given areas");
          });
        }
      });
    },
    tags: ["architechture", "widgets"]);
  });
  group("Architechture Check Widgets",() {
    test(
      """
        Should only be allowed to depend on other widgets (not pages!), providers or core.
        The reason is the UI layer should have no logic or computation. 
        All state is handled by the Provider.
      """,
      () async {
      // arrange
      Map<String,dynamic> allowedDependencies = {
        "core": true,
        "datasources": false,
        "models": false,
        "repositories": false,
        "entities": false,
        "usecases": false,
        "providers": true,
        "pages": false,
        "widgets": true
      };
      Stream<FileSystemEntity> featureDir = await Directory(path.join(Directory.current.path, "lib", "features")).list();
      featureDir.forEach((element) async {
        if(element is Directory){
          Stream<FileSystemEntity> widgetList = await Directory(path.join(element.path, "presentation","widgets")).list();
          widgetList.forEach((element) async {
            // arrange
            File widgetFile = (element as File);

            // act
            List<String> dependenciesBroken = await upholdsArchitechture(widgetFile, allowedDependencies);

            // assert
            expect(dependenciesBroken, [], reason: "Filename " + widgetFile.path + " breaks the architechture in the given areas");
          });
        }
      });
    },
    tags: ["architechture", "widgets"]);
  });
  group("Architechture Check upholdsArchitechture",() {
    test(
      """
        Should terminate at end of file
      """,
      () async {
      String testFilePath = path.join(Directory.current.path, "test", "architechture", "test_empty_file.txt");
      File testFile = File(testFilePath);
      
      Map<String,dynamic> allowedDependencies = {};

      // act
      List<String> dependenciesBroken = await upholdsArchitechture(testFile, allowedDependencies);

      // assert
      expect(dependenciesBroken, []);
    },
    tags: ["architechture"]);
    test(
      """
        Should terminate when the file arrives at a class definition, cutting down runtime
      """,
      () async {
      // arrange
      String testFilePath = path.join(Directory.current.path, "test", "architechture", "test_file_with_class.txt");
      File testFile = File(testFilePath);
      Map<String,dynamic> allowedDependencies = {
        "thingtolookfor": false
      };

      // act
      List<String> dependenciesBroken = await upholdsArchitechture(testFile, allowedDependencies);

      // assert
      expect(dependenciesBroken, []);
    },
    tags: ["architechture"]);
  });
  test(
      """
        Should return an empty list, given no dependencies are broken
        Given the specific test file.
      """,
      () async {
      // arrange
      String testFilePath = path.join(Directory.current.path, "test", "architechture", "test_file_with_0_imports_to_be_found.txt");
      File testFile = File(testFilePath);
      Map<String,dynamic> allowedDependencies = {
        "thingtolookfor": false
      };

      // act
      List<String> dependenciesBroken = await upholdsArchitechture(testFile, allowedDependencies);

      // assert
      expect(dependenciesBroken, []);
    },
    tags: ["architechture"]);
  test(
      """
        Should return a list of 1 dependency broken, specifying what line is breaking the architechture
        Given the specific test file.
      """,
      () async {
      // arrange
      String testFilePath = path.join(Directory.current.path, "test", "architechture", "test_file_with_1_import_that_should_be_found.txt");
      File testFile = File(testFilePath);
      Map<String,dynamic> allowedDependencies = {
        "thingtolookfor": false
      };

      // act
      List<String> dependenciesBroken = await upholdsArchitechture(testFile, allowedDependencies);

      // assert
      expect(dependenciesBroken.length, 1);
    },
    tags: ["architechture"]);
  test(
      """
        Should return a list of 2 dependency broken, specifying what line is breaking the architechture
        Given the specific test file.
      """,
      () async {
      // arrange
      String testFilePath = path.join(Directory.current.path, "test", "architechture", "test_file_with_2_imports_that_should_be_found.txt");
      File testFile = File(testFilePath);
      Map<String,dynamic> allowedDependencies = {
        "thingtolookfor": false
      };

      // act
      List<String> dependenciesBroken = await upholdsArchitechture(testFile, allowedDependencies);

      // assert
      expect(dependenciesBroken.length, 2);
    },
    tags: ["architechture"]);
  test(
      """
        When allowing something to be a dependency, it should just skip it entirely
      """,
      () async {
      // arrange
      String testFilePath = path.join(Directory.current.path, "test", "architechture", "test_file_with_2_imports_that_should_be_found.txt");
      File testFile = File(testFilePath);
      Map<String,dynamic> allowedDependencies = {
        "thingtolookfor": true
      };

      // act
      List<String> dependenciesBroken = await upholdsArchitechture(testFile, allowedDependencies);

      // assert
      expect(dependenciesBroken.length, 0);
    },
    tags: ["architechture"]);
  test(
      """
        Should at all times disallow the use of injection container.
        Only the main file (ie. something outside the layers) should make use of the injection container.
      """,
      () async {
      // arrange
      String testFilePath = path.join(Directory.current.path, "test", "architechture", "test_file_that_imports_injection_container.txt");
      File testFile = File(testFilePath);
      Map<String,dynamic> allowedDependencies = {};

      // act
      List<String> dependenciesBroken = await upholdsArchitechture(testFile, allowedDependencies);

      // assert
      expect(dependenciesBroken.length, 1);
    },
    tags: ["architechture"]);
}