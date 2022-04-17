from electricity.ml_electricity.preprocessing.preprocessor import Preprocessor
import pandas as pd
import numpy as np
from unittest.mock import MagicMock

def test_that_we_can_get_data(mocker, test_pandas_data):
    # Arrange
    df = pd.DataFrame(test_pandas_data)
    mocker.patch('electricity.ml_electricity.preprocessing.preprocessor.pandas.read_csv', return_value=df)

    p = Preprocessor()

    # Act
    data = p.get_data()

    # Assert
    assert type(data) == pd.DataFrame

def test_that_we_can_prune_data(mocker, test_data):
    # Arrange
    mocker.patch('electricity.ml_electricity.preprocessing.preprocessor.open', return_value=MagicMock())

    mocker.patch('electricity.ml_electricity.preprocessing.preprocessor.csv.reader', return_value=test_data)

    p = Preprocessor()
    # Act
    data = p.prune_data()

    # Assert
    assert type(data) == pd.DataFrame


def test_pruned_data_contains_the_correct_headers(mocker, test_data):
    # Arrange
    mocker.patch('electricity.ml_electricity.preprocessing.preprocessor.open', return_value=MagicMock())

    mocker.patch('electricity.ml_electricity.preprocessing.preprocessor.csv.reader', return_value=test_data)
 
    p = Preprocessor()

    expected_headers = np.array(['date', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24'])
    
    has_correct_headers = True
    # Act
    data = p.prune_data()

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


def test_pruned_data_has_correct_data_types(mocker, test_data):
    # Arrange

    mocker.patch('electricity.ml_electricity.preprocessing.preprocessor.open', return_value=MagicMock())

    mocker.patch('electricity.ml_electricity.preprocessing.preprocessor.csv.reader', return_value=test_data)

    p = Preprocessor()
    
    has_correct_data_types = True
    
    # Act
    data = p.prune_data()

    # Assert
    if data['date'].dtype != np.dtype('datetime64[ns]'):
        has_correct_data_types = False

    hours = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24'] 
    hour_types = data[hours].dtypes

    for hour_type in hour_types:
        if hour_type != np.dtype('float64'):
            has_correct_data_types = False

    assert has_correct_data_types

def test_we_can_reshape_data(test_pandas_data):
    # Arrange
    df = pd.DataFrame(test_pandas_data)

    p = Preprocessor()
    # Act
    test_pandas_data = p.reshape_Hour_on_day_prediction(df)
    
    # Assert
    assert type(test_pandas_data) == pd.DataFrame

def test_reshaped_data_has_the_correct_headers(test_pandas_data):
    # Arrange
    df = pd.DataFrame(test_pandas_data)

    p = Preprocessor()

    expected_headers = np.array(['date', 'hour', 'price'])
    
    has_correct_headers = True
    # Act
    data = p.reshape_Hour_on_day_prediction(df)

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

# def test_():
#     # Arrange
#     # Act
#     # Assert
#     assert False