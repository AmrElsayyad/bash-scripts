# Bash Scripts

A list of template bash scripts with various features, that can be used in large projects.


## File Description

### - banner
Displays a banner with given message, color and decorator.

Example:
```bash
$ banner -d '#' "Hello World!"
################
# Hello World! #
################
```

### - factorial
Get the factorial of a number.

Example:
```bash
$ factorial 3
6
```

### - greet
Displays a greeting message for a user.

Example:
```bash
$ greet Amr
Good evening Amr!
$ greet -m Sayyad
Good morning Sayyad!
```

### - options
Print Hello World with color selected from options menu.

Example:
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

### - pacman
Display given string, then pacman eats it letter by letter with given delay.

Example:
```bash
$ pacman
.....co World'
```

### - progress_bar
Progress bar that can be implemented in any other bash script.

Example:
```bash
$ progress_bar 
|█████████...........|     / 46% [ Installing foo... ]
```

### - sortbody
Only sort the body of input string, leaving the header fixed in place.

Example:
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
Note that in the example below, using `sort` will print the header on the last line.

### - template
A template to use for creating bash scripts.

### - urldecode
Decodes given encoded URL.

Example:
```bash
$ echo "https%3A%2F%2Fmedium.com%2F%40ftrain%2Fbig-data-small-effort-b62607a43a8c" | urldecode 
https://medium.com/@ftrain/big-data-small-effort-b62607a43a8c
```

### - urlencode
Encodes given URL.

Example:
```bash
$ echo "https://medium.com/@ftrain/big-data-small-effort-b62607a43a8c" | urlencode 
https%3A%2F%2Fmedium.com%2F%40ftrain%2Fbig-data-small-effort-b62607a43a8c
```

### - wifi_connect
Connect to the strongest known wifi signal, given regex for SSID.<br>
Note: regex is written in the script. This needs to be modified, in order to make it usable.
