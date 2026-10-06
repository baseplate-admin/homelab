#!/bin/sh
# v0.2.0 backend (Django + Channels).
# Migrations are optional here — v0.2.0 runs `manage.py migrate` automatically
# at boot (per the upgrade guide). We still run it explicitly so it's visible
# and idempotent; it's a no-op if already applied.
set -e

cd /app || exit 1

python manage.py migrate --noinput

exec uvicorn core.asgi:application \
  --host 0.0.0.0 \
  --port 8000 \
  --timeout-keep-alive 0 \
  --limit-concurrency 1000
