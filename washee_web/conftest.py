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
def create_booking_func():
    """
        Creates a booking.
    """
    def _create_booking(
        user_username="Test User",
        user_email="test@test.com",
        user_password="password",
        account_name="Test Account", 
        account_balance=100, 
        machine_model_name="Test Machine Model",
        service_price=10, 
        service_duration=5,
        location_name="Test Location",
        machine_name="Test Machine",
        booking_start_time=datetime.now(pytz.UTC),
        booking_active=True,
        booking_activated=False,
    ):
        user = User.objects.create_user( # Should be remade as a fixture controlled in accounts
            user_email,
            password=user_password
        )
        user.username = user_username
        user.save()
        account = user.accounts.create( # Should be remade as a fixture controlled in accounts
            name=account_name,
            balance=account_balance,
        )
        account.save()
        machine_model = MachineModel( # Should be remade as a fixture controlled in locations
            name=machine_model_name
        )
        machine_model.save()
        service = Service( # Should be remade as a fixture controlled in locations
            price_in_dk=service_price, 
            duration_in_sec=service_duration,
            machine_model=machine_model
        )
        service.save()
        location = Location( # Should be remade as a fixture controlled in locations
            name=location_name,
            owner=user
        )
        location.save()
        machine = Machine( # Should be remade as a fixture controlled in locations
            name=machine_name,
            location=location,
            model=machine_model,
            owner=user
        )
        machine.save()
        booking = Booking(
            start_time=booking_start_time,
            active=booking_active,
            activated=booking_activated,
            account=account, 
            service=service,
            machine=machine
        )
        
        return booking
    
    return _create_booking