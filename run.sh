clear
docker run --rm \
    --name freesurfer_vnc \
    -e VNC_PASSWORD=mypassword \
    -p 6080:80 -p 5900:5900 \
    -v $HOME/freesurfer_vnc/anaconda:/home/ubuntu/anaconda3:rw \
    -v $HOME/freesurfer_vnc/Desktop:/root/Desktop:rw \
    cgvalle/freesurfer_vnc:latest
