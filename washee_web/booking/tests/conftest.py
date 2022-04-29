import pytest
import pytz
from datetime import datetime

from booking.models import Booking
from account.models import User
from location.models import Service, MachineModel, Machine, Location

"""
    This file contains all fixtures for creating models used in the app.
    Requirements:
    Each fixture uses other fixtures or its own model. Nothing more.
    Each fixture should set some valid default values.
    Each fixture default to returning a non-saved instance.
"""

@pytest.fixture
@pytest.mark.django_db
def first_booking():
    """
        Creates the first booking used in any test.
        Values with a 1, 2 or similar appended, are values that need to be unique
    """
    user = User.objects.create_user( # Should be remade as a fixture controlled in accounts
        "test1@test.com",
        password="password"
    )
    user.username = "Test User 1"
    user.save()
    account = user.accounts.create( # Should be remade as a fixture controlled in accounts
        name="Test Account 1",
        balance=100,
    )
    account.save()
    machine_model = MachineModel( # Should be remade as a fixture controlled in locations
        name="Machine Model 1"
    )
    machine_model.save()
    service = Service( # Should be remade as a fixture controlled in locations
        price_in_dk=10, 
        duration_in_sec=100,
        machine_model=machine_model
    )
    service.save()
    location = Location( # Should be remade as a fixture controlled in locations
        name="Test Location 1",
        owner=user
    )
    location.save()
    machine = Machine( # Should be remade as a fixture controlled in locations
        name="Test Machine 1",
        location=location,
        model=machine_model,
        owner=user
    )
    machine.save()
    booking = Booking(
        start_time=datetime.now(pytz.UTC),
        active=True,
        activated=False,
        account=account, 
        service=service,
        machine=machine
    )
    
    return booking


@pytest.fixture
@pytest.mark.django_db
def second_booking():
    """
        Creates the second booking used in any test.
        Values with a 1, 2 or similar appended, are values that need to be unique
    """
    user = User.objects.create_user( # Should be remade as a fixture controlled in accounts
        "test2@test.com",
        password="password"
    )
    user.username = "Test User 2"
    user.save()
    account = user.accounts.create( # Should be remade as a fixture controlled in accounts
        name="Test Account 2",
        balance=100,
    )
    account.save()
    machine_model = MachineModel( # Should be remade as a fixture controlled in locations
        name="Machine Model 2"
    )
    machine_model.save()
    service = Service( # Should be remade as a fixture controlled in locations
        price_in_dk=10, 
        duration_in_sec=100,
        machine_model=machine_model
    )
    service.save()
    location = Location( # Should be remade as a fixture controlled in locations
        name="Test Location 2",
        owner=user
    )
    location.save()
    machine = Machine( # Should be remade as a fixture controlled in locations
        name="Test Machine 2",
        location=location,
        model=machine_model,
        owner=user
    )
    machine.save()
    booking = Booking(
        start_time=datetime.now(pytz.UTC),
        active=True,
        activated=False,
        account=account, 
        service=service,
        machine=machine
    )
    
    return booking