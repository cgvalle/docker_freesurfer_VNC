FROM freesurfer/freesurfer:7.3.1 as freesurfer
#FROM zouzias/boost:1.75.0 as boost
FROM mltooling/ml-workspace-minimal:0.13.2


# Copy freesurfer files to final container
COPY --from=freesurfer /usr/local/freesurfer /usr/local/freesurfer
 
RUN apt-get -y update && \
    apt -y install \
        libboost-all-dev \
        ffmpeg \
        libsm6 \
        libxext6 \
        libgl1 \
        libxrender-dev \
        libgl1-mesa-glx \
        libglu1-mesa 
        #g++ \ 
        #libXt* \

        #csh \
        #tcsh \
        #wget \
        #git \
        #bc \
        #unzip \
        #nano vim 



ENV FREESURFER_HOME=/usr/local/freesurfer \
    SUBJECTS_DIR=/root/Desktop/workspace/subjects \
    FUNCTIONALS_DIR=/root/Desktop/workspace/sessions 


RUN mkdir -p $SUBJECTS_DIR && \
    mkdir -p $FUNCTIONALS_DIR && \
    echo source $FREESURFER_HOME/SetUpFreeSurfer.sh >> /root/.bashrc && \
    echo source $FREESURFER_HOME/SetUpFreeSurfer.sh >> /root/.zshrc

WORKDIR /root/Desktop
RUN git clone https://github.com/changlabucsf/img_pipe 

#RUN conda update conda --yes
#RUN pip install --upgrade pip
#RUN conda update pip
#RUN conda create -n img_pipe_py2 python=2.7.13=0 && \ 
#    mkdir -p  /opt/conda/envs/img_pipe_py2/lib/python2.7/site-packages && \
#    touch /opt/conda/envs/img_pipe_py2/lib/python2.7/site-packages/easy-install.pth && \
#    sed 's/\(.*[[:alnum:]]\)=[[:alnum:]][[:alnum:].-_]*/\1/' img_pipe/environment_py27.yml > img_pipe/env.yml




