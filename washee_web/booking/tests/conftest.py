import pytest

from location.models import Location, Service

@pytest.fixture
def fake_location_with_1_service():
    location = Location()
    
    # Create a Service that is connected to the location
    
    return location