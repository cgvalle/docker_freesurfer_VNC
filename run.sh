clear
docker run --rm \
    --name freesurfer_vnc \
    -e VNC_PASSWORD=mypassword \
    -e SUBJECTS_DIR=/root/persistent/sujects \
    -v $HOME/docker/freesurfer_VNC:/root/persistent \
    -p 6080:80 -p 5900:5900 \
    cgvalle/freesurfer_vnc:latest
