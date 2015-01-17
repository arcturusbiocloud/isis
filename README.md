Isis
=====

This project is responsible for manage the project, users, robots and experiments of Arcturus BioCloud.
It communicates with the clusters of robots using the `arcturusbiocloud\horus`


## Feature Roadmap

  - [x] user management
  - [x] docker/fleetctl based AWS deployment
  - [x] live streaming javascript page
  - [x] project management 
  - [ ] dashboard
  - [ ] new landing page
  - [ ] development language
  - [ ] development interface
  - [ ] project timeline
  - [ ] social features


## Tests

You need to [download Selenium](http://docs.seleniumhq.org/download/) and start it:
```
java -jar selenium-server-standalone-2.44.0.jar
```
Fetch the test dependencies using:
```
MIX_ENV=test mix do deps.get
```
and then exec the tests:
```
mix test
```


## How to start
    elixir --sname foo@luisbebop --cookie abcdef -S mix phoenix.start
    

### Design mockup
  * https://projects.invisionapp.com/share/SX1Y39HEW

    
### Graphic development interface
  * http://www.jsplumb.org/demo/statemachine/dom.html
  * http://www.vvvvjs.com/start
  * https://github.com/the-grid/the-graph
  
  
### Natural language interface
  * http://torch.ch/
  * https://github.com/torch/torch7/wiki/Cheatsheet#natural-language-processing
  * http://arxiv.org/pdf/1103.0398v1.pdf
  * https://github.com/torch/senna
  * http://ml.nec-labs.com/senna/#compilation
  * https://research.facebook.com/blog/879898285375829/fair-open-sources-deep-l20earning-modules-for-torch
 

### Technical notes
  * https://github.com/pgr0ss/elixir_experience/blob/master/web/models/docker.ex#L14
  * https://github.com/tjheeta/elixir_web_crawler
  * http://tjheeta.github.io/2014/12/06/elixir-saving-files-on-remote-node.html
  * https://github.com/adanselm/exrecaptcha

`port 4369, used by epmd (the Erlang Port Mapper Daemon, not Erick and Parrish Making Dollars), must be open for both TCP and UDP (n.b.: this is a default). another port or range of ports for the erlang nodes themselves. These nodes can be set at run time using the -kernel, inet_dist_listen_min and inet_dist_listen_max flags.`


### Robot board list
  * http://www.michaelhleonard.com/raspberry-pi-or-beaglebone-black
  * http://www.bigboardlist.com

  
### Streaming resources
  * http://www.raspberrypi.org/forums/viewtopic.php?f=43&t=45368
  * http://ftp.tuebingen.mpg.de/pub/kyb/towolf/raspberry-camera-streaming
  
  
![Isis] (http://black.greyfalcon.us/pictures/al25.jpg)