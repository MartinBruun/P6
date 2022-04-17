import pandas
from electricity.ml_electricity.preprocessing.preprocessor import Preprocessor
from electricity.ml_electricity.nordpool_API.Nordpool import NordpoolAPI
from electricity.ml_electricity.machine_learning.machine_learning import NordpoolML

class MIcontroller:

    def __init__(self):
        self.ml = NordpoolML()
        self.preprocessor = Preprocessor()

    def update_data(self):
        path = "/Elspot/Elspot_prices/Denmark/Denmark_West"
        file = "odedkk22.sdv"
        
        nordpool = NordpoolAPI()
        nordpool.ftp_retrieve(path, file)
        data = self.preprocessor.prune_data()
        data = self.preprocessor.reshape_Hour_on_day_prediction(data)
        self.preprocessor.save_data(data)

    def train(self):
        data = self.preprocessor.get_data()
        self.ml.split(data)
        self.ml.train()


    def predict(self, data):
        return self.ml.predict(data)

    # def score(self):
    #     return self.model.score()

if __name__ == '__main__':
    controller = MIcontroller()
    controller.update_data()
    
    controller.train()
    print(controller.predict([[1], [2]]))
    print(controller.ml.score())
    