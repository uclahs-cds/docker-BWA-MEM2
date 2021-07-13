FROM blcdsdockerregistry/bl-base:1.0.0 AS builder

LABEL maintainer="Yash Patel <YashPatel@mednet.ucla.edu>"

# add channels in correct order to avoid missing libcrypto dependency
# https://github.com/bioconda/bioconda-recipes/issues/12100
ARG BWA_MEM2_VERSION=2.2.1
ARG SAMTOOLS_VERSION=1.10
RUN conda create -qy -p /usr/local \
    -c defaults \
    -c bioconda \
    -c conda-forge \
    bwa-mem2==${BWA_MEM2_VERSION} \
    samtools==${SAMTOOLS_VERSION}

FROM ubuntu:20.04
COPY --from=builder /usr/local /usr/local

# ps and command for reporting mertics 
RUN apt-get update && \
    apt-get install --no-install-recommends -y procps && \
    rm -rf /var/lib/apt/lists/*

CMD ["bwa-mem2"]
