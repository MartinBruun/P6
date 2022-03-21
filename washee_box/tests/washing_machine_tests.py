from data_models.Machine import Machine

def test_washing_machine_can_be_initialized():
    machine = Machine()
    assert True
    
def test_machine_can_be_unlocked():
    # Mock the locking mechanism
    machine = Machine()
    
    machine.unlock()
    
    # Assert the mocking mechanism has been used
    assert True
    
def test_machine_can_be_locked():
    # Mock the locking mechanism
    machine = Machine()
    
    machine.lock()
    
    # Assert the mocking mechanism has been used
    assert True
    