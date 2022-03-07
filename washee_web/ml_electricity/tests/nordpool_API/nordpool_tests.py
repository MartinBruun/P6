import ftplib
from operator import index
from textwrap import indent
from typing_extensions import Self
from unittest import mock
import csv

from pandas import array
from ml_electricity.nordpool_API.Nordpool import NordpoolAPI
import os


class Mock_FTP:
    def __init__(self, path):
        self.path = path
    
    def login(self, username, password):
        self.username = username
        self.password = password

    def cwd(self, path):
        return

    def retrbinary(self, cmd, callback):
        file = open(self.path)
        data = csv.reader(file)
        for row in data:
            callback(data)

    def quit(self):
        return


def test_Nordpool_API_can_be_mocked():
    # Arrange
    mock_data_path = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__), "..", "coded_data.csv")) 
    mock_ftp = Mock_FTP(mock_data_path)
    
    test_access_data_path = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__), "test_nordpool.json"))
    
    test_save_data_path = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__), "test_nordpool_retrieved_data.csv"))
    
    # Act
    np = NordpoolAPI(access_data_path=test_access_data_path, save_data_path=test_save_data_path, ftp=mock_ftp)

    np.ftp_retrieve("path", "filename")

    # Assert
    assert True

# def test_decoded_data_do_not_have_unnecesary_line_breaks():
#     # Arrange
#     mock_data_path = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__), "..", "coded_data.csv"))
#     mock_ftp = Mock_FTP(mock_data_path) 
    
#     test_access_data_path = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__), "test_nordpool.json"))
    
#     test_save_data_path = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__), "test_nordpool_retrieved_data.csv"))
    
#     np = NordpoolAPI(test_access_data_path, test_save_data_path, mock_ftp)
    
#     # Act
#     data = np.ftp_retrieve("path", "filename")

    
#     # Assert
#     column_count = 0
#     line_count = 0


#     # check each line below the headers has more than 35 columns
#     for line in data:
#         for i in line:
#             if i == ";":
#                 column_count += 1
#         if line_count > 5:
#             assert column_count >= 35
#         column_count = 0
#         line_count += 1

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