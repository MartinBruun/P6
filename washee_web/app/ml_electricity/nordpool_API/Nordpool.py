# Press Shift+F10 to execute it or replace it with your code.
# Press Double Shift to search everywhere for classes, files, tool windows, actions, and settings.
import json
import ftplib


class NordpoolAPI:
    __url = ""
    __username = ""
    __password = ""
    __access_data_path = "nordpool.json"

    def __init__(self):
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
            file.write(str(line) + "\n")

        file.close()

    def __print_data(self, data):
        for line in data:
            print(line)
        print("-----END-----")

    def __decode(self, data):

        decoded_data = []

        for line in data:
            for chunk in line.split(b'\r\n'):
                (str(chunk))
                decoded_data.append(chunk)
        return decoded_data

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

    nordpool.ftp_retrieve(path, file)
    # nordpool.ftp_dir(path)
