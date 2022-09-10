# Bash Scripts

A repository for simple bash scripts to do simple tasks.


## File Description
* <strong>banner</strong><br>
Displays a banner with given message, color and decorator.<br>
Options:
  * -c|--color<br>
  Text color.
  * -d|--decorator<br>
  Decorator around message.
  * -m|--message<br>
  Message to be displayed.
```bash
$ banner -d '#' "Hello World!"
################
# Hello World! #
################
```
* <strong>factorial</strong><br>
Get the factorial of a number.
```bash
$ factorial 3
6
```
* <strong>greet</strong><br>
Displays a greeting message for a user.<br>
Options:
  * -m|--morning<br>
  Toggle morning instead of evening.
  * -n|--name<br>
  User name.
```bash
$ greet Amr
Good evening Amr!
$ greet -m Sayyad
Good morning Sayyad!
```
* <strong>options</strong><br>
Print Hello World with color selected from options menu.
```bash
$ options
Choose color:
- Change option: [up/down], Select: [ENTER] 
 Black 
 Red 
 Green 
 Yellow 
 Blue 
 Magenta 
 Cyan 
 White 

Hello World!
```
* <strong>pacman</strong><br>
Display given string, then pacman eats it letter by letter with given delay.<br>
Options:
  * -i|--interval<br>
  Interval for pacman to wait between eating letters.
  * -p|--padding<br>
  Leftover padding after letter was eaten.
  * -s|--string<br>
  String to be displayed.
```bash
$ pacman
.....co World'
```
* <strong>progress_bar</strong><br>
Progress bar that can be implemented in any other bash script.
```bash
$ progress_bar 
|█████████...........|     / 46% [ Installing foo... ]
```
* <strong>sortbody</strong><br>
Only sort the body of input string, leaving the header fixed in place.<br>
Note that in the example below, using `sort` will print the header on the last line.
```bash
$ df -h | sortbody -k 5
Filesystem      Size  Used Avail Use% Mounted on
tmpfs           5.0M     0  5.0M   0% /run/lock
tmpfs           7.8G   29M  7.8G   1% /dev/shm
tmpfs           1.6G  2.2M  1.6G   1% /run
tmpfs           1.6G  200K  1.6G   1% /run/user/1000
/dev/nvme0n1p5   47G   10G   35G  23% /
/dev/sda2       187G   69G  109G  39% /home
/dev/nvme0n1p7  667M  336M  332M  51% /boot/efi
```
* <strong>template</strong><br>
A template to use for creating bash scripts.
* <strong>urldecode</strong><br>
Decodes given encoded URL.<br>
Options:
  * -f|--file<br>
  Input file to read encoded URLs from.
```bash
$ echo "https%3A%2F%2Fmedium.com%2F%40ftrain%2Fbig-data-small-effort-b62607a43a8c" | urldecode 
https://medium.com/@ftrain/big-data-small-effort-b62607a43a8c
```
* <strong>urlencode</strong><br>
Encodes given URL.<br>
Options:
  * -f|--file<br>
  Input file to read URLs from.
```bash
$ echo "https://medium.com/@ftrain/big-data-small-effort-b62607a43a8c" | urlencode 
https%3A%2F%2Fmedium.com%2F%40ftrain%2Fbig-data-small-effort-b62607a43a8c
```
* <strong>wifi_connect</strong><br>
Connect to the strongest known wifi signal, given regex for SSID.<br>
Note: regex is written in the script. This needs to be modified, in order to make it usable.
