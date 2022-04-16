from sklearn import datasets
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
import pandas

class NordpoolML:

    def __init__(self, ):
        self.train_data:dict = None
        self.test_data: dict = None
        self.model = None
                
    def __train_linear_regression(self, train_data = None):

        if(train_data == None):
            train_data = self.train_data

        self.model = LinearRegression()

        self.model.fit(train_data['x'].values.reshape(-1, 1), train_data['y'].values.reshape(-1, 1))

        return self.model

    def split(self, data):
 
        # x represents independent variables
        # y represents the dependent variable
        x = data[['hour']]
        y = data[['price']]
        
        x_train, x_test, y_train, y_test = train_test_split(x, y)

        self.train_data = {'x': x_train, 'y': y_train}
        self.test_data = {'x': x_test, 'y': y_test}

        return self.train_data, self.test_data

    def train(self, train_data = None):
        return self.__train_linear_regression(train_data)

    def score(self, test_data = None):
        if test_data == None:
            test_data = self.test_data
        return self.model.score(test_data['x'].values.reshape(-1, 1), test_data['y'].values.reshape(-1, 1))

    def predict(self, data):
        return self.model.predict(data)


if __name__ == '__main__':
    dataset = {
                'hour': [1 ,2 ,3 ,4 ,5 ,6 , 7],
                'price': [123, 234, 45, 456, 456, 567, 234]
            }
    data = pandas.DataFrame(dataset)

    x_train = data[['hour']]
    y_train = data[['price']]

    train_data = {'x': x_train, 'y': y_train}

    ml = NordpoolML()
    # train_data, test_data = ml.split(data)
    
    ml.train(train_data)

    # print(ml.score())

    print(ml.predict([[1]]))