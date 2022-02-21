from account.models import Account

def test_account_can_be_initialized():
    account = Account()
    
    assert True