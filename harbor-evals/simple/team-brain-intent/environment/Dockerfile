FROM python:3.12-slim

WORKDIR /app

# Verifier deps only (pytest). Keep the image tiny — no LLM SDKs.
RUN pip install --no-cache-dir pytest==8.3.5 \
    && mkdir -p /app/output /logs/verifier

CMD ["bash"]
