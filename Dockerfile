FROM ubuntu:22.04

# Set the working directory inside the container
WORKDIR /usr/src/myapp

# RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# install necessary dependencies
RUN apt-get update && \
    apt-get install -y curl build-essential

# install rustup (the rust toolchain installer)
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

# set environment variable to use rust and cargo
ENV PATH="/root/.cargo/bin:${PATH}"

RUN apt-get install -y musl-tools musl-dev

RUN rustup target add x86_64-unknown-linux-musl

# Download MUSL toolchain from https://musl.cc/x86_64-linux-musl-native.tgz and extract it
RUN curl -L https://musl.cc/x86_64-linux-musl-native.tgz | tar -xz -C /usr/local --strip-components=1

# RUN cp /usr/local/bin/x86_64-linux-musl-g++ /usr/local/bin/musl-g++

ENV CC=/usr/local/bin/x86_64-linux-musl-cc
ENV CXX=/usr/local/bin/x86_64-linux-musl-g++

# Specify the command to run the application
CMD ["cargo", "build", "--target=x86_64-unknown-linux-musl"]