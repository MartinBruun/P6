import pytest

from rest_framework.exceptions import ValidationError
from booking.models import Booking

def test_booking_can_be_initialized():
    booking = Booking()
    
    assert True

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
def test_deleting_an_inactive_booking_should_have_no_effect(create_booking_func):
    balance = 30
    booking = create_booking_func(account_balance=balance)
    
    booking.save()
    booking.delete()
    with pytest.raises(ValidationError):
        booking.delete()
    
    assert booking.account.balance == balance