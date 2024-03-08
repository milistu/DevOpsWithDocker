FROM node:16.20.2-alpine3.18

WORKDIR /app

# --- Additional for Exercise 1.14
# Accept REACT_APP_BACKEND_URL as a build-time argument
ARG REACT_APP_BACKEND_URL

# Use the argument to set the environment variable
ENV REACT_APP_BACKEND_URL=$REACT_APP_BACKEND_URL

COPY . /app

RUN npm install && \
    npm run build && \
    npm install -g serve && \
    adduser -D appuser && \
    chown -R appuser:appuser /app

USER appuser

# Change port number here if it is not available
ENV PORT=1000
EXPOSE $PORT

CMD serve -s -l $PORT build