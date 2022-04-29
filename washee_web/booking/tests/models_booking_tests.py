import pytest
from datetime import datetime
import pytz

from rest_framework.exceptions import ValidationError
from booking.models import Booking

@pytest.mark.django_db(transaction=True, reset_sequences=True)
def test_save_booking_deducts_money_from_service_from_account(create_booking_func):
    price = 10
    balance = 30
    booking = create_booking_func(service_price=price, account_balance=balance)
    
    booking.save()
    
    assert booking.account.balance == balance - price
    

@pytest.mark.django_db(transaction=True, reset_sequences=True)
def test_saving_and_deleting_booking_does_not_change_balance_on_account(create_booking_func):
    balance = 30
    booking = create_booking_func(account_balance=balance)
    
    booking.save()
    booking.delete()
    
    assert booking.account.balance == balance
    

@pytest.mark.django_db(transaction=True, reset_sequences=True)
def test_updating_a_booking_should_not_change_the_balance(create_booking_func):
    balance = 30
    booking = create_booking_func(account_balance=balance)
    
    booking.save()
    changed_balance = booking.account.balance
    booking.save()
    
    assert booking.account.balance == changed_balance
    

@pytest.mark.django_db(transaction=True, reset_sequences=True)
def test_deleting_an_inactive_booking_should_be_an_error(create_booking_func):
    balance = 30
    booking = create_booking_func(account_balance=balance)
    
    booking.save()
    booking.delete()
    with pytest.raises(ValidationError):
        booking.delete()
    
    assert booking.account.balance == balance
    
    
@pytest.mark.django_db(transaction=True, reset_sequences=True)
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
    description, first_start_time, first_duration_in_sec, second_start_time, second_duration_in_sec, create_booking_func
    ):
    # Create booking on default machine
    first_booking = create_booking_func(
        booking_start_time=first_start_time, 
        service_duration=first_duration_in_sec,
        booking_active=True
    )
    # Create second booking on exact same machine
    second_booking = create_booking_func(
        booking_start_time=second_start_time, 
        service_duration=second_duration_in_sec,
        booking_active=True,
        machine_id=first_booking.machine.id
    )
    
    first_booking.save()
    with pytest.raises(ValidationError):
        second_booking.save()
    
    assert len(Booking.objects.all()) == 1, description