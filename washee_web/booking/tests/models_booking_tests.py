import pytest

from booking.models import Booking

def test_booking_can_be_initialized():
    booking = Booking()
    
    assert True
    

def test_booking_can_return_a_list_of_current_bookings():
    # Arrange?
    
    existing_bookings = Booking.current_bookings(location_id=1)
    
    # Assert?
    
    
def test_booking_can_be_saved():
    # There is some specific django way this is done
    booking_request = {
        "id": "1"
    }
    
    Booking.objects.save(booking_request)
    
    assert 1 == len(Booking.objects.get(id=1))


def test_booking_should_not_save_an_overlapping_booking(fake_location_with_1_service):
    # Arrange 2 identical bookings
    fake_location_with_1_service.location = "id1"
    booking1 = {"time": "15:26", "type": "bla", "location": "id1"}
    booking2 = {"time": "15:27", "type": "bla", "location": "id1"}
    
    Booking.save(booking1)
    
    with pytest.raises(SomeCustomException) as e:
        Booking.save(booking2)
    
    #Assert only 1 booking happened