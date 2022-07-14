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

#########################################
#####  Prepare files and enviroment #####
#########################################
COPY src /root
WORKDIR /root

#RUN echo export PATH="/root/Desktop/anaconda3/bin:$PATH"  >> /etc/skel/.bashrc


#RUN useradd -ms /bin/bash ubuntu && cp /etc/skel/.bash* ~

##########################
#### Install Anaconda ####
##########################
COPY libraries/Anaconda3-2018.12-Linux-x86_64.sh .
RUN bash Anaconda3-2018.12-Linux-x86_64.sh -b  && \
    rm -f Anaconda3-2018.12-Linux-x86_64.sh 

RUN echo $PATH
ENV PATH="/home/ubuntu/anaconda3/bin:$PATH"
RUN echo $PATH


#######################
#### Install Boost ####
#######################
#ADD libraries/boost_1_41_0.tar.gz .

############################
#### Install Freesurfer ####
############################
#ADD libraries/freesurfer-linux-ubuntu18_amd64-7.2.0.tar.gz .


RUN bash startup.sh


