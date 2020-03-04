a dockerfile that installs [netbox-scanner](https://github.com/forkd/netbox-scanner) and runs with it... this can be deployed alongside netbox or into any container runtime you need.

[Check their wiki](https://pypi.org/project/netbox-scanner/)

## Build it

```
git clone https://github.com/ToroNZ/netbox-scanner-container
cd netbox-scanner-container
docker build -t toronz/nebox-scanner-docker:latest .
```

## Run it

If your running it for the first time, create a sample config file:

```
tee `pwd`/.netbox-scanner.conf <<EOF
[GENERAL]
tag       = auto
vrf       = 
unknown   = unknown host
log       = .
nmap_args = -T4 -F -R --host-timeout 30s

[NETBOX]
address = http://netbox:8001
token = YOUR_TOKEN_HERE
tls_verify = False

[TACACS]
user     = netbox
password = 
command  = show run | inc hostname
regex    = hostname ([A-Z|a-z|0-9|\-|_]+)
regroup  = 1

[SCAN]
networks = 192.168.21.0/26,10.0.1.0/24
EOF
```

After the config is set, you can mount it as follows:

```docker run --rm -ti --user 1000320000 --cap-drop=all -v `pwd`/.netbox-scanner.conf:/home/netbox/.netbox-scanner.conf toronz/netbox-scanner-docker:latest```

## OS Recognition

Won't work due to the lack of permissions of this image (rootless).

If you want to use the nmap flag "-O" (OS recon), you need to build this container using a privileged user (root/sudo) so nmap can create raw sockets.