FROM python:3.10-slim

# install poetry
RUN apt-get update && \
    apt-get install build-essential -y && \
    apt-get install curl -y && \
    apt-get install git -y && \
    pip install --no-cache --upgrade pip && \
    curl -sSL https://install.python-poetry.org | python - --version 1.2.1

# create user with a home directory
ENV NB_USER=jovyan
ENV NB_UID=1000
ENV HOME /home/${NB_USER}
ENV PATH="/root/.local/bin:$PATH"

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

WORKDIR ${HOME}

# install dependencies
COPY pyproject.toml .
COPY poetry.lock .
RUN git clone --recursive https://github.com/tradingstrategy-ai/trade-executor deps/trade-executor
# TODO: we can hook trade-executor version later here
RUN poetry config virtualenvs.create false && \
    poetry install --no-dev --no-interaction --no-ansi

# run as created user
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}
