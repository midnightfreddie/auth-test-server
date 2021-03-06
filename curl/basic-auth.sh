#!/bin/sh

# curl has the --user parameter to specify username and password.
# I have also added --basic which may help on some servers that
# need the auth header on the first request instead of negotiating
# authorization method over multiple requests.

username=authtestusername
password=authtestpassword
uri=http://authtest.midnightfreddie.com/basicauth/stuff.json

curl --basic --user $username:$password "$uri"
