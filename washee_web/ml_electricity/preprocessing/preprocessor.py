import pandas
import csv
import os

class Preprocessor:

    def __init__(self):
        self.data_path = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__), "..", "data.csv"))
        self.pandas_data_path = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__), "..", "pandas.csv"))

    def build_dataframe(self):
        df = pandas.read_csv(self.pandas_data_path)
        
        df.drop(['3B', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34' ], axis=1, inplace=True)

        df.to_csv(self.pandas_data_path)
        
        

    def prune_data(self):
        file = open(self.data_path, 'r')
        reader = csv.reader(file)
        
        data = []

        # only appends rows below the headers
        i = 0
        for row in reader:
            if i > 5:
                j = 0
                for value in row:
                    value = value.replace('.', '-')
                    row[j] = value.replace(',', '.')
                    j += 1
                data.append(row)
            i += 1

        file.close()

        # create an empty dataframe with column names
        df = pandas.DataFrame(columns=[
            'date', '1', '2', '3', '3B', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', 
            '25', '26', '27', '28', '29', '30', '31', '32', '33', '34'])

        number_of_columns = len(data[0])

        # add each row from the dataset to the end of the dataframe
        for row in data:
            if len(row) == number_of_columns:
                df.loc[len(df.index)] = row
        
        df.drop(['3B', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34' ], axis=1, inplace=True)

        hours = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24'] 
        # changes the datatype of the collumns
        df[hours] = df[hours].apply(pandas.to_numeric)
        df['date'] = df[['date']].apply(pandas.to_datetime)

        df.dropna(inplace=True)
        
        df.to_csv(self.pandas_data_path, index=False)

        return self.pandas_data_path



    def get_data(self):
        path = self.prune_data()
        df = pandas.read_csv(path)
        df['date'] = df[['date']].apply(pandas.to_datetime)

        return df

if __name__ == '__main__':
    p = Preprocessor()

    print(p.get_data())
    # p.build_dataframe()