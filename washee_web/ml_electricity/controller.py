import pandas
from preprocessing.preprocessor import preprocessor
from nordpool_API.Nordpool import NordpoolAPI
from machine_learning.machine_learning import NordpoolML

class MIcontroller:

    def update_data(self, path, file):
        nordpool = NordpoolAPI()
        nordpool.ftp_retrieve(path, file)

    def training(self):
        data = preprocessor.get_data("path")
        
        ml = NordpoolML(data)
        self.model = ml.train_linear_regression()


        # result = ml.predict([[1,2]])
        # print(result)

    def predict(self, data):
        return self.model.predict(data)


if __name__ == '__main__':
    path = "/Elspot/Elspot_prices/Denmark/Denmark_West"
    file = "odedkk22.sdv"
    
    controller = MIcontroller()

    controller.training(path, file)
    