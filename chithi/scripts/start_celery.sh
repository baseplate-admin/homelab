#!/bin/sh
# v0.2.0 celery worker. App lives in the `core` package (was `app.celery`).
# One-shot expiry tasks only — no beat/periodic scheduler needed.
set -e

cd /app || exit 1

# Run (nproc - 1) concurrent prefork children, fallback to 1.
CORES=$(nproc 2>/dev/null || echo 1)
if [ "$CORES" -gt 1 ]; then
  CONCURRENCY=$((CORES - 1))
else
  CONCURRENCY=1
fi

exec celery -A core worker \
  --concurrency "$CONCURRENCY" \
  --loglevel=info \
  --max-memory-per-child=131072
