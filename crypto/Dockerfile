
FROM nvidia/cuda:12.6.3-runtime-ubuntu24.04

ARG VERSION=1.0.0x

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates curl tar \
    libgomp1 libnuma1 \
    libcurl4t64 libssl3t64 \
    ocl-icd-libopencl1 && \
    rm -rf /var/lib/apt/lists/*

RUN set -eux; \
    curl -fSL \
    "https://github.com/andru-kun/wildrig-ng/releases/download/${VERSION}/wildrig-ng-linux-${VERSION}.tar.gz" \
    -o /tmp/wildrig.tar.gz; \
    mkdir -p /tmp/wildrig; \
    tar -xzf /tmp/wildrig.tar.gz -C /tmp/wildrig; \
    miner="$(find /tmp/wildrig -type f -name wildrig-ng -print -quit)"; \
    test -n "$miner"; \
    install -m 0755 "$miner" /usr/local/bin/wildrig-ng; \
    rm -rf /tmp/wildrig /tmp/wildrig.tar.gz

ENTRYPOINT ["/usr/local/bin/wildrig-ng"]
