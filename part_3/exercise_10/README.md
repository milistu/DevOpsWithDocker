# EXERCISE 3.10 🤔
Do all or most of the optimizations from security to size for **one** other Dockerfile you have access to, in your own project or for example the ones used in previous "standalone" exercises.

Please document Dockerfiles both before and after.

# Solution 💡
We will be optimizing the [simple-backend](https://github.com/milistu/simple-backend) project. 
Our image currently is **648MB**.

Our Dockerfile initially looked like this:
```Dockerfile
FROM python:3.10-slim-buster

WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y \
    gcc \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

COPY . .

RUN pip install -r requirements.txt

ENV PORT=1000 \
    SECRET_KEY=BuyBreadTomorrow

EXPOSE $PORT

CMD uvicorn backend:app --host 0.0.0.0 --port $PORT
```

## Optimize Dockerfile
Our current base image is `python:3.10-slim-buster` which has [41.51 MB for arm architecture](https://hub.docker.com/layers/library/python/3.10-slim-buster/images/sha256-adc29f2dfca5c642beef9974fef09bf05fadcb39a59ff91d62671975a6d53ddb?context=explore) which is quite small to begin with, so we will try to merge RUN commands.

```Dockerfile

```

Our image size is still **648MB** 😿.

## Multi-stage build
Can we shrink our image with a multi-stage build?

```Dockerfile
FROM python:3.10-slim-buster as builder

WORKDIR /usr/src/app

COPY . .

RUN apt-get update && apt-get install -y \
    gcc \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/* &&\
    pip install --user -r requirements.txt


FROM python:3.10-slim-buster

RUN apt-get update && apt-get install -y \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*
    
WORKDIR /home/app

COPY --from=builder /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH

COPY . .

ENV PORT=1000 SECRET_KEY=BuyBreadTomorrow
EXPOSE $PORT

CMD uvicorn backend:app --host 0.0.0.0 --port $PORT
```
Our image is now **497MB**.

## Change user
One more thing to do so our image is more secure. We need to change the root user!

```Dockerfile
FROM python:3.10-slim-buster as builder

WORKDIR /usr/src/app

COPY . .

RUN apt-get update && apt-get install -y \
    gcc \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/* &&\
    pip install --user -r requirements.txt

FROM python:3.10-slim-buster

RUN apt-get update && apt-get install -y \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/* && \
    useradd -m appuser
USER appuser

WORKDIR /home/appuser

COPY --from=builder /root/.local /home/appuser/.local

ENV PATH=/home/appuser/.local/bin:$PATH

COPY --chown=appuser:appuser . .

ENV PORT=1000 SECRET_KEY=BuyBreadTomorrow
EXPOSE $PORT

CMD uvicorn backend:app --host 0.0.0.0 --port $PORT
```

We can check that we properly set the non-root user:
```bash
➜ docker exec -it CONTAINER_ID_OR_NAME id

uid=1000(appuser) gid=1000(appuser) groups=1000(appuser)
```

Our Docker image is still **497MB**.

Great job, we managed to lower our Image size for 151MB! 👌
