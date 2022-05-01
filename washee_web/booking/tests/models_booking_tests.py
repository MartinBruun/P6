import pytest
import pytz
from datetime import datetime, timedelta

from rest_framework.exceptions import ValidationError
from booking.models import Booking

@pytest.mark.django_db
def test_save_booking_deducts_money_from_service_from_account(create_booking_func):
    price = 10
    balance = 30
    booking = create_booking_func(service_price=price, account_balance=balance)
    
    booking.save()
    
    assert booking.account.balance == balance - price
    

@pytest.mark.django_db
def test_saving_and_deleting_booking_does_not_change_balance_on_account(create_booking_func):
    balance = 30
    booking = create_booking_func(account_balance=balance)
    
    booking.save()
    booking.delete()
    
    assert booking.account.balance == balance
    

@pytest.mark.django_db
def test_updating_a_booking_should_not_change_the_balance(create_booking_func):
    balance = 30
    booking = create_booking_func(account_balance=balance)
    
    booking.save()
    changed_balance = booking.account.balance
    booking.save()
    
    assert booking.account.balance == changed_balance
    

@pytest.mark.django_db
def test_deleting_an_inactive_booking_should_be_an_error(create_booking_func):
    balance = 30
    booking = create_booking_func(account_balance=balance)
    
    booking.save()
    booking.delete()
    with pytest.raises(ValidationError):
        booking.delete()
    
    assert booking.account.balance == balance
    
    
@pytest.mark.django_db
def test_booking_should_be_named_deleted_when_inactive(create_booking_func):
    booking = create_booking_func(booking_active=False)
    
    booking.save()
    
    assert "(deleted)" in str(booking)
    
    
@pytest.mark.django_db
def test_booking_should_be_named_active_when_active_and_not_activated_when_end_time_havent_been_passed_yet(create_booking_func):
    end_time = datetime.now(pytz.UTC) + timedelta(days=1)
    booking = create_booking_func(booking_active=False, booking_activated=False, booking_end_time=end_time)
    
    booking.save()
    
    assert "(active)" in str(booking)
    
    
@pytest.mark.django_db
def test_booking_should_be_named_skipped_when_active_and_not_activated_when_end_time_have_been_passed(create_booking_func):
    end_time = datetime.now(pytz.UTC) - timedelta(days=1)
    booking = create_booking_func(booking_active=False, booking_activated=False, booking_end_time=end_time)
    
    booking.save()
    
    assert "(skipped)" in str(booking)
    
    
@pytest.mark.django_db
def test_booking_should_be_named_activated_when_active_and_has_been_activated(create_booking_func):
    booking = create_booking_func(booking_active=False, booking_activated=True)
    
    booking.save()
    
    assert "(activated)" in str(booking)