# Deauth Attack on Wifi
Performing a DDOS on a WLAN by deauth everyOne out of the wifi.
Let s suppose wlan0 is the ESSID of my WLAN.

## Test if your Wireless Card supports monitor 'mode'
1) First test if it suspports injections by doing 
`aireplay-ng -9 wlan0`
Search for the word ' injection is working'
2) Find the physical name of your wifi card:
```
airmon-ng
// answer should be like phy0 
```
3) Run:
sources
