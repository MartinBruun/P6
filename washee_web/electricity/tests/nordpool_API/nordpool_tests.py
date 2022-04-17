from electricity.ml_electricity.nordpool_API.Nordpool import NordpoolAPI
from unittest.mock import MagicMock

def test_Nordpool_API_can_be_mocked(mocker, mock_ftp, test_access_data):
    # Arrange    
    mocker.patch('electricity.ml_electricity.nordpool_API.Nordpool.open', return_value=MagicMock())
    mocker.patch('electricity.ml_electricity.nordpool_API.Nordpool.json.load', return_value=test_access_data)

    npAPI = NordpoolAPI(ftp=mock_ftp)

    # Act
    npAPI.ftp_retrieve("path", "filename")

    # Assert
    assert True

def test_decoded_data_does_not_have_unnecesary_line_breaks(mocker, mock_ftp, test_access_data):
    # Arrange
    mocker.patch('electricity.ml_electricity.nordpool_API.Nordpool.open', return_value=MagicMock())
    mocker.patch('electricity.ml_electricity.nordpool_API.Nordpool.json.load', return_value=test_access_data)

    npAPI = NordpoolAPI(ftp=mock_ftp)

    # disables the save_data method
    npAPI.__save_data = False

    # Act

    data = npAPI.ftp_retrieve("path", "filename")
    
    # Assert
    column_count = 0
    line_count = 0

    No_unnecesary_line_breaks = True

    # check each line below the headers has more than 35 columns
    for line in data:
        for character in line:
            if character == ";":
                column_count += 1
        if line_count > 5 and column_count < 35:
            print(line)
            print(column_count)
            No_unnecesary_line_breaks = False 
        column_count = 0
        line_count += 1
    
    assert No_unnecesary_line_breaks

def test_decoded_data_does_not_contain_byte_encoding(mocker, mock_ftp, test_access_data):
    # Arrange
    mocker.patch('electricity.ml_electricity.nordpool_API.Nordpool.open', return_value=MagicMock())
    mocker.patch('electricity.ml_electricity.nordpool_API.Nordpool.json.load', return_value=test_access_data)

    npAPI = NordpoolAPI(ftp=mock_ftp)

    # disables the save_data method
    npAPI.__save_data = False
        
    # Act
    
    data = npAPI.ftp_retrieve("path", "filename")
    
    # Assert
    No_byte_encoding = True

    # check each line below the headers has more than 35 columns
    for line in data:
        
        if "b'" in line:
            print(line)
            No_byte_encoding = False 
    
    assert No_byte_encoding

def test_decoded_data_does_not_contain_new_lines(mocker, mock_ftp, test_access_data):
    # Arrange
    mocker.patch('electricity.ml_electricity.nordpool_API.Nordpool.open', return_value=MagicMock())
    mocker.patch('electricity.ml_electricity.nordpool_API.Nordpool.json.load', return_value=test_access_data)

    npAPI = NordpoolAPI(ftp=mock_ftp)

    # disables the save_data method
    npAPI.__save_data = False

    # Act

    data = npAPI.ftp_retrieve("path", "filename")

    # Assert
    No_line_breaks = True

    # check each line below the headers has more than 35 columns
    for line in data:
        if ("\\r\\n" in line
        or "\\n" in line
        or "\\r" in line):
            print(line)
            No_line_breaks = False

    assert No_line_breaks

# def test_():
#     # Arrange
#     # Act
#     # Assert
#     assert False