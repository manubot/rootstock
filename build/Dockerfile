FROM condaforge/miniforge3:latest

ARG CONDA_PREFIX=/opt/conda
ARG CONDA_ENV=manubot

COPY environment.yml /
RUN conda env create \
  --prefix=$CONDA_PREFIX/envs/$CONDA_ENV \
  --file=/environment.yml \
  && conda clean --all --force-pkgs-dirs --yes

ENV PATH $CONDA_PREFIX/envs/$CONDA_ENV/bin:$PATH
RUN echo "conda activate $CONDA_ENV" > ~/.bashrc
RUN /bin/bash -c "conda activate $CONDA_ENV"

ENV CONDA_DEFAULT_ENV=$CONDA_ENV
