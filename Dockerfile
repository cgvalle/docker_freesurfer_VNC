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



ENV FREESURFER_HOME=/usr/local/freesurfer \
    SUBJECTS_DIR=/root/Desktop/workspace/subjects \
    FUNCTIONALS_DIR=/root/Desktop/workspace/sessions 


RUN mkdir -p $SUBJECTS_DIR && \
    mkdir -p $FUNCTIONALS_DIR && \
    echo source $FREESURFER_HOME/SetUpFreeSurfer.sh >> /root/.bashrc && \
    echo source $FREESURFER_HOME/SetUpFreeSurfer.sh >> /root/.zshrc

WORKDIR /root/Desktop
COPY img_pipe.yml .
RUN git clone https://github.com/changlabucsf/img_pipe && \
    conda create -n img_pipe_py2 python=2.7.13=0 setuptools=27.2.0=py27_0 && \
    conda config --set restore_free_channel true && \
    conda install -y -n img_pipe_py2 setuptools=27.2.0=py27_0 && \
    conda env update -f /root/Desktop/img_pipe.yml -n img_pipe_py2 && \
    wget https://raw.githubusercontent.com/jersaal/img_pipe_subf/master/img_pipe.py && \
    mv -fv img_pipe.py /opt/conda/envs/img_pipe_py2/lib/python2.7/site-packages/img_pipe/img_pipe.py && \
    rm -r img_pipe && \
    conda create --name=img_pipe_mne --channel=conda-forge mne=1.3 python=3.10 && \
    git clone https://github.com/c-herff/img_pipe.git && \
    mv img_pipe/img_pipe /opt/conda/envs/img_pipe_mne/lib/python3.10/site-packages/  && \
    /opt/conda/envs/img_pipe_mne/bin/python -m pip install nipy mayavi  && \
    rm -r img_pipe



