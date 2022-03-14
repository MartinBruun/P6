from ml_electricity.preprocessing.preprocessor import Preprocessor
import os
import pandas
import numpy as np


def test_that_we_can_get_data():
    # Arrange
    data_path = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__), "test_data.csv"))
    pandas_path = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__), "test_pandas.csv"))
    
    p = Preprocessor(data_path=data_path, pandas_data_path=pandas_path)
    # Act
    data = p.get_data()

    # Assert
    assert type(data) == pandas.DataFrame


def test_data_contains_the_correct_headers():
    # Arrange
    data_path = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__), "test_data.csv"))
    pandas_path = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__), "test_pandas.csv"))
    p = Preprocessor(data_path=data_path, pandas_data_path=pandas_path)

    expected_headers = np.array(['date', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24'])
    
    has_correct_headers = True
    # Act
    data = p.get_data()

    actual_headers = data.columns.values
    # Assert
    
    if expected_headers.shape != actual_headers.shape:
        has_correct_headers = False
        print("Wrong shape")

    i = 0
    for header in expected_headers:
        if header != actual_headers[i]:
            has_correct_headers = False
            print("Mismatched header")
            print(header + "!=" + actual_headers[i])
        i += 1

    assert has_correct_headers

def test_that_the_data_types_are_correct():
    # Arrange
    data_path = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__), "test_data.csv"))
    pandas_path = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__), "test_pandas.csv"))
    p = Preprocessor(data_path=data_path, pandas_data_path=pandas_path)
    
    has_correct_data_types = True
    
    # Act
    data = p.get_data()

    # Assert
    if data['date'].dtype != np.dtype('datetime64[ns]'):
        has_correct_data_types = False

    hours = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24'] 
    hour_types = data[hours].dtypes

    for hour_type in hour_types:
        if hour_type != np.dtype('float64'):
            has_correct_data_types = False

    assert has_correct_data_types


# def test_():
#     # Arrange
#     # Act
#     # Assert
#     assert False