FROM python:3.9-slim

# install poetry
RUN apt-get update && \
    apt-get install build-essential -y && \
    apt-get install curl -y && \
    apt-get install git -y && \
    pip install --no-cache --upgrade pip && \
    curl -sSL https://install.python-poetry.org | python - --version 1.1.13

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
COPY . .
RUN poetry config virtualenvs.create false && \
    poetry install --no-dev --no-interaction --no-ansi

# run as created user
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}
