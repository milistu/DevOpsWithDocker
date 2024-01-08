FROM python:3.10-slim

WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    python3-dev \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

RUN pip install poetry

COPY /simple-backend/ .

RUN poetry config virtualenvs.create false

EXPOSE 8000

ENV MY_API_TOKEN=ICanKeepASecretRealGood

RUN poetry install --no-dev 

CMD ["uvicorn", "backend:app", "--host", "0.0.0.0", "--port", "8000"]