import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:washee/core/helpers/green_score_database.dart';
import 'package:washee/features/booking/presentation/provider/calendar_provider.dart';

void main() {
  // var calendar = Provider.of<CalendarProvider>(null, listen: false);

  
  //__________________________________
//TODO:important this should use the calculateBestGreenScore function from calendar_provider
  int calculateBestGreenScore(
      List<GreenScore> greenScoresForDay, List<DateTime> timeSlots) {
    int bestScore = -1;
    int sum = 0;
    int greenScoreDayLength = greenScoresForDay.length;
    for (int index = 0; index < greenScoreDayLength; index++) {
      var allowedInBestScore = true;
      // if (!isSlotOutdated(timeSlots[index])) {
      if (index + 5 < greenScoreDayLength) {
        for (int j in Iterable.generate(6)) {
          int subIndex = index + j;
          // If we encounter a booked slot we set the sum back to zero
          if (greenScoresForDay[subIndex].vacant == false) {
            allowedInBestScore = false;
            // print("found dis-allowed slot:" + subIndex.toString());
            sum = 0;
          } else if (allowedInBestScore) {
            sum += greenScoresForDay[subIndex].greenScore;
            // print("found allowed slot:" + subIndex.toString());
            // print("current sum:" + sum.toString());
          }
        }

        if (allowedInBestScore) {
          // print("trying to set best score if");
          // print(bestScore.toString()+"<"+sum.toString());
          if (bestScore < sum) {
            bestScore = sum;
          }
        }
        allowedInBestScore = true;
        sum = 0;
      }
      // }
    }

    return bestScore;
  }

  // var greenScoreList1 = [
  //   GreenScore(hour: 06, minute: 00, greenScore: 8, vacant: false),
  //   GreenScore(hour: 06, minute: 30, greenScore: 8, vacant: false),
  //   GreenScore(hour: 07, minute: 00, greenScore: 8, vacant: false),
  //   GreenScore(hour: 07, minute: 30, greenScore: 8, vacant: false),
  //   GreenScore(hour: 08, minute: 00, greenScore: 8, vacant: false),
  //   GreenScore(hour: 08, minute: 30, greenScore: 8, vacant: false),
  //   GreenScore(hour: 09, minute: 00, greenScore: 8, vacant: false),
  //   GreenScore(hour: 09, minute: 30, greenScore: 8, vacant: false),
  //   GreenScore(hour: 10, minute: 00, greenScore: 8, vacant: false),
  //   GreenScore(hour: 10, minute: 30, greenScore: 8, vacant: false),
  //   GreenScore(hour: 11, minute: 00, greenScore: 8, vacant: false),
  //   GreenScore(hour: 11, minute: 30, greenScore: 8, vacant: false),
  //   GreenScore(hour: 12, minute: 00, greenScore: 4, vacant: false),
  //   GreenScore(hour: 12, minute: 30, greenScore: 4, vacant: false),
  //   GreenScore(hour: 13, minute: 00, greenScore: 4, vacant: false),
  //   GreenScore(hour: 13, minute: 30, greenScore: 4, vacant: false),
  //   GreenScore(hour: 14, minute: 00, greenScore: 4, vacant: false),
  //   GreenScore(hour: 14, minute: 30, greenScore: 4, vacant: false),
  //   GreenScore(hour: 15, minute: 00, greenScore: 1, vacant: true),
  //   GreenScore(hour: 15, minute: 30, greenScore: 1, vacant: true),
  //   GreenScore(hour: 16, minute: 00, greenScore: 1, vacant: true),
  //   GreenScore(hour: 16, minute: 30, greenScore: 1, vacant: true),
  //   GreenScore(hour: 17, minute: 00, greenScore: 1, vacant: true),
  //   GreenScore(hour: 17, minute: 30, greenScore: 1, vacant: true),
  //   GreenScore(hour: 18, minute: 00, greenScore: 4, vacant: true),
  //   GreenScore(hour: 18, minute: 30, greenScore: 4, vacant: false),
  //   GreenScore(hour: 19, minute: 00, greenScore: 4, vacant: false),
  //   GreenScore(hour: 19, minute: 30, greenScore: 4, vacant: false),
  //   GreenScore(hour: 20, minute: 00, greenScore: 4, vacant: false),
  //   GreenScore(hour: 20, minute: 30, greenScore: 8, vacant: false),
  //   GreenScore(hour: 21, minute: 00, greenScore: 8, vacant: false),
  //   GreenScore(hour: 21, minute: 30, greenScore: 8, vacant: false),
  //   GreenScore(hour: 22, minute: 00, greenScore: 8, vacant: false),
  //   GreenScore(hour: 22, minute: 30, greenScore: 8, vacant: false),
  //   GreenScore(hour: 23, minute: 00, greenScore: 8, vacant: false),
  // ];
  // test(
  //     'testing that the best availlable greenscore is returned from when star is booked',
  //     () {
  //   List<DateTime> _slots = [];
  //   var startTime = DateTime(2022, 5, 1, 06, 0);
  //   _slots.add(startTime);
  //   for (int i = 0; i < 34; i++) {
  //     startTime = startTime.add(Duration(minutes: 30));
  //     _slots.add(startTime);
  //   }

  //   //act
  //   var result = calculateBestGreenScore(greenScoreList1, _slots);

  //   //assert
  //   expect(result, 8);
  // });

  // var greenScoreList2 = [
  //   GreenScore(hour: 06, minute: 00, greenScore: 8, vacant: true),
  //   GreenScore(hour: 06, minute: 30, greenScore: 8, vacant: true),
  //   GreenScore(hour: 07, minute: 00, greenScore: 8, vacant: true),
  //   GreenScore(hour: 07, minute: 30, greenScore: 8, vacant: true),
  //   GreenScore(hour: 08, minute: 00, greenScore: 8, vacant: false),
  //   GreenScore(hour: 08, minute: 30, greenScore: 8, vacant: false),
  //   GreenScore(hour: 09, minute: 00, greenScore: 8, vacant: false),
  //   GreenScore(hour: 09, minute: 30, greenScore: 8, vacant: false),
  //   GreenScore(hour: 10, minute: 00, greenScore: 8, vacant: false),
  //   GreenScore(hour: 10, minute: 30, greenScore: 8, vacant: false),
  //   GreenScore(hour: 11, minute: 00, greenScore: 8, vacant: false),
  //   GreenScore(hour: 11, minute: 30, greenScore: 8, vacant: false),
  //   GreenScore(hour: 12, minute: 00, greenScore: 4, vacant: false),
  //   GreenScore(hour: 12, minute: 30, greenScore: 4, vacant: false),
  //   GreenScore(hour: 13, minute: 00, greenScore: 4, vacant: false),
  //   GreenScore(hour: 13, minute: 30, greenScore: 4, vacant: false),
  //   GreenScore(hour: 14, minute: 00, greenScore: 4, vacant: false),
  //   GreenScore(hour: 14, minute: 30, greenScore: 4, vacant: false),
  //   GreenScore(hour: 15, minute: 00, greenScore: 1, vacant: true),
  //   GreenScore(hour: 15, minute: 30, greenScore: 1, vacant: true),
  //   GreenScore(hour: 16, minute: 00, greenScore: 1, vacant: true),
  //   GreenScore(hour: 16, minute: 30, greenScore: 1, vacant: true),
  //   GreenScore(hour: 17, minute: 00, greenScore: 1, vacant: true),
  //   GreenScore(hour: 17, minute: 30, greenScore: 1, vacant: true),
  //   GreenScore(hour: 18, minute: 00, greenScore: 4, vacant: true),
  //   GreenScore(hour: 18, minute: 30, greenScore: 4, vacant: false),
  //   GreenScore(hour: 19, minute: 00, greenScore: 4, vacant: false),
  //   GreenScore(hour: 19, minute: 30, greenScore: 4, vacant: false),
  //   GreenScore(hour: 20, minute: 00, greenScore: 4, vacant: false),
  //   GreenScore(hour: 20, minute: 30, greenScore: 8, vacant: false),
  //   GreenScore(hour: 21, minute: 00, greenScore: 8, vacant: false),
  //   GreenScore(hour: 21, minute: 30, greenScore: 8, vacant: false),
  //   GreenScore(hour: 22, minute: 00, greenScore: 8, vacant: false),
  //   GreenScore(hour: 22, minute: 30, greenScore: 8, vacant: false),
  //   GreenScore(hour: 23, minute: 00, greenScore: 8, vacant: false),
  // ];
  // test(
  //     'testing that the best availlable greenscore is returned when some slots are availlable in the beginning but not enough to form 6 slots.',
  //     () {
  //   List<DateTime> _slots = [];
  //   var startTime = DateTime(2022, 5, 1, 06, 0);
  //   _slots.add(startTime);
  //   for (int i = 0; i < 34; i++) {
  //     startTime = startTime.add(Duration(minutes: 30));
  //     _slots.add(startTime);
  //   }

  //   //act
  //   var result = calculateBestGreenScore(greenScoreList2, _slots);

  //   //assert
  //   expect(result, 9);
  // });

  var greenScoreList3 = [
    GreenScore(hour: 06, minute: 00, greenScore: 8, vacant: false),
    GreenScore(hour: 06, minute: 30, greenScore: 8, vacant: false),
    GreenScore(hour: 07, minute: 00, greenScore: 8, vacant: false),
    GreenScore(hour: 07, minute: 30, greenScore: 8, vacant: false),
    GreenScore(hour: 08, minute: 00, greenScore: 8, vacant: false),
    GreenScore(hour: 08, minute: 30, greenScore: 8, vacant: false),
    GreenScore(hour: 09, minute: 00, greenScore: 8, vacant: false),
    GreenScore(hour: 09, minute: 30, greenScore: 8, vacant: false),
    GreenScore(hour: 10, minute: 00, greenScore: 8, vacant: false),
    GreenScore(hour: 10, minute: 30, greenScore: 8, vacant: false),
    GreenScore(hour: 11, minute: 00, greenScore: 8, vacant: false),
    GreenScore(hour: 11, minute: 30, greenScore: 8, vacant: false),
    GreenScore(hour: 12, minute: 00, greenScore: 4, vacant: false),
    GreenScore(hour: 12, minute: 30, greenScore: 4, vacant: false),
    GreenScore(hour: 13, minute: 00, greenScore: 4, vacant: false),
    GreenScore(hour: 13, minute: 30, greenScore: 4, vacant: false),
    GreenScore(hour: 14, minute: 00, greenScore: 4, vacant: false),
    GreenScore(hour: 14, minute: 30, greenScore: 4, vacant: false),
    GreenScore(hour: 15, minute: 00, greenScore: 1, vacant: false),
    GreenScore(hour: 15, minute: 30, greenScore: 1, vacant: false),
    GreenScore(hour: 16, minute: 00, greenScore: 1, vacant: false),
    GreenScore(hour: 16, minute: 30, greenScore: 1, vacant: false),
    GreenScore(hour: 17, minute: 00, greenScore: 1, vacant: false),
    GreenScore(hour: 17, minute: 30, greenScore: 1, vacant: false),
    GreenScore(hour: 18, minute: 00, greenScore: 4, vacant: false),
    GreenScore(hour: 18, minute: 30, greenScore: 4, vacant: false),
    GreenScore(hour: 19, minute: 00, greenScore: 4, vacant: false),
    GreenScore(hour: 19, minute: 30, greenScore: 4, vacant: false),
    GreenScore(hour: 20, minute: 00, greenScore: 4, vacant: false),
    GreenScore(hour: 20, minute: 30, greenScore: 8, vacant: false),
    GreenScore(hour: 21, minute: 00, greenScore: 8, vacant: false),
    GreenScore(hour: 21, minute: 30, greenScore: 8, vacant: false),
    GreenScore(hour: 22, minute: 00, greenScore: 8, vacant: false),
    GreenScore(hour: 22, minute: 30, greenScore: 8, vacant: false),
    GreenScore(hour: 23, minute: 00, greenScore: 8, vacant: false),
  ];
  test(
      'testing that the best availlable greenscore is -1 returned when no slots are availlable.',
      () {
    List<DateTime> _slots = [];
    var startTime = DateTime(2022, 5, 1, 06, 0);
    _slots.add(startTime);
    for (int i = 0; i < 34; i++) {
      startTime = startTime.add(Duration(minutes: 30));
      _slots.add(startTime);
    }

    //act
    var result = calculateBestGreenScore(greenScoreList3, _slots);

    //assert
    expect(result, -1);
  });

  var greenScoreList4 = [
    GreenScore(hour: 06, minute: 00, greenScore: 8, vacant: true),
    GreenScore(hour: 06, minute: 30, greenScore: 8, vacant: true),
    GreenScore(hour: 07, minute: 00, greenScore: 8, vacant: true),
    GreenScore(hour: 07, minute: 30, greenScore: 8, vacant: true),
    GreenScore(hour: 08, minute: 00, greenScore: 8, vacant: false),
    GreenScore(hour: 08, minute: 30, greenScore: 8, vacant: false),
    GreenScore(hour: 09, minute: 00, greenScore: 8, vacant: false),
    GreenScore(hour: 09, minute: 30, greenScore: 8, vacant: false),
    GreenScore(hour: 10, minute: 00, greenScore: 8, vacant: false),
    GreenScore(hour: 10, minute: 30, greenScore: 8, vacant: false),
    GreenScore(hour: 11, minute: 00, greenScore: 8, vacant: false),
    GreenScore(hour: 11, minute: 30, greenScore: 8, vacant: false),
    GreenScore(hour: 12, minute: 00, greenScore: 4, vacant: false),
    GreenScore(hour: 12, minute: 30, greenScore: 4, vacant: false),
    GreenScore(hour: 13, minute: 00, greenScore: 4, vacant: false),
    GreenScore(hour: 13, minute: 30, greenScore: 4, vacant: false),
    GreenScore(hour: 14, minute: 00, greenScore: 4, vacant: false),
    GreenScore(hour: 14, minute: 30, greenScore: 4, vacant: false),
    GreenScore(hour: 15, minute: 00, greenScore: 1, vacant: false),
    GreenScore(hour: 15, minute: 30, greenScore: 1, vacant: false),
    GreenScore(hour: 16, minute: 00, greenScore: 1, vacant: true),
    GreenScore(hour: 16, minute: 30, greenScore: 1, vacant: true),
    GreenScore(hour: 17, minute: 00, greenScore: 1, vacant: true),
    GreenScore(hour: 17, minute: 30, greenScore: 1, vacant: true),
    GreenScore(hour: 18, minute: 00, greenScore: 4, vacant: true),
    GreenScore(hour: 18, minute: 30, greenScore: 4, vacant: false),
    GreenScore(hour: 19, minute: 00, greenScore: 4, vacant: false),
    GreenScore(hour: 19, minute: 30, greenScore: 4, vacant: false),
    GreenScore(hour: 20, minute: 00, greenScore: 4, vacant: false),
    GreenScore(hour: 20, minute: 30, greenScore: 8, vacant: false),
    GreenScore(hour: 21, minute: 00, greenScore: 8, vacant: true),
    GreenScore(hour: 21, minute: 30, greenScore: 8, vacant: true),
    GreenScore(hour: 22, minute: 00, greenScore: 8, vacant: true),
    GreenScore(hour: 22, minute: 30, greenScore: 8, vacant: true),
    GreenScore(hour: 23, minute: 00, greenScore: 8, vacant: true),
  ];
  test(
      'testing that the best availlable greenscore is -1 returned when no consecutive 6slots are availlable.',
      () {
    List<DateTime> _slots = [];
    var startTime = DateTime(2022, 5, 1, 06, 0);
    _slots.add(startTime);
    for (int i = 0; i < 34; i++) {
      startTime = startTime.add(Duration(minutes: 30));
      _slots.add(startTime);
    }

    //act
    var result = calculateBestGreenScore(greenScoreList4, _slots);

    //assert
    expect(result, -1);
  });

  var greenScoreList5 = [
    GreenScore(hour: 06, minute: 00, greenScore: 8, vacant: true),
    GreenScore(hour: 06, minute: 30, greenScore: 8, vacant: true),
    GreenScore(hour: 07, minute: 00, greenScore: 8, vacant: true),
    GreenScore(hour: 07, minute: 30, greenScore: 8, vacant: true),
    GreenScore(hour: 08, minute: 00, greenScore: 8, vacant: false),
    GreenScore(hour: 08, minute: 30, greenScore: 8, vacant: false),
    GreenScore(hour: 09, minute: 00, greenScore: 8, vacant: false),
    GreenScore(hour: 09, minute: 30, greenScore: 8, vacant: false),
    GreenScore(hour: 10, minute: 00, greenScore: 8, vacant: false),
    GreenScore(hour: 10, minute: 30, greenScore: 8, vacant: false),
    GreenScore(hour: 11, minute: 00, greenScore: 8, vacant: false),
    GreenScore(hour: 11, minute: 30, greenScore: 8, vacant: false),
    GreenScore(hour: 12, minute: 00, greenScore: 4, vacant: true),
    GreenScore(hour: 12, minute: 30, greenScore: 4, vacant: true),
    GreenScore(hour: 13, minute: 00, greenScore: 4, vacant: true),
    GreenScore(hour: 13, minute: 30, greenScore: 4, vacant: true),
    GreenScore(hour: 14, minute: 00, greenScore: 4, vacant: true),
    GreenScore(hour: 14, minute: 30, greenScore: 4, vacant: true),
    GreenScore(hour: 15, minute: 00, greenScore: 1, vacant: true),
    GreenScore(hour: 15, minute: 30, greenScore: 1, vacant: true),
    GreenScore(hour: 16, minute: 00, greenScore: 1, vacant: true),
    GreenScore(hour: 16, minute: 30, greenScore: 1, vacant: true),
    GreenScore(hour: 17, minute: 00, greenScore: 1, vacant: true),
    GreenScore(hour: 17, minute: 30, greenScore: 1, vacant: true),
    GreenScore(hour: 18, minute: 00, greenScore: 4, vacant: true),
    GreenScore(hour: 18, minute: 30, greenScore: 4, vacant: true),
    GreenScore(hour: 19, minute: 00, greenScore: 4, vacant: false),
    GreenScore(hour: 19, minute: 30, greenScore: 4, vacant: false),
    GreenScore(hour: 20, minute: 00, greenScore: 4, vacant: false),
    GreenScore(hour: 20, minute: 30, greenScore: 8, vacant: false),
    GreenScore(hour: 21, minute: 00, greenScore: 8, vacant: false),
    GreenScore(hour: 21, minute: 30, greenScore: 8, vacant: false),
    GreenScore(hour: 22, minute: 00, greenScore: 8, vacant: false),
    GreenScore(hour: 22, minute: 30, greenScore: 8, vacant: false),
    GreenScore(hour: 23, minute: 00, greenScore: 8, vacant: true),
  ];
  test(
      'testing that the best availlable greenscore is 24 returned when 6slots yellow slots are availlable.',
      () {
    List<DateTime> _slots = [];
    var startTime = DateTime(2022, 5, 1, 06, 0);
    _slots.add(startTime);
    for (int i = 0; i < 34; i++) {
      startTime = startTime.add(Duration(minutes: 30));
      _slots.add(startTime);
    }

    //act
    var result = calculateBestGreenScore(greenScoreList5, _slots);

    //assert
    expect(result, 24);
  });

}
