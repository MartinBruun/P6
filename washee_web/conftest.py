import pytest
import pytz
from datetime import datetime

from booking.models import Booking
from account.models import User
from location.models import Service, MachineModel, Machine, Location
from electricity.models import ElectricityBlock
from security.models import Log

"""
    This file contains all fixtures for creating models used in the app.
    It defines their internal dependencies, which also can be seen in test_conftest.py at root.
    
    The structure is that there is a unique combination for each model.
    first_booking depends on first_account that depends on first_user etc.
    ALL tests are expected to change the models in the arrange step, so it is obvious what the test tests.
"""

@pytest.fixture
def first_user():
    user = User.objects.create_user(
        "test1@test.com",
        password="password"
    )
    user.username = "Test User 1"
    
    return user


@pytest.fixture
def second_user():
    user = User.objects.create_user(
        "test2@test.com",
        password="password"
    )
    user.username = "Test User 2"
    
    return user



@pytest.fixture
def first_account(first_user):
    first_user.save()
    account = first_user.accounts.create(
        name="Test Account 1",
        balance=100,
    )
    
    return account


@pytest.fixture
def second_account(second_user):
    second_user.save()
    account = second_user.accounts.create(
        name="Test Account 2",
        balance=100,
    )
    
    return account

@pytest.fixture
def first_machine_model():
    machine_model = MachineModel(
        name="Machine Model 1"
    )
    
    return machine_model

@pytest.fixture
def second_machine_model():
    machine_model = MachineModel(
        name="Machine Model 2"
    )
    
    return machine_model

@pytest.fixture
def first_service(first_machine_model):
    first_machine_model.save()
    service = Service(
        price_in_dk=10, 
        duration_in_sec=100,
        machine_model=first_machine_model
    )
    
    return service


@pytest.fixture
def second_service(second_machine_model):
    second_machine_model.save()
    service = Service(
        price_in_dk=10, 
        duration_in_sec=100,
        machine_model=second_machine_model
    )
    
    return service


@pytest.fixture
def first_location(first_user):
    first_user.save()
    location = Location(
        name="Test Location 1",
        owner=first_user
    )
    
    return location


@pytest.fixture
def second_location(second_user):
    second_user.save()
    location = Location(
        name="Test Location 2",
        owner=second_user
    )
    
    return location

@pytest.fixture
def first_machine(first_user, first_machine_model, first_location):
    first_user.save()
    first_machine_model.save()
    first_location.save()
    machine = Machine(
        name="Test Machine 1",
        location=first_location,
        model=first_machine_model,
        owner=first_user
    )
    
    return machine

@pytest.fixture
def second_machine(second_user, second_machine_model, second_location):
    second_user.save()
    second_machine_model.save()
    second_location.save()
    machine = Machine(
        name="Test Machine 1",
        location=second_location,
        model=second_machine_model,
        owner=second_user
    )
    
    return machine


@pytest.fixture
@pytest.mark.django_db
def first_booking(first_account, first_service, first_machine):
    first_account.save()
    first_service.save()
    first_machine.save()
    booking = Booking(
        start_time=datetime.now(pytz.UTC),
        active=True,
        activated=False,
        account=first_account, 
        service=first_service,
        machine=first_machine
    )
    
    return booking


@pytest.fixture
@pytest.mark.django_db
def second_booking(second_account, second_service, second_machine):
    second_account.save()
    second_service.save()
    second_machine.save()
    booking = Booking(
        start_time=datetime.now(pytz.UTC),
        active=True,
        activated=False,
        account=second_account, 
        service=second_service,
        machine=second_machine
    )
    
    return booking


@pytest.fixture
@pytest.mark.django_db
def first_electricity_block():
    electricity_block = ElectricityBlock(
        start_time = datetime.now(pytz.UTC),
        end_time = datetime.now(pytz.UTC),
        price = 10,
        zone=ElectricityBlock.ZoneChoices.WEST_DK
    )
    
    return electricity_block


@pytest.fixture
@pytest.mark.django_db
def second_electricity_block():
    electricity_block = ElectricityBlock(
        start_time = datetime.now(pytz.UTC),
        end_time = datetime.now(pytz.UTC),
        price = 10,
        zone=ElectricityBlock.ZoneChoices.EAST_DK
    )
    
    return electricity_block


@pytest.fixture
@pytest.mark.django_db
def first_log(first_user):
    first_user.save()
    log = Log(
        content="Test Log 1",
        source=Log.SourceChoices.MANUAL,
        user=first_user
    )
    
    return log


@pytest.fixture
@pytest.mark.django_db
def second_log(second_user):
    second_user.save()
    log = Log(
        content="Test Log 2",
        source=Log.SourceChoices.APP,
        user=second_user
    )
    
    return log