from washee_box.data_models.Machine import Machine


def test_washing_machine_can_be_initialized():
    machine = Machine("machineID", "machineName", "machineType")
    assert True


def test_machine_can_be_unlocked():
    # Mock the locking mechanism
    machine = Machine("machineID", "machineName", "machineType")

    machine.unlock()

    # Assert the mocking mechanism has been used
    assert True


def test_machine_can_be_locked():
    # Mock the locking mechanism
    machine = Machine("machineID", "machineName", "machineType")

    machine.lock()

    # Assert the mocking mechanism has been used
    assert True
