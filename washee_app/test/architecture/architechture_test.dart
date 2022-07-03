import 'dart:core';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;

void main() {
  late Map<String,dynamic> allowedDependencies;

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
            if(fileContent[i].contains("/"+layerName+"/")){ // Ie. the layer is importet in some way thereby breaking the architecture
              dependenciesBroken.add(fileContent[i]);
            }
          }
        });
      };
      i += 1;
    };
    return dependenciesBroken;
  }

  setUp() {
    allowedDependencies = {
        "externalities": false,
        "standards": false,
        "ui": false,
        "datasources": false,
        "models": false,
        "repositories": false,
        "entities": false,
        "usecases": false,
        "providers": false,
        "pages": false,
        "widgets": false
      };
  }

  group("Architechture Check Externalities",() {
    test(
      """
        Should only depend on standardizations and other externalities.
        Externalities describe the contract with any external service, typically the phone settings, a remote server, etc.
        Remotes will use these to make sure the contract is not broken (security checks etc.) which is not relevant for the feature domain.
      """,
      () async {
      // arrange
      setUp();
      allowedDependencies["standards"] = true;
      allowedDependencies["externalities"] = true;

      Stream<FileSystemEntity> coreDir = await Directory(path.join(Directory.current.path, "lib", "core", "externalities")).list();
      coreDir.forEach((element) async {
        if(element is Directory){
          Stream<FileSystemEntity> externalityList = await Directory(path.join(element.path)).list();
          externalityList.forEach((element) async {
            // arrange
            File externalityFile = (element as File);

            // act
            List<String> dependenciesBroken = await upholdsArchitechture(externalityFile, allowedDependencies);

            // assert
            expect(dependenciesBroken, [], reason: "Filename " + externalityFile.path + " breaks the architecture in the given areas");
          });
        }
      });
    },
    tags: ["architecture", "core", "externalities"]);
  });
  group("Architechture Check Standards",() {
    test(
      """
        Should only depend on other standards packages in core.
        Core is used to standardize and generalize implementation details.
        It is therefore important it never gets muddled up with the features and actual business logic!
        If something needs to depend on something in the layers, it probably belong as part of that feature.
      """,
      () async {
      // arrange
      setUp();
      allowedDependencies["standards"] = true;
      allowedDependencies["externalities"] = true;

      // IS NOT WORKING! Maybe even split it out into externalities (only remotes), standards (all logic layers) and ui (only presentation)?
      Stream<FileSystemEntity> coreDir = await Directory(path.join(Directory.current.path, "lib", "core", "standards")).list();
      coreDir.forEach((element) async {
        if(element is Directory){
          Stream<FileSystemEntity> standardsList = await Directory(path.join(element.path)).list();
          standardsList.forEach((element) async {
            // arrange
            File standardsFile = (element as File);

            // act
            List<String> dependenciesBroken = await upholdsArchitechture(standardsFile, allowedDependencies);

            // assert
            expect(dependenciesBroken, [], reason: "Filename " + standardsFile.path + " breaks the architecture in the given areas");
          });
        }
      });
    },
    tags: ["architecture", "core", "standards"]);
  });
  group("Architechture Checks UI",() {
    test(
      """
        Should only depend on other ui packages.
        UI packages are widgets that should be used across the project to make it have a unified UI feeling.
        It is therefore important it never gets muddled up with the features and actual business logic!
        If something needs to depend on something in the layers, it probably belong as part of that feature.
      """,
      () async {
      // arrange
      setUp();
      allowedDependencies["ui"] = true;

      Stream<FileSystemEntity> coreDir = await Directory(path.join(Directory.current.path, "lib", "core", "ui")).list();
      coreDir.forEach((element) async {
        if(element is Directory){
          Stream<FileSystemEntity> uiList = await Directory(path.join(element.path)).list();
          uiList.forEach((element) async {
            // arrange
            File widgetFile = (element as File);

            // act
            List<String> dependenciesBroken = await upholdsArchitechture(widgetFile, allowedDependencies);

            // assert
            expect(dependenciesBroken, [], reason: "Filename " + widgetFile.path + " breaks the architecture in the given areas");
          });
        }
      });
    }, skip: true,
    tags: ["architecture", "core", "ui"]);
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
      setUp();
      allowedDependencies["core"] = true;

      Stream<FileSystemEntity> featureDir = await Directory(path.join(Directory.current.path, "lib", "features")).list();
      featureDir.forEach((element) async {
        if(element is Directory){
          Stream<FileSystemEntity> widgetList = await Directory(path.join(element.path, "data","datasources")).list();
          widgetList.forEach((element) async {
            // arrange
            File datasourceFile = (element as File);

            // act
            List<String> dependenciesBroken = await upholdsArchitechture(datasourceFile, allowedDependencies);

            // assert
            expect(dependenciesBroken, [], reason: "Filename " + datasourceFile.path + " breaks the architecture in the given areas");
          });
        }
      });
    }, skip: true,
    tags: ["architecture", "features", "datasources"]);
  });
  group("Architechture Check Models",() {
    test(
      """
        Should only be allowed to depend on other models and core.
        A model is generally just a serializer transforming raw data received by the remote, into an entity type object.
      """,
      () async {
      // arrange
      setUp();
      allowedDependencies["core"] = true;
      allowedDependencies["models"] = true;

      Stream<FileSystemEntity> featureDir = await Directory(path.join(Directory.current.path, "lib", "features")).list();
      featureDir.forEach((element) async {
        if(element is Directory){
          Stream<FileSystemEntity> widgetList = await Directory(path.join(element.path, "data","models")).list();
          widgetList.forEach((element) async {
            // arrange
            File modelFile = (element as File);

            // act
            List<String> dependenciesBroken = await upholdsArchitechture(modelFile, allowedDependencies);

            // assert
            expect(dependenciesBroken, [], reason: "Filename " + modelFile.path + " breaks the architecture in the given areas");
          });
        }
      });
    }, skip: true,
    tags: ["architecture", "features", "models"]);
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
      setUp();
      allowedDependencies["core"] = true;
      allowedDependencies["datasources"] = true;
      allowedDependencies["models"] = true;

      Stream<FileSystemEntity> featureDir = await Directory(path.join(Directory.current.path, "lib", "features")).list();
      featureDir.forEach((element) async {
        if(element is Directory){
          Stream<FileSystemEntity> widgetList = await Directory(path.join(element.path, "data","repositories")).list();
          widgetList.forEach((element) async {
            // arrange
            File repositoryFile = (element as File);

            // act
            List<String> dependenciesBroken = await upholdsArchitechture(repositoryFile, allowedDependencies);

            // assert
            expect(dependenciesBroken, [], reason: "Filename " + repositoryFile.path + " breaks the architecture in the given areas");
          });
        }
      });
    }, skip: true,
    tags: ["architecture", "features", "repositories"]);
  });
  group("Architechture Check Usecases",() {
    test(
      """
        Should only depend on repositories and entities. May not depend on anything else (not even core or other usecases!).
        Usecases define the business logic, signifying a representation of "what can be done in the domain".
        Usecases should be seen as just as abstract as entities. A Usecase is a model of what a user want to do.
        A Usecase (in the code) is NOT the thing the user actually wants to do! It is just a model of it.
        Just as an Entity (in the code) is NOT the actual thing that exists in the domain!
      """,
      () async {
      // arrange
      setUp();
      allowedDependencies["repositories"] = true;
      allowedDependencies["entities"] = true;

      Stream<FileSystemEntity> featureDir = await Directory(path.join(Directory.current.path, "lib", "features")).list();
      featureDir.forEach((element) async {
        if(element is Directory){
          Stream<FileSystemEntity> widgetList = await Directory(path.join(element.path, "domain","usecases")).list();
          widgetList.forEach((element) async {
            // arrange
            File usecaseFile = (element as File);

            // act
            List<String> dependenciesBroken = await upholdsArchitechture(usecaseFile, allowedDependencies);

            // assert
            expect(dependenciesBroken, [], reason: "Filename " + usecaseFile.path + " breaks the architecture in the given areas");
          });
        }
      });
    }, skip: true,
    tags: ["architecture", "features", "usecases"]);
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
      setUp();
      allowedDependencies["entities"] = true;

      Stream<FileSystemEntity> featureDir = await Directory(path.join(Directory.current.path, "lib", "features")).list();
      featureDir.forEach((element) async {
        if(element is Directory){
          Stream<FileSystemEntity> widgetList = await Directory(path.join(element.path, "domain","entities")).list();
          widgetList.forEach((element) async {
            // arrange
            File entityFile = (element as File);

            // act
            List<String> dependenciesBroken = await upholdsArchitechture(entityFile, allowedDependencies);

            // assert
            expect(dependenciesBroken, [], reason: "Filename " + entityFile.path + " breaks the architecture in the given areas");
          });
        }
      });
    }, skip: true,
    tags: ["architecture", "features", "entities"]);
  });
  group("Architechture Check Providers",() {
    test(
      """
        Should only be allowed to depend on usecases, entities and core. (not even other providers)
        Providers handle all the state of the UI, but actions that change the state is the business logic defined in the usecases.
        Cross dependency between providers is also confusing and should therefore be kept seperate.
      """,
      () async {
      // arrange
      setUp();
      allowedDependencies["core"] = true;
      allowedDependencies["usecases"] = true;
      allowedDependencies["entities"] = true;

      Stream<FileSystemEntity> featureDir = await Directory(path.join(Directory.current.path, "lib", "features")).list();
      featureDir.forEach((element) async {
        if(element is Directory){
          Stream<FileSystemEntity> widgetList = await Directory(path.join(element.path, "presentation","providers")).list();
          widgetList.forEach((element) async {
            // arrange
            File providerFile = (element as File);

            // act
            List<String> dependenciesBroken = await upholdsArchitechture(providerFile, allowedDependencies);

            // assert
            expect(dependenciesBroken, [], reason: "Filename " + providerFile.path + " breaks the architecture in the given areas");
          });
        }
      });
    }, skip: true,
    tags: ["architecture", "features", "providers"]);
  });
  group("Architechture Check Pages",() {
    test(
      """
        Should only be allowed to depend on other widgets (not pages!), providers, entities or core.
        The reason is the UI layer should have no logic or computation. 
        All state is handled by the Provider.
      """,
      () async {
      // arrange
      setUp();
      allowedDependencies["core"] = true;
      allowedDependencies["entities"] = true;
      allowedDependencies["providers"] = true;
      allowedDependencies["widgets"] = true;

      Stream<FileSystemEntity> featureDir = await Directory(path.join(Directory.current.path, "lib", "features")).list();
      featureDir.forEach((element) async {
        if(element is Directory){
          Stream<FileSystemEntity> pagesList = await Directory(path.join(element.path, "presentation","pages")).list();
          pagesList.forEach((element) async {
            // arrange
            File pageFile = (element as File);

            // act
            List<String> dependenciesBroken = await upholdsArchitechture(pageFile, allowedDependencies);

            // assert
            expect(dependenciesBroken, [], reason: "Filename " + pageFile.path + " breaks the architecture in the given areas");
          });
        }
      });
    }, skip: true,
    tags: ["architecture", "features", "pages"]);
  });
  group("Architechture Check Widgets",() {
    test(
      """
        Should only be allowed to depend on other widgets (not pages!), providers, entities or core.
        The reason is the UI layer should have no logic or computation. 
        All state is handled by the Provider.
      """,
      () async {
      // arrange
      setUp();
      allowedDependencies["core"] = true;
      allowedDependencies["entities"] = true;
      allowedDependencies["providers"] = true;
      allowedDependencies["widgets"] = true;

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
            expect(dependenciesBroken, [], reason: "Filename " + widgetFile.path + " breaks the architecture in the given areas");
          });
        }
      });
    }, skip: true,
    tags: ["architecture", "features", "widgets"]);
  });
  group("Architechture Check upholdsArchitechture",() {
    test(
      """
        Should terminate at end of file
      """,
      () async {
      String testFilePath = path.join(Directory.current.path, "test", "architecture", "test_empty_file.txt");
      File testFile = File(testFilePath);
      
      Map<String,dynamic> allowedDependencies = {};

      // act
      List<String> dependenciesBroken = await upholdsArchitechture(testFile, allowedDependencies);

      // assert
      expect(dependenciesBroken, []);
    },
    tags: ["architecture"]);
    test(
      """
        Should terminate when the file arrives at a class definition, cutting down runtime
      """,
      () async {
      // arrange
      String testFilePath = path.join(Directory.current.path, "test", "architecture", "test_file_with_class.txt");
      File testFile = File(testFilePath);
      Map<String,dynamic> allowedDependencies = {
        "thingtolookfor": false
      };

      // act
      List<String> dependenciesBroken = await upholdsArchitechture(testFile, allowedDependencies);

      // assert
      expect(dependenciesBroken, []);
    },
    tags: ["architecture"]);
  });
  test(
      """
        Should return an empty list, given no dependencies are broken
        Given the specific test file.
      """,
      () async {
      // arrange
      String testFilePath = path.join(Directory.current.path, "test", "architecture", "test_file_with_0_imports_to_be_found.txt");
      File testFile = File(testFilePath);
      Map<String,dynamic> allowedDependencies = {
        "thingtolookfor": false
      };

      // act
      List<String> dependenciesBroken = await upholdsArchitechture(testFile, allowedDependencies);

      // assert
      expect(dependenciesBroken, []);
    },
    tags: ["architecture"]);
  test(
      """
        Should return a list of 1 dependency broken, specifying what line is breaking the architecture
        Given the specific test file.
      """,
      () async {
      // arrange
      String testFilePath = path.join(Directory.current.path, "test", "architecture", "test_file_with_1_import_that_should_be_found.txt");
      File testFile = File(testFilePath);
      Map<String,dynamic> allowedDependencies = {
        "thingtolookfor": false
      };

      // act
      List<String> dependenciesBroken = await upholdsArchitechture(testFile, allowedDependencies);

      // assert
      expect(dependenciesBroken.length, 1);
    },
    tags: ["architecture"]);
  test(
      """
        Should return a list of 2 dependency broken, specifying what line is breaking the architecture
        Given the specific test file.
      """,
      () async {
      // arrange
      String testFilePath = path.join(Directory.current.path, "test", "architecture", "test_file_with_2_imports_that_should_be_found.txt");
      File testFile = File(testFilePath);
      Map<String,dynamic> allowedDependencies = {
        "thingtolookfor": false
      };

      // act
      List<String> dependenciesBroken = await upholdsArchitechture(testFile, allowedDependencies);

      // assert
      expect(dependenciesBroken.length, 2);
    },
    tags: ["architecture"]);
  test(
      """
        When allowing something to be a dependency, it should just skip it entirely
      """,
      () async {
      // arrange
      String testFilePath = path.join(Directory.current.path, "test", "architecture", "test_file_with_2_imports_that_should_be_found.txt");
      File testFile = File(testFilePath);
      Map<String,dynamic> allowedDependencies = {
        "thingtolookfor": true
      };

      // act
      List<String> dependenciesBroken = await upholdsArchitechture(testFile, allowedDependencies);

      // assert
      expect(dependenciesBroken.length, 0);
    },
    tags: ["architecture"]);
  test(
      """
        Should at all times disallow the use of injection container.
        Only the main file (ie. something outside the layers) should make use of the injection container.
      """,
      () async {
      // arrange
      String testFilePath = path.join(Directory.current.path, "test", "architecture", "test_file_that_imports_injection_container.txt");
      File testFile = File(testFilePath);
      Map<String,dynamic> allowedDependencies = {};

      // act
      List<String> dependenciesBroken = await upholdsArchitechture(testFile, allowedDependencies);

      // assert
      expect(dependenciesBroken.length, 1);
    },
    tags: ["architecture"]);
  test(
      """
        Should check that only layers specified in allowedDependencies are the ones allowed in the features and core directory
      """,
      () async {
        setUp();

        // Basic folders accepted
        allowedDependencies["core"] = true;
        allowedDependencies["features"] = true;
        allowedDependencies["data"] = true;
        allowedDependencies["domain"] = true;
        allowedDependencies["presentation"] = true;
        // Features implemented
        allowedDependencies["account"] = true;
        allowedDependencies["booking"] = true;
        allowedDependencies["green_info"] = true;
        allowedDependencies["location"] = true;
        // Specifications of core accepted (should probably be made as their own tests)
        // Externalities
        allowedDependencies["box"] = true;
        allowedDependencies["network"] = true;
        allowedDependencies["web"] = true;
        // Standards
        allowedDependencies["base_usecase"] = true;
        allowedDependencies["environments"] = true;
        allowedDependencies["failures"] = true;
        allowedDependencies["logger"] = true;
        allowedDependencies["time"] = true;
        // UI
        allowedDependencies["global_providers"] = true;
        allowedDependencies["navigation"] = true;
        allowedDependencies["themes"] = true;
        allowedDependencies["widgets"] = true;

        Stream<FileSystemEntity> featureDir = await Directory(path.join(Directory.current.path, "lib")).list(recursive: true);
        await featureDir.forEach((element) async {
          // act
          if(element is Directory){
            String dirName = element.toString().split(Platform.pathSeparator).last;
            dirName = dirName.substring(0, dirName.length - 1); // Remove trailing '
            bool validDirectory = false;
            allowedDependencies.forEach((key, value) {
              if(dirName == key){
                validDirectory = true;
              }
            });
            expect(validDirectory, true, reason: "Layername " + dirName + " is not registered as being a valid layer in " + element.toString());
          }
        });
    },
    tags: ["architecture"]);
}