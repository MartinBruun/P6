from electricity.ml_electricity.machine_learning.machine_learning import NordpoolML
import pandas
import numpy

def test_MI_training_that_a_model_is_created():
    # Arrange
    train_dataset = {
                'hour': [1 ,2 ,3 ,4 ,5 ,6 , 7],
                'price': [123, 234, 45, 456, 456, 567, 234]
            }
    data = pandas.DataFrame(train_dataset)

    x_train = data[['hour']]
    y_train = data[['price']]

    train_data = {'x': x_train, 'y': y_train}

    ml = NordpoolML()

    # Act
    ml.train(train_data)
    
    # Assert
    assert ml.model is not None

def test_score_is_up_to_our_standard():
    # Arrange
    standard = -1
    train_dataset = {
                'hour': [1 ,2 ,3 ,4 ,5 ,6 , 7],
                'price': [123, 234, 45, 456, 456, 567, 234]
            }
    test_dataset = {
                'hour': [1 ,2 ,3 ,4 ,5 ,6 , 7],
                'price': [123, 234, 45, 456, 456, 567, 234]
            }
    
    train_data_frame = pandas.DataFrame(train_dataset)
    test_data_frame = pandas.DataFrame(test_dataset)

    x_train = train_data_frame[['hour']]
    y_train = train_data_frame[['price']]

    x_test = test_data_frame[['hour']]
    y_test = test_data_frame[['price']]

    train_data = {'x': x_train, 'y': y_train}
    test_data = {'x': x_test, 'y': y_test}

    ml = NordpoolML()
    # Act
    ml.train(train_data)
    
    # Assert
    assert ml.score(test_data) >= standard

def test_a_predicton_can_be_made():
    # Arrange
    p = [[1], [2]]

    train_dataset = {
                'hour': [1 ,2 ,3 ,4 ,5 ,6 , 7],
                'price': [123, 234, 45, 456, 456, 567, 234]
            }
    data = pandas.DataFrame(train_dataset)

    x_train = data[['hour']]
    y_train = data[['price']]

    train_data = {'x': x_train, 'y': y_train}

    ml = NordpoolML()

    # Act
    ml.train(train_data)
    
    # Assert
    assert type(ml.predict(p)) == numpy.ndarray
    assert type(ml.predict(p)[0,0]) == numpy.float64

def test_data_is_split_in_2_with_combined_length_eq_to_original():
    # Arrange
    dataset = {
            'hour': [1 ,2 ,3 ,4 ,5 ,6 , 7],
            'price': [123, 234, 45, 456, 456, 567, 234]
        }
    data = pandas.DataFrame(dataset)
    
    ml = NordpoolML()
    # Act
    train_data, test_data = ml.split(data)
    
    # Assert
    assert len(dataset['hour']) == len(train_data['x']) + len(test_data['x'])

# def test_():
#     # Arrange
#     # Act
#     # Assert
#     assert False
