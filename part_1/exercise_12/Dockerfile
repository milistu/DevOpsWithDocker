FROM node:16.20.2-alpine3.18

WORKDIR /app

COPY /example-frontend /app

RUN npm install
RUN npm run build
RUN npm install -g serve

# Change port number here if it is not available
ENV PORT=5000
EXPOSE $PORT

CMD serve -s -l $PORT build