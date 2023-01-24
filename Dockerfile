
FROM conda/miniconda3

RUN chsh -s /bin/bash

SHELL ["/bin/bash", "-c"]

WORKDIR /root/

RUN apt-get update
RUN apt-get install -y wget bzip2 apt-utils git
RUN apt-get clean

RUN conda update conda \
	&& conda create --name casf numpy pandas scipy sklearn

RUN echo "conda activate casf" >> ~/.bashrc
ENV PATH /usr/local/envs/casf/bin:$PATH
ENV CONDA_DEFAULT_ENV $casf

CMD ["bash"]