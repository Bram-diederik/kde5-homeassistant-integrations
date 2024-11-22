This scripts make a dynamic dns setup for dnsmasq
For example if you have a slow 24/7 server and a fast none 24/7 and you want to use the faster server for whisper and piper setup for a faster experience in home assistant.


place dyndnsmasq.sh in /usr/local/bin

and make a root bin folder and adapt the example scripts for all your ddns clients (you need to restart dnsmasq and the code is easy to read so your fine)
run it in a crontab every minute. 
