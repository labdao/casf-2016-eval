
FROM conda/miniconda3

RUN chsh -s /bin/bash

SHELL ["/bin/bash", "-c"]

WORKDIR /app/

RUN apt-get update
RUN apt-get install -y wget bzip2 apt-utils git
RUN apt-get clean

RUN conda config --append channels conda-forge

RUN conda update conda \
	&& conda create -y --name casf -c conda-forge numpy pandas scipy scikit-learn

RUN echo "conda activate casf" >> ~/.bashrc
ENV PATH /usr/local/envs/casf/bin:$PATH
ENV CONDA_DEFAULT_ENV $casf

RUN pip install jinja2

RUN mkdir /outputs
RUN mkdir /inputs

COPY . .
CMD ["bash"]