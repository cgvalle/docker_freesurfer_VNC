# FreeSurfer VNC
FROM ghcr.io/vemonet/docker-ubuntu-vnc-desktop:latest 
 

################################
#### Install linux packages  ###
################################
RUN apt-get -y update  && \
    apt-get -y install gcc \ 
        g++ \ 
        libXt* \
        libgl1-mesa-glx \
        libglu1-mesa \
        libsm6 libxext6 libxrender-dev \
        csh \
        tcsh \
        wget \
        git \
        bc \
        unzip \
        nano vim 


## Change working path  ##
WORKDIR /root


##########################
#### Install Anaconda ####
##########################
COPY libraries/Anaconda3-2018.12-Linux-x86_64.sh .
RUN bash Anaconda3-2018.12-Linux-x86_64.sh -b  && \
    rm -f Anaconda3-2018.12-Linux-x86_64.sh 

##########################
###### Install Boost #####
##########################
ADD libraries/boost_1_41_0.tar.gz /home/ubuntu/

##########################
### Install Freesurfer ###
##########################
ADD libraries/freesurfer-linux-ubuntu18_amd64-7.2.0.tar.gz /home/ubuntu/
ADD libraries/license.zip /home/ubuntu/freesurfer

#########################
### Prepare Envioment ###
### and dependencies  ###
#########################

# Set language
ENV LANG="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8"
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment && \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    echo "LANG=en_US.UTF-8" > /etc/locale.conf

# Add freesurfer to path
ENV FREESURFER_HOME=/home/ubuntu/freesurfer \
    SUBJECTS_DIR=/root/persistent/subjects \
    DYLD_FALLBACK_LIBRARY_PATH=/usr/lib:$DYLD_LIBRARY_PATH 

# Get img_pipe
RUN git clone https://github.com/changlabucsf/img_pipe && \
    /home/ubuntu/anaconda3/bin/conda env create -f img_pipe/environment_py27.yml && \
    wget https://raw.githubusercontent.com/jersaal/img_pipe_subf/master/img_pipe.py && \
    mv -fv img_pipe.py /home/ubuntu/anaconda3/envs/img_pipe_py2/lib/python2.7/site-packages/img_pipe/img_pipe.py

# Add anaconda to path and freesurfer to terminal
RUN ln -sf /home/ubuntu/anaconda3/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    ln -sf /home/ubuntu/anaconda3/bin/conda /usr/bin/conda && \
    echo source /home/ubuntu/anaconda3/etc/profile.d/conda.sh >> /root/.bashrc && \
    echo source $FREESURFER_HOME/SetUpFreeSurfer.sh >> /root/.bashrc && \
    ln -sf /home/ubuntu/freesurfer/ /root/freesurfer && \
    ln -sf /home/ubuntu/boost_1_41_0/ /root/boost_1_41_0 && \
    mkdir -p /root/persistent/subjects 



# Install visual studio Code
RUN curl -L 'https://go.microsoft.com/fwlink/?LinkID=760868' -o vsc.deb && \
    apt install ./vsc.deb && \ 
    echo "alias vscode='code . --user-data-dir="/root/vscode" --no-sandbox'" >> /root/.bashrc

RUN conda update conda --yes

# Instal img_pipe of Christian Herff: https://github.com/c-herff/img_pipe
#RUN rm -r img_pipe && \
#    /home/ubuntu/anaconda3/bin/conda create --name=img_pipe_mne --channel=conda-forge mne && \
#    git clone https://github.com/c-herff/img_pipe.git && \
#    mv img_pipe/img_pipe /home/ubuntu/anaconda3/envs/img_pipe_mne/lib/python3.10/site-packages/  && \
#    /home/ubuntu/anaconda3/envs/img_pipe_mne/bin/python -m pip install nipy mayavi  && \
#    rm -r img_pipe





