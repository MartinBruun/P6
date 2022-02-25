import pandas
class preprocessor:

    def get_data(self):

            dataset = {
                'day': ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"],
                'time': [1 ,2 ,3 ,4 ,5 ,6 , 7],
                'price': [123, 234, 45, 456, 456, 567, 234]
            }

            return pandas.DataFrame(dataset)