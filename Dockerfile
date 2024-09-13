FROM rust:1.75-alpine

# Set the working directory inside the container
WORKDIR /usr/src/myapp

# Install necessary dependencies
RUN apk add --no-cache musl-dev g++ make

# Add the MUSL target
RUN rustup target add x86_64-unknown-linux-musl

# Copy the current directory contents into the container
COPY . .

# Build the application
RUN cargo build --release --target x86_64-unknown-linux-musl

# Specify the command to run the application
CMD ["./target/x86_64-unknown-linux-musl/release/luau-repro"]
