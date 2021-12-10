from src.main import main

def test_main_does_not_crash():
    try:
        main()
        assert True
    except Exception as e:
        assert False, e.message