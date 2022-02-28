from ml_electricity.machine_learning.machine_learning import NordpoolML
import pandas

def test_MI_training_that_a_model_is_created():
    # Arrange
    train_dataset = {
                'day': [1, 2, 3, 3, 5, 6, 7],
                'time': [1 ,2 ,3 ,4 ,5 ,6 , 7],
                'price': [123, 234, 45, 456, 456, 567, 234]
            }
    data = pandas.DataFrame(train_dataset)

    x_train = data[['day', 'time']]
    y_train = data[['price']]

    train_data = {'x': x_train, 'y': y_train}

    ml = NordpoolML()

    # Act
    ml.train(train_data)
    
    # Assert
    assert ml.model is not None

# def test_score_is_up_to_our_standard():
#     # Arrange
#     standard = -1
#     ml = NordpoolML()
    
#     # Act
#     ml.train(trainData, testData)
    
#     # Assert
#     assert ml.model.score() >= standard
