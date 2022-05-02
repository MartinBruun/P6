

// This should test, at its core, that activating a usecase with 1 active booking
// does indeed give the time until the end of that booking showed on screen

// Also, if there are 2 active bookings right after each other, the end time should be shown

// There are many examples where this can go wrong. Mock the Usecase to get the expected
// List of Bookings back from the Usecase