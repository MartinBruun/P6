from machine_learning.machine_learning import NordpoolML
import pandas

def test_MI_training_that_a_model_is_created():
    # Arrange
    dataset = {
                'day': ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"],
                'time': [1 ,2 ,3 ,4 ,5 ,6 , 7],
                'price': [123, 234, 45, 456, 456, 567, 234]
            }

    data = pandas.DataFrame(dataset)
    ml = NordpoolML()

    # Act
    ml.train_linear_regression(data)
    
    # Assert
    assert ml.model is not None

def test_score_is_up_to_our_standard():
    # Arrange
    standard = 0
    ml = NordpoolML()
    
    # Act
    ml.train()
    
    # Assert
    assert ml.model.score() >= standard

def test_():
    # Arrange
    # Act
    # Assert
    assert False