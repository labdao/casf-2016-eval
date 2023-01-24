
FROM python:bullseye

RUN chsh -s /bin/bash

SHELL ["/bin/bash", "-c"]

WORKDIR /root/

RUN apt-get update
RUN apt-get install -y wget bzip2 apt-utils git
RUN apt-get clean

RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh -O ~/anaconda.sh && \
        /bin/bash ~/anaconda.sh -b -p /opt/conda && \
        rm ~/anaconda.sh && \
        ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
        echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
        find /opt/conda/ -follow -type f -name '*.a' -delete && \
        find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
        /opt/conda/bin/conda clean -afy

ENV PATH /opt/conda/bin:$PATH

RUN conda update conda \
	&& conda env create --name casf -f ./environment.yml

RUN echo "conda activate casf" >> ~/.bashrc
ENV PATH /opt/conda/envs/casf/bin:$PATH
ENV CONDA_DEFAULT_ENV $casf

CMD ["bash"]