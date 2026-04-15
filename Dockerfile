FROM python:3.13-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
  r-base \
  zlib1g-dev \
  time \
  sambamba \
  samblaster \
  wget \
  make \
  r-cran-rjson

COPY ./requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

COPY . /app

RUN mkdir -p /ref && gunzip -c hg38_GENCODE_v23_basic.bed.gz > /ref/hg38_GENCODE_v23_basic.bed && rm hg38_GENCODE_v23_basic.bed.gz

ENTRYPOINT ["/bin/bash", "run.sh"]
