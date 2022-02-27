import pandas
from preprocessing.preprocessor import Preprocessor
from nordpool_API.Nordpool import NordpoolAPI
from machine_learning.machine_learning import NordpoolML

class MIcontroller:

    def __init__(self):
        self.ml = NordpoolML()
        self.preproces = Preprocessor()

    def update_data(self):
        path = "/Elspot/Elspot_prices/Denmark/Denmark_West"
        file = "odedkk22.sdv"
        
        nordpool = NordpoolAPI()
        nordpool.ftp_retrieve(path, file)

    def train(self):
        data = self.preproces.get_data()
        self.ml.split(data)
        self.ml.train()


    def predict(self, data):
        return self.ml.predict(data)

    # def score(self):
    #     return self.model.score()

if __name__ == '__main__':

    dataset = {
            'day': [1, 2, 3, 3, 5, 6, 7],
            'time': [1 ,2 ,3 ,4 ,5 ,6 , 7],
            'price': [123, 234, 45, 456, 456, 567, 234]
        }
    data = pandas.DataFrame(dataset)

    controller = MIcontroller()

    controller.train()
    print(controller.predict([[1,2], [2,4]]))
    print(controller.ml.score())
    