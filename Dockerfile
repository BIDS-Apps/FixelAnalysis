# This is a comment
FROM ubuntu:14.04
MAINTAINER David Raffelt <draffelt@gmail.com>
RUN apt-get update && apt-get install -y git g++ python libeigen3-dev zlib1g-dev wget
RUN git clone https://github.com/MRtrix3/mrtrix3.git mrtrix3 && cd mrtrix3 && python configure -nogui -verbose && python build

RUN wget -O- http://neuro.debian.net/lists/trusty.us-ca.full | tee /etc/apt/sources.list.d/neurodebian.sources.list
RUN apt-key adv --recv-keys --keyserver hkp://pgp.mit.edu:80 0xA5D32F012649A5A9 && apt-get update && apt-get -y install fsl-5.0-eddy-nonfree

RUN apt-key adv --recv-keys --keyserver hkp://pgp.mit.edu:80 0xA5D32F012649A5A9 && apt-get update && apt-get -y install ants

ENV FSLDIR=/usr/share/fsl/5.0
ENV FSLOUTPUTTYPE=NIFTI_GZ
ENV PATH=/usr/lib/fsl/5.0:$PATH
ENV PATH=/usr/lib/ants/:$PATH
ENV PATH=/mrtrix3/release/bin:$PATH
ENV PATH=/mrtrix3/scripts:$PATH
ENV FSLMULTIFILEQUIT=TRUE
ENV LD_LIBRARY_PATH=/usr/lib/fsl/5.0

RUN mkdir /oasis
RUN mkdir /projects
RUN mkdir /scratch
RUN mkdir /local-scratch
COPY run.py /code/run.py

ENTRYPOINT ["/code/run.py"]