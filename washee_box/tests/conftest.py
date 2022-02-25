import pytest

@pytest.fixture
def fake_configuration():
    """
        A dictionary containing the initial configurtion of the Scheduler.
        How many machines does it have? Any other configuration needed in case of a restart.
    """
    return {
        "some":"config"
    }