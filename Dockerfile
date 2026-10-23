ARG PYTHON_VERSION=3.14
FROM python:${PYTHON_VERSION}
ENV DATA_DIR=/data
VOLUME "/data"
WORKDIR /experiment
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY experiment.py run.sh ./
# The container is meant to run as the host user (cf. compose.yaml), who has no home directory in the image:
# let libraries (e.g. openml, matplotlib) put their caches and configs in a writable place
ENV HOME=/tmp
CMD ["bash", "run.sh"]
