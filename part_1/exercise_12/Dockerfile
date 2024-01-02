FROM node:16.20.2-alpine3.18

WORKDIR /app

# Additional for Exercise 1.14
ENV REACT_APP_BACKEND_URL=http://localhost:8080
# End of Additional

COPY /example-frontend /app

RUN npm install
RUN npm run build
RUN npm install -g serve

# Change port number here if it is not available
ENV PORT=1000
EXPOSE $PORT

CMD serve -s -l $PORT build