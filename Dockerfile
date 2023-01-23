FROM freesurfer/freesurfer:7.3.1 as freesurfer
#FROM zouzias/boost:1.75.0 as boost
FROM mltooling/ml-workspace-minimal:0.13.2


# Copy freesurfer files to final container
COPY --from=freesurfer /usr/local/freesurfer /usr/local/freesurfer

RUN apt-get -y update 
RUN apt -y install libboost-all-dev


ENV FREESURFER_HOME=/usr/local/freesurfer \
    SUBJECTS_DIR=/root/Desktop/workspace/subjects \
    FUNCTIONALS_DIR=/root/Desktop/workspace/sessions 


RUN mkdir -p $SUBJECTS_DIR && \
    mkdir -p $FUNCTIONALS_DIR && \
    echo source $FREESURFER_HOME/SetUpFreeSurfer.sh >> /root/.bashrc && \
    echo source $FREESURFER_HOME/SetUpFreeSurfer.sh >> /root/.zshrc

WORKDIR /root/Desktop
RUN git clone https://github.com/changlabucsf/img_pipe 

#RUN conda update -n base conda
#COPY img_pipe.yml . 
#RUN conda env create -f img_pipe.yml




