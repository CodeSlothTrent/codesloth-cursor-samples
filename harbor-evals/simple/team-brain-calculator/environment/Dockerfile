FROM python:3.12-slim

WORKDIR /app

RUN pip install --no-cache-dir pytest==8.3.5 \
    && mkdir -p /app/output /logs/verifier

CMD ["bash"]
