# autostart
The Simplest way to make your application as servce by addapting ``versatile systemctl unit file`` and providing ``useful command`` for system starting/stoping/status-checking.

## For what application?
This is for application:

- started with calling single command file, in other words ``Type=simple``.
- the name of the folder is the same as the command file name.

For example:

```
├───foo
│    foo

```

## how does this works
Recognize command to start from folder name, and make systemctl unit file.


## install
Copy ```autostart``` and ```makeunitfile.sh``` files in your project.

## how to use
```
./autostart -h
Usage: ./autostart [--on]/[--off]
  [--on]:               Set autostart as ON. 
  [--off]:              Set autostart as OFF. 
  [--status]:           Show current status. 
  [--version]:          Show version.
```

- on:
  Link unit file to /etc/systemd/system folder and issue both **enable** and **start**
  
  1. Link systemd unit file (Automatically created in this folder if not exist) to /etc/systemd/system/.
  2. systemctl daemon-reload
  3. systemctl enable
  4. systemctl start
 
- off:  
  1. systemctl stop
  2. systemctl disable


## history
- v1.0.0: 2024.06.18 created by advancing of [autostart](https://github.com/UedaTakeyuki/autostart).
