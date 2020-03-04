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

```docker run --rm -ti --user 1000320000 --cap-drop=all -v `pwd`:/root toronz/netbox-scanner-docker:latest```

This will drop a hidden file under your current directory. After the config is set, you can mount it as follows:

```docker run --rm -ti --user 1000320000 --cap-drop=all -v `pwd`/.netbox-scanner.conf:/root/.netbox-scanner.conf toronz/netbox-scanner-docker:latest```

## OS Recognition

Won't work due to the lack of permissions of this image (rootless).

If you want to use the nmap flag "-O" (OS recon), you need to build this container using a privileged user (root/sudo) so nmap can create raw sockets.