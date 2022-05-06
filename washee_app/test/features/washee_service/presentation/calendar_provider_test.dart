import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:washee/core/helpers/green_score_database.dart';
import 'package:washee/features/booking/presentation/provider/calendar_provider.dart';

void main() {
  // var calendar = Provider.of<CalendarProvider>(null, listen: false);

  List<Map<String, dynamic>> greenScoreInput = [
    {"id": 0, "vacant": true, "value": 1},
    {"id": 1, "vacant": true, "value": 1},
    {"id": 2, "vacant": true, "value": 1},
    {"id": 3, "vacant": true, "value": 1},
    {"id": 4, "vacant": true, "value": 1},
    {"id": 5, "vacant": true, "value": 1},
    {"id": 6, "vacant": true, "value": 4},
    {"id": 7, "vacant": true, "value": 4},
    {"id": 8, "vacant": false, "value": 4},
    {"id": 9, "vacant": false, "value": 4},
    {"id": 10, "vacant": false, "value": 4},
    {"id": 11, "vacant": false, "value": 4},
    {"id": 12, "vacant": false, "value": 4},
    {"id": 13, "vacant": false, "value": 4},
    {"id": 14, "vacant": false, "value": 4},
    {"id": 15, "vacant": false, "value": 4},
    {"id": 16, "vacant": false, "value": 4},
    {"id": 17, "vacant": true, "value": 4},
    {"id": 18, "vacant": true, "value": 4},
    {"id": 19, "vacant": true, "value": 8},
    {"id": 20, "vacant": true, "value": 8},
    {"id": 21, "vacant": true, "value": 8},
    {"id": 16, "vacant": false, "value": 4},
    {"id": 17, "vacant": true, "value": 4},
    {"id": 18, "vacant": true, "value": 4},
    {"id": 19, "vacant": true, "value": 8},
    {"id": 20, "vacant": true, "value": 8},
    {"id": 21, "vacant": true, "value": 8},
    {"id": 22, "vacant": true, "value": 8},
  ];

  test('testing selection algorithm', () {
    //List<Map<String, dynamic>> selectableBookings = [];
    Map<String, dynamic> bestSlot = {
      "id": greenScoreInput[0]["id"],
      "value": -1
    };
    //look at each timeslot
    for (int index = 0; index < greenScoreInput.length; index++) {
      var allowedInBestSlot = true;
      int sum = 0;
      //if index is at least 6 timeslots from the last timeslot try to calculate the sum
      if (index + 5 < greenScoreInput.length) {
        //from every timeslot look on 6 consecutive timeslots
        for (var j in Iterable.generate(6)) {
          int subIndex = index + (j as int);

          //if any of the 6 timeslots are already booked don't count it
          if (greenScoreInput[subIndex]["vacant"] == false) {
            allowedInBestSlot = false;
            sum = 0;
          }
          //if none of the 6 timeslots has been booked add this slots value to the sum.
          else if (allowedInBestSlot) {
            sum += greenScoreInput[subIndex]["value"] as int;
          }
        }
        //if all the 6 timeslots are vacant, update bestSlot to the hightst value of the currently storred and the sum value
        if (allowedInBestSlot) {
          if (bestSlot["value"] as int < sum) {
            bestSlot = {
              "id": greenScoreInput[index]["id"],
              "value": sum,
            };
          }
        }
        allowedInBestSlot = true;
      }
      print("best slot:" + bestSlot.toString());
    }

    expect(bestSlot["id"], 17);
    expect(bestSlot["value"], 40);
    /*expect(selectableBookings[0]["value"], 6);
    expect(selectableBookings[1]["value"], 9);
    expect(selectableBookings[2]["value"], 12);
    expect(selectableBookings[3]["value"], 41);*/
  });

  //__________________________________

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

  var greenScoreList1 = [
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
    GreenScore(hour: 15, minute: 00, greenScore: 1, vacant: true),
    GreenScore(hour: 15, minute: 30, greenScore: 1, vacant: true),
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
    GreenScore(hour: 21, minute: 00, greenScore: 8, vacant: false),
    GreenScore(hour: 21, minute: 30, greenScore: 8, vacant: false),
    GreenScore(hour: 22, minute: 00, greenScore: 8, vacant: false),
    GreenScore(hour: 22, minute: 30, greenScore: 8, vacant: false),
    GreenScore(hour: 23, minute: 00, greenScore: 8, vacant: false),
  ];
  test(
      'testing that the best availlable greenscore is returned from when star is booked',
      () {
    List<DateTime> _slots = [];
    var startTime = DateTime(2022, 5, 1, 06, 0);
    _slots.add(startTime);
    for (int i = 0; i < 34; i++) {
      startTime = startTime.add(Duration(minutes: 30));
      _slots.add(startTime);
    }

    //act
    var result = calculateBestGreenScore(greenScoreList1, _slots);

    //assert
    expect(result, 8);
  });

  var greenScoreList2 = [
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
    GreenScore(hour: 15, minute: 00, greenScore: 1, vacant: true),
    GreenScore(hour: 15, minute: 30, greenScore: 1, vacant: true),
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
    GreenScore(hour: 21, minute: 00, greenScore: 8, vacant: false),
    GreenScore(hour: 21, minute: 30, greenScore: 8, vacant: false),
    GreenScore(hour: 22, minute: 00, greenScore: 8, vacant: false),
    GreenScore(hour: 22, minute: 30, greenScore: 8, vacant: false),
    GreenScore(hour: 23, minute: 00, greenScore: 8, vacant: false),
  ];
  test(
      'testing that the best availlable greenscore is returned when some slots are availlable in the beginning but not enough to form 6 slots.',
      () {
    List<DateTime> _slots = [];
    var startTime = DateTime(2022, 5, 1, 06, 0);
    _slots.add(startTime);
    for (int i = 0; i < 34; i++) {
      startTime = startTime.add(Duration(minutes: 30));
      _slots.add(startTime);
    }

    //act
    var result = calculateBestGreenScore(greenScoreList2, _slots);

    //assert
    expect(result, 8);
  });

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
    var result = calculateBestGreenScore(greenScoreList5, _slots);

    //assert
    expect(result, 24);
  });

}
