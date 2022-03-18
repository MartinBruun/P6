#this file is not currently used  but it could be in the future
if __name__ == '__main__':
    app.secret_key = 'super_secret_key' # your app key
    app.debug = True # set to true if you want to enable debug
    app.run(host='0.0.0.0', port=8000) # change port according to your needs