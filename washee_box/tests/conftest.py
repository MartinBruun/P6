import pytest

from washee_box import washee_box_entry

"""
    This sets up the necessary code for making a must_pass mark to the fixtures.
    This sets it so that if some fixture tests fail, they will make sure to skip tests that use those fixtures.
    This makes it much easier to see, that it is in fact the fixture that fails, and not the logic itself.
"""


def pytest_runtest_makereport(item, call):
    if item.iter_markers(name='must_pass'):
        if call.excinfo is not None:
            parent = item.parent
            parent._mpfailed = item


def pytest_runtest_setup(item):
    must_pass_failed = getattr(item.parent, '_mpfailed', None)
    if must_pass_failed is not None:
        pytest.skip('must pass test failed (%s)' % must_pass_failed.name)


@pytest.mark.must_pass
@pytest.fixture
def client():
    washee_box_entry.app.config['TESTING'] = True

    with washee_box_entry.app.test_client() as client:
        yield client
