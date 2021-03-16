# Running out of files eh?

## See what the limit is:
```sh
ulimit -a
```

## See how many files are currently open
```sh
lsof | wc -l
```

## Who are the main contributors?
```sh
lsof |awk '{print $1}' | sort | uniq -c | sort  -rns
```

## How to increase limit?
Try editing `sysctl.conf` as `root` and adding
```sh
fs.file-max=2097152
fs.inotify.max_user_watches=2097152
```
to the end of it, the default is 

Then, run this to apply (reload sysctl settings) or logout-login
```sh
sysctl -p
```
This can be verified with:
```sh
cat /proc/sys/fs/inotify/max_user_watches
```

## Changing `ulimit`
Edit the file `/etc/security/limits.conf` by adding lines:
```
* soft nofile 2097152
* hard nofile 2097152
root soft nofile 2097152
root hard nofile 2097152
session required pam_limits.so
```
at the end. 
