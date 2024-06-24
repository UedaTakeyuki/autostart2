# autostart2
The ***autostart2*** provides the simplest way to make your application a **Systemd service** supported. All you have to do is only ```autostart --on```, this will do all the tedious work of making the appropriate unit file, linking it to the appropriate folder, daemon-reloading, enabling, and starting. For you with a lot of technical experience, these are just tedious tasks, but　it can be a nightmare for end users with no technical experience who are told by you to “configure and use it as the Systemd service.”　Instead, "do ```autostart --on```" would be a kind, easy, and helpful instruction even end users can execute well.

## How does this work?

### 1. Call autostart by specifying the path where the service is made from.
Suppose you have a folder like [time](https://github.com/UedaTakeyuki/autostart2/tree/main/test/time) that has 2 executable files as [time](https://github.com/UedaTakeyuki/autostart2/blob/main/test/time/time) that has the same name as the folder, and [cl](https://github.com/UedaTakeyuki/autostart2/blob/main/test/time/cl) 
judging from the name it is probably a client application. 

```
/autostart2/test/time $ ls
cl  time
```

Now let's make this ```time``` executable file a service. On this folder, call ***autostart*** by specifying the path ```test/time``` where the service is made from

```
/autostart2 $ ./autostart --on test/time
Created symlink /etc/systemd/system/multi-user.target.wants/time.service → /home/pi/github/autostart2/test/time/time.service.
```

Then, ```time.service``` unit file is created.

```
/autostart2/test/time $ ls
cl  time  time.service
```

Also ```time``` service is started and enabled, so call ***cl***

```
/autostart2/test/time $ ./cl
Mon 24 Jun 19:28:50 JST 2024

```

The time server returns to the client the current time. To stop ```cl```, cntl + c.

### 2. Call autostart on the path where the service is made from.
In case you call autostart in the same folder as the file that you are making service, you can omit to specify the path. For example, link autostart into test/time folder symbolically as follow:

```
/autostart2/test/time $ ln -s ../../autostart
/autostart2/test/time $ ls
autostart  cl  time
```

Then, you can call **autostart** without specifying the path as follows.

```
/autostart2/test/time $ ./autostart --on
Created symlink /etc/systemd/system/multi-user.target.wants/time.service → /home/pi/github/autostart2/test/time/time.service.
```

This might be the easiest way to provide your product to end-users as a service.

## How does the autostart make the systemd unit file?
### 1. Executing file name.
The autostart makes a unit file to ExecStart your app as ***Type=simple*** and guesses the name of the executing file as the same name as the name of the folder containing the executing file as follows.

```
├───foo
│    foo

```

In case the executing file name is different from the folder name like as follows:

```
├───foo
│    bar
```

You can specify it by making ```replaceoptions.sh``` script. For more detail, refer to the [wiki](https://github.com/UedaTakeyuki/autostart2/wiki/Created-unit-file#1-change-options-from-default-value). 

## Install
Just **copy** ```autostart``` and ```makeunitfile.sh``` files in your project, **that's it!**

## How to use
```
Usage: ./autostart [option] [Target path(current path if omitted)]
# service handle options 
  [--on]:               Set autostart as ON. 
  [--off]:              Set autostart as OFF. 
  [--status]:           Show current status. 
# unit file options 
  [--write]:            Only write Unit file if not Exist. 
  [--update]:           Update Unit file if Exist, or create if not. 
  [--delete]:           Delete Unit file if Exist. 
# other options 
  [--version]:          Show version.
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
