# FreeSurfer VNC

A docker container of the popular package [FreeSurfer](https://surfer.nmr.mgh.harvard.edu/).  

## Usage
docker cli
```
docker run -d\
    --name freesurfer_vnc \
    -e VNC_PASSWORD=mypassword \
    -e SUBJECTS_DIR=/root/persistent/sujects \  
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
|  -p 6080:80|   Accesss to desktop with no VNC (Browser). The container will be visible on `http://127.0.0.1:6080` | 
|  -p 5900:5900|  Access through VNC remote conection. If not in use, this option can be omited|
|  -v /root/persistent| Recommended to have a persistant volume of `subjects` folder.|


NOTE: The folder `subjects` needs to be created manually during the first run if a volume is mounted in `/root/persistent`. 

For suggestions and bug fixes you can contactme at **cgvalle@uc.cl**.


The image is based on the VNC desktop container of [Vincent Emonet
](https://github.com/vemonet/docker-ubuntu-vnc-desktop).
