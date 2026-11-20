
FROM nvidia/cuda:12.6.3-runtime-ubuntu24.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates curl libgomp1 libnuma1 && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/lpminer && \
    curl -fsSL \
    https://pearl.luckypool.io/lpminer/lpminer-0.1.9.tar.gz \
    -o /tmp/lpminer.tar.gz && \
    tar -xzf /tmp/lpminer.tar.gz -C /opt/lpminer && \
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
