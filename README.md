# FreeSurfer VNC

A docker container of the popular package [FreeSurfer](https://surfer.nmr.mgh.harvard.edu/).  

## Usage
docker cli
```
docker run -d\
    --name freesurfer_vnc \
    -e VNC_PASSWORD=mypassword \ 
    -p 6080:80 -p 5900:5900 \
    -v $HOME/freesurfer_vnc/anaconda:/home/ubuntu/anaconda3:rw \
    -v $HOME/freesurfer_vnc/Desktop:/root/Desktop:rw \
    cgvalle/freesurfer_vnc:latest
```
The enviroment variable `VNC_PASSWPORD` can be omited. Container can be acces from [http://127.0.0.1:6080](http://127.0.0.1:6080).

The image is based on the VNC desktop container of [Vincent Emonet
](https://github.com/vemonet/docker-ubuntu-vnc-desktop).
