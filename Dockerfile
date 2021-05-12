FROM public.ecr.aws/lambda/python:3.8

WORKDIR ${LAMBDA_TASK_ROOT}

ARG PyPI_USERNAME
ENV PyPI_USERNAME, PyPI_USERNAME

ARG PyPI_PASSWORD
ENV PyPI_PASSWORD, PyPI_PASSWORD

ARG PyPI_DOMAIN
ENV PyPI_DOMAIN, PyPI_DOMAIN

# Pip install conflict with some AWS packages and give cryptic error
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
ENV PATH="$PATH:/root/.poetry/bin"

# Configure private PyPI Repo
RUN poetry config repositories.private_pypi PyPI_DOMAIN
RUN poetry config repositories.private_pypi
RUN poetry config http-basic.private_pypi PyPI_USERNAME PyPI_PASSWORD

# Install deps
COPY poetry.lock poetry.lock
COPY pyproject.toml pyproject.toml
RUN poetry config virtualenvs.create false
RUN poetry install --no-dev

COPY app .
CMD [ "main.handler" ]
