from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split


class NordpoolML:

    def __init__(self, data):
        self.data = data
        self.model = None
                
    def train_linear_regression(self):

        # x represents independent variables
        # y represents the dependent variable
        x = self.data[['day', 'time']]

        y = self.data[['price']]

        x_train, x_test, y_train, y_test = train_test_split(x, y)

        self.model = LinearRegression()

        self.model.fit(x_train.values.reshape(-1, 2), y_train.values.reshape(-1, 1))

        return self.model.score(x_test.values.reshape(-1, 2), y_test.values.reshape(-1, 1))

    def predict(self, data):
        return self.model.predict(data)
