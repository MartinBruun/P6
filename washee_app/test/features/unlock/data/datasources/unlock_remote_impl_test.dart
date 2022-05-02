

// Test that the remote has a unlockBoxAndUpdateBooking method

// Given expected results from their respective communicators and NetworkInfo,
// make sure that it:
// 1. makes sure there is internet connection
// 2. updates the bookings (this also serves as validation that the bookings are real, and internet access is possible)
// 3. makes sure there is connection to the box
// 4. unlocks the box properly
// 5. disconnects from the box
// 6. return a List<Map<String,dynamic>> of the updated bookings

// In case of errors in unlocking the box, the program should update the bookings back to their
// proper state (also, this should throw a specific failure which should be logged, and give
// some error message to the user, such as "if you have lost your money, please contact XXX
// or similar")

// The good solution would of course be to make this update into a consumable that will try everytime
// the app is open to properly update the backend until it gets correct response.
// This is however a whole other issue, which should be thought into the design much more,
// on par with the Logger functionality (made as its own issue)