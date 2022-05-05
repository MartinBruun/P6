import 'package:flutter_test/flutter_test.dart';

void main() {
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
    Map<String, dynamic> bestSlot = {"id":greenScoreInput[0]["id"],"value":-1};
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
      print("best slot:"+ bestSlot.toString());
    }

    expect(bestSlot["id"],17);
    expect(bestSlot["value"],40);
    /*expect(selectableBookings[0]["value"], 6);
    expect(selectableBookings[1]["value"], 9);
    expect(selectableBookings[2]["value"], 12);
    expect(selectableBookings[3]["value"], 41);*/
  });
}

