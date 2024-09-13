docker-build:
    docker build -t luau_builder .

docker-run:
    docker run --rm -it luau_builder

docker-both: docker-build docker-run
