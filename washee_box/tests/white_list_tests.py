
def test_that_a_user_gets_authenticated_by_a_token():
    list = WhiteList()
    user_request = {
        "data": "data"
    }
    
    authenticated = list.authenticate(user_request)
    
    assert authenticated["response"] == True
    
    
def test_the_user_gets_not_authenticated_by_invalid_token():
    list = WhiteList()
    invalid_user_request = {
        "data": "data"
    }
    
    authenticated = list.authenticate(invalid_user_request)
    
    assert authenticated["response"] == False