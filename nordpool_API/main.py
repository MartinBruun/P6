# Press Shift+F10 to execute it or replace it with your code.
# Press Double Shift to search everywhere for classes, files, tool windows, actions, and settings.
import json
import ftplib


def get_nordpool_access_data():
    file = open('nordpool.json')

    nordpool = json.load(file)

    return nordpool


def ftp_request(nordpool):
    url = nordpool["url"]
    username = nordpool["username"]
    password = nordpool["password"]

    ftp = ftplib.FTP(url)
    ftp.login(username, password)

    data = []

    ftp.dir(data.append)

    ftp.quit()
    for line in data:
        print(line)



if __name__ == '__main__':
    nordpool = get_nordpool_access_data()
    ftp_request(nordpool)
