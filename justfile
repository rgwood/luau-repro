set shell := ["nu", "-c"]

docker-build:
    docker build -t luau_builder .

docker-run:
    docker run --rm -it -v $"(pwd):/usr/src/myapp" luau_builder

docker-both: docker-build docker-run


watch:
    watchexec --exts=rs -- cargo run

watch-serve:
    watchexec --exts=rs --on-busy-update=restart -- cargo run

run:
    cargo run

test:
    cargo test

watch-tests:
    watchexec --exts=rs -- cargo test

expected_filename := if os_family() == "windows" { "luau-repro.exe" } else { "luau-repro" }

build-release:
    cargo build --release
    @$"Build size: (ls target/release/{{expected_filename}} | get size)"

publish-to-local-bin: build-release
    cp target/release/{{expected_filename}} ~/bin/

build-linux-x64:
    cross build --target x86_64-unknown-linux-gnu --release

build-linux-arm64:
    cross build --target aarch64-unknown-linux-gnu --release

build-windows-on-linux:
    cross build --target x86_64-pc-windows-gnu --release
