import numpy
from nordpool_API.Nordpool import NordpoolAPI
from machine_learning.machine_learning import NordpoolML

def learn(path, file):
    nordpool = NordpoolAPI()
    nordpool.ftp_retrieve(path, file)
    
    data = get_data()
    
    ml = NordpoolML(data)
    ml.train_linear_regression()
    ml.predict([[1,2]])


def get_data():

    dataset = {
        'day': ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"],
        'time': [1 ,2 ,3 ,4 ,5 ,6 , 7],
        'price': [123, 234, 45, 456, 456, 567, 234]
    }

    return pandas.DataFrame(dataset)

if __name__ == '__main__':
    path = "/Elspot/Elspot_prices/Denmark/Denmark_West"
    file = "odedkk22.sdv"
    
    learn(path, file)
    