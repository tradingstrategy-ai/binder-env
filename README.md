# Trading Strategy Binder environment

Binder environment for [Trading Strategy algorithmic trading framework and protocol](https://tradingstrategy.ai/).
This environemt is mainly used for [Trading Strategy documentation](https://tradingstrategy.ai/docs).

# About documentation internals

- The environment is built for [MyBinder](https://mybinder.org/)
- With this setup, we can [use different repositories for content and environment](https://mybinder.readthedocs.io/en/latest/howto/external_binder_setup.html)
- [Dockerfile configuration](https://mybinder.readthedocs.io/en/latest/tutorials/dockerfile.html) is used

# Building locally

To build the Docker image from the scratch: 

```shell
git submodule update --init --recursive
poetry shell
poetry install
docker build -t trading-strategy-binder-env:latest .
```

To test the built image:

```shell
docker run -it -p 8888:8888 trading-strategy-binder-env:latest jupyter notebook --NotebookApp.default_url=/lab/ --ip=0.0.0.0 --port=8888
```

Then you can open `http://localhost:8888` in your local web browser.

If you want to add dependency:

```shell
poetry add NEW-DEPENDENCY
docker build -t tradingstrategy-binder-env:latest .
```

See [Dockerfile](./Dockerfile) for more details.
