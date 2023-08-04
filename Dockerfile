FROM ghcr.io/uclahs-cds/bl-base:1.1.0 AS builder

ARG BWA_MEM2_VERSION=2.2.1

RUN mamba create -qy -p /usr/local \
    -c defaults \
    -c bioconda \
    -c conda-forge \
    bwa-mem2==${BWA_MEM2_VERSION}

FROM ghcr.io/uclahs-cds/samtools:1.17
COPY --from=builder /usr/local /usr/local

LABEL maintainer="Beth Neilsen <BNeilsen@mednet.ucla.edu>" \ 
org.opencontainers.image.source=https://github.com/uclahs-cds/docker-BWA-MEM2
