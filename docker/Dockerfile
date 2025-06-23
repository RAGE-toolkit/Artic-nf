#Docker file version v1.0.0
#Last modified: June 13/06/2025 11:57AM


#Dockerfile for ARM64
#Contains Longshot + bcftools + other tools 

#############
# Running docker file 
# $docker buildx build --platform linux/arm64 -t arti-nf-arm64:arm641 .
############


# Use Ubuntu 22.04 as base image
FROM --platform=linux/arm64 ubuntu:22.04

LABEL maintainer="Sandeep Kasaragod <your-email@example.com>"

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/root/.cargo/bin:${PATH}"

# Step 1: Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    curl \
    git \
    python3.10 \
    python3.10-venv \
    python3.10-dev \
    python3-pip \
    zlib1g-dev \
    libbz2-dev \
    liblzma-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    tabix \
    unzip \
    bc \
    autoconf \
    automake \
    libtool \
    pkg-config \
    samtools \
    ca-certificates \
    clang \
    cmake \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Step 2: Set python3.10 as default
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.10 1

# Step 3: Install pip packages
RUN pip install --no-cache-dir \
    numpy==1.23.5 \
    pandas \
    biopython \
    pysam \
    pyarrow \
    pyfaidx \
    cyvcf2 \
    matplotlib \
    seaborn \
    plotly

# Step 4: Install MAFFT
RUN apt-get update && apt-get install -y mafft

# Step 5: Install minimap2
RUN cd /opt && \
    git clone https://github.com/lh3/minimap2 && \
    cd minimap2 && \
    make arm_neon=1 aarch64=1 && \
    ln -s /opt/minimap2/minimap2 /usr/local/bin/minimap2

# Step 6: Install datamash
RUN cd /opt && \
    wget http://ftp.gnu.org/gnu/datamash/datamash-1.8.tar.gz && \
    tar -xzf datamash-1.8.tar.gz && \
    cd datamash-1.8 && \
    ./configure && make && make install

# Step 7: Install OpenJDK 11 (required for Nextflow)
RUN apt-get update && apt-get install -y openjdk-11-jdk

# Step 8: Install Nextflow v23.10.0
RUN curl -fsSL https://github.com/nextflow-io/nextflow/releases/download/v23.10.0/nextflow-23.10.0-all -o /usr/local/bin/nextflow && \
    chmod +x /usr/local/bin/nextflow && \
    /usr/local/bin/nextflow -version

# Step 9: Install medaka
#RUN pip install medaka==1.11.3
RUN pip install medaka==1.11.3 tensorflow==2.10.1

# Step 10: Install Rust (required for Longshot)
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

# Step 11: Clone and build Longshot
RUN git clone https://github.com/pjedge/longshot.git /opt/longshot && \
    cd /opt/longshot && \
    cargo build --release && \
    ln -s /opt/longshot/target/release/longshot /usr/local/bin/longshot

# Step 12: Clone and build HTSlib
RUN git clone --branch=1.18 https://github.com/samtools/htslib.git /opt/htslib && \
    cd /opt/htslib && \
    git submodule update --init --recursive && \
    make && make install

# Step 13: Clone and build BCFtools
RUN git clone --branch=1.18 https://github.com/samtools/bcftools.git /opt/bcftools && \
    cd /opt/bcftools && \
    make && make install


# Step 14: Install MUSCLE 
RUN apt-get update && apt-get install -y muscle \
		&& apt-get clean && rm -rf /var/lib/apt/lists/*

# Step 15: Final cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Default CMD
CMD ["/bin/bash"]

