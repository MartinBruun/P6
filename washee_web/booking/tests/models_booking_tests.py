import pytest

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
def test_saving_and_deleting_booking_does_not_change_balance(create_booking_func):
    price = 10
    balance = 30
    booking = create_booking_func(service_price=price, account_balance=balance)
    
    booking.save()
    booking.delete()
    
    assert booking.account.balance == balance