ARG MINIFORGE_VERSION=23.1.0-3
ARG SAMTOOLS_VERSION=1.17

FROM condaforge/mambaforge:${MINIFORGE_VERSION} AS builder

ARG BWA_MEM2_VERSION=2.2.1

RUN mamba create -qy -p /usr/local \
    -c defaults \
    -c bioconda \
    -c conda-forge \
    bwa-mem2==${BWA_MEM2_VERSION}

FROM ghcr.io/uclahs-cds/samtools:${SAMTOOLS_VERSION}
COPY --from=builder /usr/local /usr/local

# Change the default user to bldocker from root
USER bldocker

LABEL maintainer="Beth Neilsen <BNeilsen@mednet.ucla.edu>" \
org.opencontainers.image.source=https://github.com/uclahs-cds/docker-BWA-MEM2
