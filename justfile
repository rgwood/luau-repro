docker-build:
    docker build -t luau_builder .

docker-run:
    docker run --rm -v "$(pwd)":/app -w /app luau_builder cargo build --target x86_64-unknown-linux-musl

docker-both: docker-build docker-run

docker-tag:
    docker tag luau_builder ghcr.io/rgwood/luau_builder:latest

docker-push:
    docker push ghcr.io/rgwood/luau_builder:latest