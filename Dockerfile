FROM python:3.12-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
      texlive-latex-extra pandoc git && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

RUN pip install --no-cache-dir -r requirements.txt

RUN chmod +x scripts/build_docs.sh && ./scripts/build_docs.sh

CMD ["python", "-m", "be.api"]
