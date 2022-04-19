import os
import tempfile

import pytest

from washee_box import washee_box_entry

@pytest.fixture
def client():
    washee_box_entry.app.config['TESTING'] = True

    with washee_box_entry.app.test_client() as client:
        yield client
