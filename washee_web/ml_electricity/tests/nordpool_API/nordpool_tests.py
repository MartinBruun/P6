from operator import index
from textwrap import indent
from ml_electricity.nordpool_API.Nordpool import NordpoolAPI
import os

# we cannot test this without putting secrets on github
# def test_data_can_be_fetched():
#     # Arrange
#     # Act
#     # Assert
#     assert False

def test_data_decodes_correctly():
    # Arrange
    mock_data_path = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__), "..", "coded_data.csv"))
    mock_ftp = Mock_ftp(mock_data_path) 
    
    test_access_data_path = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__), "test_nordpool.json"))
    
    test_save_data_path = ""
    
    np = NordpoolAPI(test_access_data_path, test_save_data_path, mock_ftp)
    
    # Act

    np.ftp_retrieve("path", "filename")

    f = open(test_save_data_path)
    data = f.readlines()
    
    # Assert
    column_count = 0
    line_count = 0

    # check each line below the headers has more than 35 columns
    for line in data:
        for i in line:
            if i == ";":
                column_count += 1
        if line_count > 5:
            assert column_count >= 35
        column_count = 0
        line_count += 1

# def test_data_is_saved_in_the_correct_location():
#     # Arrange
#     # Act
#     # Assert
#     assert False

# def test_():
#     # Arrange
#     # Act
#     # Assert
#     assert False