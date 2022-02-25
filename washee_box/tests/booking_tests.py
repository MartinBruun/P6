

def test_that_a_scheduler_can_restrict_access_if_no_machines_are_available(fake_configuration):
    # These tests are a presentation of an idea, NOT the concrete test!
    scheduler = Scheduler(fake_configuration)
    scheduler.available_services = []
    authorized_user_request = {
        "data": "data"
    }
    
    response = scheduler.schedule_machine(authorized_user_request)
    
    assert response["access_granted"] == False
    
def test_that_a_scheduler_responds_with_next_available_timeslot_if_none_are_available(fake_configuration):
    # These tests are a presentation of an idea, NOT the concrete test!
    scheduler = Scheduler(fake_configuration)
    scheduler.available_services = []
    scheduler.used_services = ["SomeServiceThatStopsAtSomeTime"]
    authorized_user_request = {
        "data": "data"
    }
    
    response = scheduler.schedule_machine(authorized_user_request)
    
    assert response["access_granted"] == False
    assert response["next_timeslot"] == "Some Service Time"
    
def test_that_the_scheduler_only_makes_non_booked_machines_available(fake_configuration):
    # These tests are a presentation of an idea, NOT the concrete test!
    scheduler = Scheduler(fake_configuration)
    scheduler.booked_services = ["Service1", "Service2"]
    scheduler.available_services = ["Service1", "Service2","Service3", "Service4"]
    scheduler.used_services = []
    authorized_user_request = {
        "data": "data"
    }
    
    response = scheduler.schedule_machine(authorized_user_request)
    
    assert response["access_granted"] == True
    assert False
    