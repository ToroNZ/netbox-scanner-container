### Build it

```
git clone https://github.com/ToroNZ/netbox-scanner-container
cd netbox-scanner-container
docker build -t toronz/nebox-scanner-docker:latest .
```

### Run it

If your running it for the first time, create a sample config file:

`docker run --rm -ti -v `pwd`:/root toronz/netbox-scanner-docker:latest`

This will drop a hidden file under your current directory. After the config is set, you can mounted it as follow:

`docker run --rm -ti -v `pwd`/.netbox-scanner.conf:/root/.netbox-scanner.conf toronz/netbox-scanner-docker:latest`