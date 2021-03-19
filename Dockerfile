FROM public.ecr.aws/lambda/python:3.8

WORKDIR ${LAMBDA_TASK_ROOT}

# Usually just "aws"
ARG PyPI_USERNAME
ENV PyPI_USERNAME, PyPI_USERNAME

# Ussually some long token
ARG PyPI_PASSWORD
ENV PyPI_PASSWORD, PyPI_PASSWORD

# Ussually looks something like 
# https://foo-org-832931358883.d.codeartifact.us-west-2.amazonaws.com
ARG PyPI_DOMAIN
ENV PyPI_DOMAIN, PyPI_DOMAIN

# TODO: Cache this somehow
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -


# Configure private PyPI Repo
RUN source $HOME/.poetry/env && poetry config repositories.private_pypi PyPI_DOMAIN
RUN source $HOME/.poetry/env && poetry config repositories.private_pypi
RUN source $HOME/.poetry/env && poetry config http-basic.private_pypi PyPI_USERNAME PyPI_PASSWORD

# # Install deps
COPY poetry.lock poetry.lock
COPY pyproject.toml pyproject.toml
RUN source $HOME/.poetry/env && poetry install --no-dev