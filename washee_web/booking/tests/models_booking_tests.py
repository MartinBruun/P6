import pytest
from datetime import datetime, timedelta
import pytz

from rest_framework.exceptions import ValidationError
from booking.models import Booking

@pytest.mark.django_db
def test_save_booking_deducts_money_from_service_from_account(first_booking):
    price = 10
    balance = 30
    first_booking.service.price = price
    first_booking.account.balance = balance
    
    first_booking.save()
    
    assert first_booking.account.balance == balance - price
    

@pytest.mark.django_db
def test_saving_and_deleting_booking_does_not_change_balance_on_account(first_booking):
    balance = 30
    first_booking.account.balance = balance
    
    first_booking.save()
    first_booking.delete()
    
    assert first_booking.account.balance == balance
    

@pytest.mark.django_db
def test_updating_a_booking_should_not_change_the_balance(first_booking):
    balance = 30
    first_booking.account.balance = balance
    
    first_booking.save()
    changed_balance = first_booking.account.balance
    first_booking.save()
    
    assert first_booking.account.balance == changed_balance
    

@pytest.mark.django_db
def test_deleting_an_inactive_booking_should_be_an_error(first_booking):
    balance = 30
    first_booking.account.balance = balance
    
    first_booking.save()
    first_booking.delete()
    with pytest.raises(ValidationError):
        first_booking.delete()
    
    assert first_booking.account.balance == balance
    
    
@pytest.mark.django_db
@pytest.mark.parametrize(
    "description, first_start_time, first_duration_in_sec, second_start_time, second_duration_in_sec",
    [
        (
            "Testing exact same booking", 
            datetime(2022, 4, 22, 12, 0, 0, 0, pytz.UTC), 
            10, 
            datetime(2022, 4, 22, 12, 0, 0, 0, pytz.UTC), 
            10
        ),
        (
            "Testing second time starting 30 seconds too early", 
            datetime(2022, 4, 22, 11, 0, 30, 0, pytz.UTC), 
            3600, 
            datetime(2022, 4, 22, 12, 0, 0, 0, pytz.UTC), 
            3600
        ),
        (
            "Testing second time start 30 seconds too soon", 
            datetime(2022, 4, 22, 12, 59, 30, 0, pytz.UTC), 
            3600, 
            datetime(2022, 4, 22, 12, 0, 0, 0, pytz.UTC), 
            3600
        )
    ]
)
def test_overlapping_active_bookings_on_same_machine_gets_thrown_an_error(
    description, 
    first_start_time, first_duration_in_sec, 
    second_start_time, second_duration_in_sec, 
    first_booking, second_booking
    ):
    first_booking.start_time = first_start_time
    first_booking.service.duration_in_sec = first_duration_in_sec
    first_booking.active = True
    
    second_booking.start_time = second_start_time
    second_booking.service.duration_in_sec = second_duration_in_sec
    second_booking.active = True
    second_booking.machine = first_booking.machine
    
    first_booking.save()
    with pytest.raises(ValidationError):
        second_booking.save()
    
    
@pytest.mark.django_db
def test_booking_should_be_named_deleted_when_inactive(first_booking):
    first_booking.active = False
    
    assert "(deleted)" in str(first_booking)
    
    
@pytest.mark.django_db
def test_booking_should_be_named_active_when_active_and_not_activated_when_end_time_havent_been_passed_yet(first_booking):
    first_booking.active = True
    first_booking.activated = False
    first_booking.end_time = datetime.now(pytz.UTC) + timedelta(days=1)
    
    assert "(active)" in str(first_booking)
    
    
@pytest.mark.django_db
def test_booking_should_be_named_skipped_when_active_and_not_activated_when_end_time_have_been_passed(first_booking):
    first_booking.active = True
    first_booking.activated = False
    first_booking.end_time = datetime.now(pytz.UTC) - timedelta(days=1)
    
    assert "(skipped)" in str(first_booking)
    
    
@pytest.mark.django_db
def test_booking_should_be_named_activated_when_active_and_has_been_activated(first_booking):
    first_booking.active = True
    first_booking.activated = True
    
    assert "(activated)" in str(first_booking)
