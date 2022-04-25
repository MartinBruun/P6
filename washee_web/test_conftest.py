import pytest
import pytz
from datetime import datetime

from booking.models import Booking
from account.models import User, Account
from location.models import Service, MachineModel, Machine, Location

@pytest.mark.django_db
def test_booking_fixture_returns_a_booking_with_correct_foreignkey_models(create_booking_func):
    booking = create_booking_func()
    
    assert type(booking) is Booking
    assert type(booking.account) is Account
    assert type(booking.service) is Service
    assert type(booking.machine) is Machine
    
@pytest.mark.django_db
def test_booking_fixture_returns_a_valid_default_booking(create_booking_func):
    booking = create_booking_func()
    
    booking.save()
    
    assert True
    

@pytest.mark.django_db
@pytest.mark.parametrize(
    "start_time",[
        (datetime.now(pytz.UTC))
    ]
)
def test_booking_fixture_can_be_customized_for_start_time(start_time, create_booking_func):
    booking = create_booking_func(booking_start_time=start_time)
    
    assert booking.start_time == start_time
    
@pytest.mark.django_db
@pytest.mark.parametrize(
    "active",[
        (True),
        (False)
    ]
)
def test_booking_fixture_can_be_customized_for_active(active, create_booking_func):
    booking = create_booking_func(booking_active=active)
    
    assert booking.active == active
    
@pytest.mark.django_db
@pytest.mark.parametrize(
    "activated",[
        (True),
        (False)
    ]
)
def test_booking_fixture_can_be_customized_for_activated(activated, create_booking_func):
    booking = create_booking_func(booking_activated=activated)
    
    assert booking.activated == activated
    
@pytest.mark.django_db
@pytest.mark.parametrize(
    "name, balance",[
        ("TestName", -100),
        ("Test Name", 0),
        ("Test Name ", 100),
    ]
)
def test_booking_fixture_can_be_customized_for_account(name, balance, create_booking_func):
    booking = create_booking_func(account_name=name, account_balance=balance)
    
    assert booking.account.name == name
    assert booking.account.balance == balance
    
@pytest.mark.django_db
@pytest.mark.parametrize(
    "price, duration",[
        (0, 1),
        (10, 100),
        (100, 10000),
    ]
)
def test_booking_fixture_can_be_customized_for_service(price, duration, create_booking_func):
    booking = create_booking_func(service_price=price, service_duration=duration)
    
    assert booking.service.price_in_dk == price
    assert booking.service.duration_in_sec == duration
    
@pytest.mark.django_db
@pytest.mark.parametrize(
    "name",[
        ("TestMachine"),
        ("Test Machine"),
    ]
)
def test_booking_fixture_can_be_customized_for_machine(name, create_booking_func):
    booking = create_booking_func(machine_name=name)
    
    assert booking.machine.name == name