# Press Shift+F10 to execute it or replace it with your code.
# Press Double Shift to search everywhere for classes, files, tool windows, actions, and settings.
from hashlib import new
import json
import ftplib
import os
from typing import Type
from unittest import mock
import csv


class NordpoolAPI:

    __REQUIRED_COLUMNS = 35

    def __init__(self, ftp = None):
        
        path = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__), "nordpool.json"))
        
        data = self.__get_nordpool_access_data(path)

        self.__url = data["url"]
        self.__username = data["username"]
        self.__password = data["password"]

        self.__save_data_path = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__), "..", "data.csv"))
        
        if ftp == None:
            self.__ftp = ftplib.FTP(self.__url)
        else:
            self.__ftp = ftp

    def __get_nordpool_access_data(self, path):
        file = open(path)

        data = json.load(file)
        
        return data

    def __save_data(self, data):
        file = open(self.__save_data_path, 'w', newline="")
        print(file)
        print(type(file))
        writer = csv.writer(file)

        for line in data:
            writer.writerow(line.split(";"))

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
                line = (str(line)).lstrip("b'").rstrip("'").rstrip("\\r").lstrip("\\n")
                data_lines.append(line)

        # join lines that are split incorrecly
        # lines are considered to be split incorrecly if they:
        #   Are not in the header section (the first 5 lines)
        #   && they have fewer than 35 semicolons
        #   && that that end of file have not been reached
        i = 0
        for line in data_lines:
            if (i > 5 
                and self.__number_of_columns(line) < self.__REQUIRED_COLUMNS
                and len(data_lines) > i + 1):

                    data_lines[i+1] = str(line) + str(data_lines[i+1])
                    data_lines.pop(i)
            elif line == "":
                data_lines.pop(i)

            i += 1

        return data_lines

    def __number_of_columns(self, line):
        count = 0
        for i in line:
            if i == ";":
                count += 1
        return count

    def ftp_retrieve(self, path, filename):
        
        self.__ftp.login(self.__username, self.__password)

        self.__ftp.cwd(path)

        data = []

        # # The normal way to retrieve data with ftp. this doesn't work with the data we need for some reason
        # ftp.retrlines("RETR " + filename, data.append)

        self.__ftp.retrbinary("RETR " + filename, data.append)

        self.__ftp.quit()

        data = self.__decode(data)
        
        self.__save_data(data)

        return data

    def __ftp_dir(self, path):
        self.__ftp.login(self.__username, self.__password)

        self.__ftp.cwd(path)

        data = []

        self.__ftp.dir(data.append)

        self.__ftp.quit()

        self.__print_data(data)


if __name__ == '__main__':
    nordpool = NordpoolAPI()


    # # path and file that works with regular decoding
    # path = "/Operating_data/Denmark"
    # file = "podk2207.sdv"

    path = "/Elspot/Elspot_prices/Denmark/Denmark_West"
    file = "odedkk22.sdv"

    # print("hello")
    data = nordpool.ftp_retrieve(path, file)



    # # check each line below the headers has more than 35 columns
    # for line in data:
    #     for character in line:
    #         if character == ";":
    #             column_count += 1
    #     print(column_count)
    #     if line_count > 5 and column_count < 35:# 35:
    #         is_ok = False 
    #     column_count = 0
    #     line_count += 1


    # nordpool.__ftp_dir(path)
