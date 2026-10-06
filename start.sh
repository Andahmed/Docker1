#!/usr/bin/env sh
set -e
cd "$(dirname "$0")"
docker compose up -d --build
printf '\nIstakoza POS is running at http://localhost:${ISTAKOZA_HOST_PORT:-8080}\n'
