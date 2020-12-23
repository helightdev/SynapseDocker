A docker image used to run a modded Synapse SCP: Secret Laboratory Server

---

## Running Synapse
### Recommended:
```shell
docker run -itd -p 7777:7777/udp -v /home/sl/synapse/:/Synapse -v /home/sl/vanilla:/vancfg --restart=always --name Synapse helightdev/synapsesl
```

You can run a basic non-configured version Synapse using
```shell
docker run -itd -p 7777:7777/udp helightdev/synapsesl
```
However you can also hook a volume to the Synapse directory (The directory doesn't
have to contain Synapse-Files since required files will be copied to the volume
if they don't already exist)
```shell
printf "Here I used the /home/scpsl/synapse directory as synapse volume"
docker run -itd -p 7777:7777/udp -v /home/scpsl/synapse:/Synapse helightdev/synapsesl
```
You can also hook the vanilla config/7777 folder to another directory 
```shell
printf "Here I used the /home/scpsl/synapse directory as synapse volume and /home/scpsl/vanilla as vanilla config source"
docker run -itd -p 7777:7777/udp -v /home/scpsl/synapse:/Synapse -v /home/scpsl/vanilla:/vancfg helightdev/synapsesl
```

## Using Plugins & Synapse Configs
You have to mount a directory to /Synapse like in the second and third run-example. 
After that, you can place your plugins in either "plugins/server-shared" or "plugins/server-7777".
You can access the configuration in the same manner using "configs/server-shared" or "configs/server-7777"

## Credits
[ServerMod/Multiadmin](https://github.com/ServerMod/MultiAdmin "MultiAdmin Repo")