
A docker container of the popular package [FreeSurfer](https://surfer.nmr.mgh.harvard.edu/), compatible with Windows, Mac, and Linux.

## Usage
Docker cli 
```
docker run -d\
    --name freesurfer_vnc \
    -e VNC_PASSWORD=mypassword \
    -e SUBJECTS_DIR=/root/persistent/subjects \  
    -v $HOME/docker/freesurfer_VNC:/root/persistent \  # Recomended
    -p 6080:80 -p 5900:5900 \
    cgvalle/freesurfer_vnc:latest
```

## Parameters
Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate <external>:<internal> respectively. For example, -p 6080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 6080 outside the container.

| Parameter | Function |
| --- | ----------- |
|  -e VNC_PASSWORD=| password for VNC login. Default is no password  |
|  -e SUBJECTS_DIR | Path to freesurfer subject directory. Default is `/root/persistent/subjects` |
|  -p 6080:80|   Access to desktop with no VNC (Browser). The container will be visible on `http://127.0.0.1:6080` | 
|  -p 5900:5900|  Access through VNC remote connection. If not in use, this option can be omited|
|  -v /root/persistent| Recommended to have a persistent volume of `subjects` folder.|

NOTE: The folder `subjects` needs to be created manually during the first run if a volume is mounted in `/root/persistent`. 


## Windows Setup
Windows requires *Windows Subsystem for Linux* ([WSL](https://docs.microsoft.com/en-us/windows/wsl/install)) version 2. Although you can install it yourself, it is recommended to use [Docker Desktop](https://docs.docker.com/desktop/install/windows-install/) software that handles this process entirely. 

You can use windows terminal (command prompt) or Powershell to run the container with the command:

```
docker run -d\
    --name freesurfer_vnc \
    -e VNC_PASSWORD=mypassword \
    -e SUBJECTS_DIR=/root/persistent/subjects \  
    -v //c/Users/<user_name>/Documents:/root/persistent \ 
    -p 6080:80 -p 5900:5900 \
    cgvalle/freesurfer_vnc:latest
```
The only difference to the Mac/Linux command is the structure of the path for the persistent volume. Windows requires a double slash (`/`) to indicate the directory. Additionally, `<user_name>` should be replaced accordingly. 

If everything works fine, you should be able to access it using your browser at `http://127.0.0.1:6080`.



## Freesurfer Licence
Freesurfer requires a free license that can be requested at their [website](https://surfer.nmr.mgh.harvard.edu/fswiki/License). You will receive a text file that needs to be placed in the `/home/ubuntu/freesurfer` folder (default path for $FREESURFER_HOME). 


For suggestions and bug fixes, you can contact me at **cgvalle@uc.cl**.


The image is based on the VNC desktop container of [Vincent Emonet
](https://github.com/vemonet/docker-ubuntu-vnc-desktop).
