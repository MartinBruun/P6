

// Change the Usecase to instead take in a Booking as a parameter.
// Also change it so booking har MachineModel and AccountModel etc. as its attributes
// Each Model should then have a .resource attribute, specifying its rest resource point.

// The Usecase should live up to this:
// A Usecase takes in a List of BookingModels and gets back a List of booking models
// (This simplifies, since then time and machine is bound to one model instead)
// It needs to be a list, so it is possible to activate multiple bookings in a row

// The usecase should only make some simple validation that each of the bookings are indeed in
// correct order, before sending it to the repository, and getting the same bookings back
// (except now they are activated of course)

// Plenty of possibilities in testing when each of these steps might go wrong.