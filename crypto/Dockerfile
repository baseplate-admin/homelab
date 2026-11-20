
FROM nvidia/cuda:12.6.3-runtime-ubuntu24.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates curl tar \
    libgomp1 libnuma1 && \
    rm -rf /var/lib/apt/lists/*

ARG LPMINER_URL=https://github.com/BaikalMine-Pools/pearl-miner/releases/download/v0.1.10/lpminer-0.1.9.tar.gz

ARG LPMINER_SHA256=2C7575B87A0EA95146BC83BF8C0729A7A9F551C64C5EDFC2E51684E0EC78C196

RUN set -eux; \
    mkdir -p /opt/lpminer; \
    curl -fL --retry 3 \
    "$LPMINER_URL" \
    -o /tmp/lpminer.tar.gz; \
    echo "$LPMINER_SHA256  /tmp/lpminer.tar.gz" \
    | sha256sum -c -; \
    tar -tzf /tmp/lpminer.tar.gz > /dev/null; \
    tar -xzf /tmp/lpminer.tar.gz -C /opt/lpminer; \
    rm /tmp/lpminer.tar.gz

RUN printf '%s\n' \
    '#!/bin/sh' \
    'set -eu' \
    'miner="$(find /opt/lpminer -type f -name lpminer -print -quit)"' \
    'test -n "$miner"' \
    'chmod +x "$miner"' \
    'cd "$(dirname "$miner")"' \
    'exec "$miner" "$@"' \
    > /usr/local/bin/start-miner && \
    chmod +x /usr/local/bin/start-miner

ENTRYPOINT ["/usr/local/bin/start-miner"]
