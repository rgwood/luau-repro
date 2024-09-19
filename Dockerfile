FROM rust:1.81-alpine

# Install necessary dependencies
RUN apk add --no-cache musl-dev g++ make

# Add the MUSL target
RUN rustup target add x86_64-unknown-linux-musl
