import pytest
import pytz
from datetime import datetime

from booking.models import Booking
from account.models import Account
from location.models import Service, Machine

@pytest.mark.django_db
def test_create_booking_func_makes_functioning_default_booking(create_booking_func):
    default_booking = create_booking_func()
    
    assert type(default_booking) is Booking
    assert type(default_booking.account) is Account
    assert type(default_booking.service) is Service
    assert type(default_booking.machine) is Machine
    

@pytest.mark.django_db
@pytest.mark.parametrize(
    "description, start_time",
    [
        ("Can it set some years ago", datetime(2003, 1, 2, 3, 15, 30, 0, pytz.UTC)),
        ("Can it set now", datetime.now(pytz.UTC)),
        ("Can it set far into the future", datetime(2320, 10, 8, 8, 30, 0, 0, pytz.UTC))   
    ]
)
def test_create_booking_func_can_set_start_time(description, start_time, create_booking_func):
    booking = create_booking_func(booking_start_time=start_time)
    
    assert booking.start_time == start_time, description
    

@pytest.mark.django_db
@pytest.mark.parametrize(
    "description, active",
    [
        ("Can it set to active", True),
        ("Can it set to inactive", False)
    ]
)
def test_create_booking_func_can_set_active(description, active, create_booking_func):
    booking = create_booking_func(booking_active=active)
    
    assert booking.active == active, description
    

@pytest.mark.django_db
@pytest.mark.parametrize(
    "description, activated",
    [
        ("Can it set to activated", True),
        ("Can it set to not activated", False)
    ]
)
def test_create_booking_func_can_set_active(description, activated, create_booking_func):
    booking = create_booking_func(booking_activated=activated)
    
    assert booking.activated == activated, description
    

@pytest.mark.django_db
@pytest.mark.parametrize(
    "name, balance",[
        ("TestName", -100),
        ("Test Name", 0),
        ("Test Name ", 100),
    ]
)
def test_booking_fixture_can_set_account(name, balance, create_booking_func):
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
def test_booking_fixture_can_set_service(price, duration, create_booking_func):
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
def test_booking_fixture_can_set_machine(name, create_booking_func):
    booking = create_booking_func(machine_name=name)
    
    assert booking.machine.name == name
    

@pytest.mark.django_db
@pytest.mark.parametrize(
    "name",[
        ("TestMachine"),
        ("Test Machine"),
    ]
)
def test_booking_fixture_can_set_booking_to_previously_defined_machine(name, create_booking_func):
    first_booking = create_booking_func(machine_name=name)
    second_booking = create_booking_func(machine_id=first_booking.machine.id)
    
    assert first_booking.machine.id == second_booking.machine.id