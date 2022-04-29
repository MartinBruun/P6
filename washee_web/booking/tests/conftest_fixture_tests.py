import pytest

from booking.models import Booking
from account.models import Account
from location.models import Service, Machine

@pytest.mark.django_db
def test_first_booking_has_functioning_default_booking(first_booking):
    first_booking.save()
    
    assert type(first_booking) is Booking
    assert type(first_booking.account) is Account
    assert type(first_booking.service) is Service
    assert type(first_booking.machine) is Machine
    
@pytest.mark.django_db
def test_second_booking_has_functioning_default_booking(second_booking):    
    second_booking.save()
    
    assert type(second_booking) is Booking
    assert type(second_booking.account) is Account
    assert type(second_booking.service) is Service
    assert type(second_booking.machine) is Machine