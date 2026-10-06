FROM python:3.11-slim-bookworm

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    ISTAKOZA_DATA=/data \
    ISTAKOZA_PORT=8080 \
    ISTAKOZA_MODE=full \
    TZ=Africa/Cairo

WORKDIR /app

# Cairo timezone is important because the POS stores local sale/backup timestamps.
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata \
    && rm -rf /var/lib/apt/lists/*

COPY app/server.py app/pos_istakoza.html ./

RUN mkdir -p /data

EXPOSE 8080
VOLUME ["/data"]

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://127.0.0.1:8080/api/site', timeout=3).read()" || exit 1

CMD ["python", "server.py", "--no-browser"]
