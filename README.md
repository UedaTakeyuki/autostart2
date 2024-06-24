# autostart2
The ***autostart2*** provides the simplest way to make your application a **Systemd service** supported. All you have to do is only ```autostart --on```, this will do all the tedious work of making the appropriate unit file, linking it to the appropriate folder, daemon-reloading, enabling, and starting. For you with a lot of technical experience, these are just tedious tasks, but　it can be a nightmare for end users with no technical experience who are told by you to “configure and use it as the Systemd service.”　Instead, "do ```autostart --on```" would be a kind, easy, and helpful instruction even end users can execute well.

## How does this work?
Suppose you have a folder like [time](https://github.com/UedaTakeyuki/autostart2/tree/main/test/time) that has 2 executable files as [time](https://github.com/UedaTakeyuki/autostart2/blob/main/test/time/time) that has the same name as the folder, and [cl](https://github.com/UedaTakeyuki/autostart2/blob/main/test/time/cl) 
judging from the name it is probably a client application. 

Now let's make this time executable file a service. 

## For what application?
This is for application:

- started with calling single command file, in other words ``Type=simple``.
- the name of the folder is the same as the command file name.

For example:

```
├───foo
│    foo

```

## How does this works
Recognize command to start from folder name, and make systemctl unit file.


## Install
Just **copy** ```autostart``` and ```makeunitfile.sh``` files in your project, **that's it!**

## How to use
```
Usage: ./autostart [option] [Target path(current path if ommited)]
  [--on]:               Set autostart as ON. 
  [--off]:              Set autostart as OFF. 
  [--status]:           Show current status. 
  [--version]:          Show version. 
  [--write]:            Only write Unit file if not Exist. 
```
Target path is the path of folder that the service is in, or current path if ommited.
Fx: In the following folder structure
```
├───foo
│    foo
├───autostart2
│    autostart
```

Execute **autostart** command in **autostart2** folder as follow:

```
./autostart2 --on ../foo

```
As the result, /foo/foo.service unit file will be create and start it.

- on: 
  Link unit file to /etc/systemd/system folder, then **enable** and **start** the service
  
  1. Link systemd unit file (Automatically created in this folder if not exist) to /etc/systemd/system/.
  2. systemctl **daemon-reload**
  3. systemctl **enable**
  4. systemctl **start**
 
- off:
  **Stop** and **disable** the service
  
  1. systemctl **stop**
  2. systemctl **disable**
 
- status: 
  Show status of the service
  
  1. systemctl **statu**
 
## How to customize auto-creation of systemd unit file in case default created is not appropriated.
Refer [wiki](https://github.com/UedaTakeyuki/autostart2/wiki/Created-unit-file#how-to-customize).

## History
- v1.0.0: 2024.06.18 created as successor of [autostart](https://github.com/UedaTakeyuki/autostart).
- v1.1.0: 2024.06.23 incorporate **makeunitfile** into **autostart**
- v1.1.1: 2024.06.24 add --update, --delete