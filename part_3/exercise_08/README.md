# EXERCISE 3.8: MULTI-STAGE FRONTEND 🤔
Do now a multi-stage build for the example [frontend](https://github.com/docker-hy/material-applications/tree/main/example-frontend).

Even though multi-stage builds are designed mostly with binaries in mind, we can leverage the benefits with our frontend project as having original source code with the final assets makes little sense. Build it with the instructions in README and the built assets should be in the `build` folder.

You can still use the `serve` to serve the static files or try out something else.

# Solution 💡

## 1. Copy Necessary files:
_**Note**: Make sure you are located in `./part_3/exercise_8/` directory._

Run command:
```bash
./copy_files.sh
```

## 2. Optimize Images:
Remember from the previous exercise, our image has **478MB**.

Our Docker image looks like this:
```Dockerfile
FROM node:16.20.2-alpine3.18

WORKDIR /app

ARG REACT_APP_BACKEND_URL

ENV REACT_APP_BACKEND_URL=$REACT_APP_BACKEND_URL

COPY ./example-frontend /app

RUN npm install && \
    npm run build && \
    npm install -g serve && \
    adduser -D appuser && \
    chown -R appuser:appuser /app

USER appuser

ENV PORT=1000
EXPOSE $PORT

CMD serve -s -l $PORT build
```

When we introduce multi-stage build, now it looks like this:
```Dockerfile
FROM node:16.20.2-alpine3.18 as build

WORKDIR /app

ARG REACT_APP_BACKEND_URL

ENV REACT_APP_BACKEND_URL=$REACT_APP_BACKEND_URL

COPY ./example-frontend /app

RUN npm install && npm run build

FROM node:16.20.2-alpine3.18

RUN npm install -g serve && \
    adduser -D appuser
    # chown -R appuser:appuser /app

COPY --from=build /app/build /app/build

USER appuser

WORKDIR /app

# Change port number here if it is not available
ENV PORT=1000
EXPOSE $PORT

CMD serve -s -l $PORT build
```

And now our image is **128MB**! Great job!