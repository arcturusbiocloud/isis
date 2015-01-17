### How to build

    boot2docker up # set docker enviroment variables. check the terminal output
    docker build -t arcturusbiocloud/isis .
    docker push arcturusbiocloud/isis
    fleetctl submit isis.service
    fleetctl start isis.service
    fleetctl list-units
    fleetctl journal -f isis.service # aka tail -f
    fleetctl stop isis.service
    fleetctl destroy isis.service
    fleetctl list-machines
    fleetctl ssh ****
    
### How to debug

    docker run --name isis -p 4000:4000 -p 4369:4369 -p 9100:9100 -p 9101:9101 -p 9102:9102 -p 9103:9103 -p 9104:9104 -p 9105:9105 -e DATABASE_URL=ecto://arcturus:ePYQtVfznww9GhMz6Sg9UQ==@arcturus.cinyniivduui.us-west-1.rds.amazonaws.com/isis -e MIX_ENV=prod -e PORT=4000 arcturusbiocloud/isis /sbiny_init --enable-insecure-key -- elixir --erl "-kernel inet_dist_listen_min 9100 -kernel inet_dist_listen_max 9105" --no-halt --cookie qeSwOMmQ+BFt3cMjf1kazeIMRwhy45ySlbvFCuWsRcU= --name "isis@isis.arcturus.io" -pa _build/prod/consolidated -S mix phoenix.start
    
    docker inspect -f "{{ .NetworkSettings.IPAddress }}" isis
    
    curl -o insecure_key -fSL https://github.com/phusion/baseimage-docker/raw/master/image/insecure_key
    chmod 600 insecure_key
    
    # Login to the container
    ssh -i insecure_key root@<IP address>
    

### How to create and migrate the database in production for the first time
    # log in the container using fleetctl ssh and ssh -i insecure_key ... inside the CoreOS
    cd /isis
    # the database needs to be already created by mix ecto.create Isis.Repo or another tool
    MIX_ENV=prod mix ecto.migrate Isis.Repo


### How to install and configure fleetctl

Install fleetctl
```
wget https://github.com/coreos/fleet/releases/download/v0.9.0/fleet-v0.9.0-darwin-amd64.zip
unzip fleet-v0.9.0-darwin-amd64.zip
cp fleet-v0.9.0-darwin-amd64/fleetctl /usr/local/bin/fleetctl
```

Configure fleetctl
```
vim ~/.ssh/config
# add this host
Host isis
  User core
  HostName isis.arcturus.io
  IdentityFile ~/Dropbox/amazon/luisbebop-sf.pem
```

Add fleetctl tunnel environment variable
```
vim ~/.bash_profile
export FLEETCTL_TUNNEL=isis.arcturus.io
```

Add ssh private key to the ssh agent
```
ssh-add ~/Dropbox/amazon/luisbebop-sf.pem
```

Check if everything is working
```
[~]$ fleetctl list-machines
MACHINE		IP		METADATA
eb2d6339...	172.31.9.138	-
```