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
            file.write(line + "\n")

        file.close()

    def __print_data(self, data):
        for line in data:
            print(line)
        print("-----END-----")

    def ftp_retrieve(self, path, filename):
        ftp = ftplib.FTP(self.__url)
        ftp.login(self.__username, self.__password)

        ftp.cwd(path)

        data = []

        ftp.retrlines("RETR " + filename, data.append)

        self.__save_data(data)

        ftp.quit()


if __name__ == '__main__':
    nordpool = NordpoolAPI()
    path = "/Operating_data/Denmark"
    file = "podk2207.sdv"
    nordpool.ftp_retrieve(path, file)

