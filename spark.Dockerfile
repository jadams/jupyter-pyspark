FROM public.ecr.aws/j1r0q0g6/notebooks/notebook-servers/jupyter:master-434b10ab

USER root

# install -- openjdk-17
RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get -yq update \
 && apt-get -yq install --no-install-recommends \
    openjdk-17-jdk \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

USER ${NB_UID}

# install - requirements.txt
COPY --chown=jovyan:users spark-requirements.txt /tmp/requirements.txt
RUN python3 -m pip install -r /tmp/requirements.txt --quiet --no-cache-dir \
 && rm -f /tmp/requirements.txt
