FROM python:3.13-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
  r-base \
  zlib1g-dev \
  time \
  sambamba \
  samblaster \
  wget \
  make \
  r-cran-rjson

WORKDIR /ref
ADD hg38_GENCODE_v23_basic.bed.gz /ref/hg38_GENCODE_v23_basic.bed.gz
RUN gunzip -c /ref/hg38_GENCODE_v23_basic.bed.gz > /ref/hg38_GENCODE_v23_basic.bed

WORKDIR /app
ADD ./requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

WORKDIR /app
ADD . /app

ENTRYPOINT ["/bin/bash", "run.sh"]
