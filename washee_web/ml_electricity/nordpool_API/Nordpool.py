# Press Shift+F10 to execute it or replace it with your code.
# Press Double Shift to search everywhere for classes, files, tool windows, actions, and settings.
import json
import ftplib
import os


class NordpoolAPI:

    def __init__(self):
        
        self.__access_data_path = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__), "nordpool.json"))
        
        data = self.__get_nordpool_access_data()

        self.__url = data["url"]
        self.__username = data["username"]
        self.__password = data["password"]

    def __get_nordpool_access_data(self):
        file = open(self.__access_data_path)

        data = json.load(file)
        
        return data

    def __save_data(self, data):
        file = open("data.csv", 'w')

        for line in data:
            file.write(line + "\n")

        file.close()

    def __print_data(self, data):
        for line in data:
            print(line)
        print("-----END-----")

    def __decode(self, data):

        # make all bytes into strings
        for i in range(0, len(data)):
            data[i] = str(data[i])

        # split data chunks into lines and remove byte encoding (b'string here')
        data_lines = []
        for chunk in data:
            for line in chunk.split('\\r\\n'):
                line = (str(line)).lstrip("b'").rstrip("'")
                
                data_lines.append(line)

        # join lines that are split incorrecly
        # lines are considered to be split incorrecly if they:
        #   Are not in the header section (the first 5 lines)
        #   And they have fewer than 35 semicolons
        #   And that that end of file have not been reached
        i = 0
        for line in data_lines:
            if (i > 5 
                and self.__number_of_semicolon(line) < 35
                and len(data_lines) > i + 1):

                    data_lines[i+1] = str(line) + str(data_lines[i+1])
                    data_lines.pop(i)

            i += 1

        return data_lines

    def __number_of_semicolon(self, line):
        count = 0
        for i in line:
            if i == ";":
                count += 1
        return count

    def ftp_retrieve(self, path, filename):
        ftp = ftplib.FTP(self.__url)
        ftp.login(self.__username, self.__password)

        ftp.cwd(path)

        data = []

        # # The normal way to retrieve data with ftp. this doesn't work with the data we need for some reason
        # ftp.retrlines("RETR " + filename, data.append)

        ftp.retrbinary("RETR " + filename, data.append)

        ftp.quit()

        data = self.__decode(data)

        self.__save_data(data)

    def ftp_dir(self, path):
        ftp = ftplib.FTP(self.__url)
        ftp.login(self.__username, self.__password)

        ftp.cwd(path)

        data = []

        ftp.dir(data.append)

        ftp.quit()

        self.__print_data(data)


if __name__ == '__main__':
    nordpool = NordpoolAPI()


    # # path and file that works with regular decoding
    # path = "/Operating_data/Denmark"
    # file = "podk2207.sdv"

    path = "/Elspot/Elspot_prices/Denmark/Denmark_West"
    file = "odedkk22.sdv"

    # print("hello")
    nordpool.ftp_retrieve(path, file)
    # nordpool.ftp_dir(path)
