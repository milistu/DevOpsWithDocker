# EXERCISE 2.4 🤔
In this exercise, you should expand the configuration done in [Exercise 2.3](https://devopswithdocker.com/part-2/section-1/#exercises-22---23) and set up the example backend to use the key-value database [Redis](https://redis.com/).

Redis is quite often used as a [cache](https://en.wikipedia.org/wiki/Cache_(computing)) to store data so that future requests for data can be served faster.

The backend uses a slow API to fetch some information. You can test the slow API by requesting `/ping?redis=true` with curl. The frontend app has a button to test this.

So you should improve the performance of the app and configure a Redis container to cache information for the backend. The [documentation](https://hub.docker.com/_/redis/) of the Redis image might contain some useful info.

The backend [README](https://github.com/docker-hy/material-applications/tree/main/example-backend) should have all the information that is needed for configuring the backend.

When you've correctly configured the button will turn green.

Submit the docker-compose.yml

![Input](https://github.com/milistu/DevOpsWithDocker/blob/main/assets/exercise_2_4_input.png "Exercise 2.04 Input")

The [restart: unless-stopped](https://docs.docker.com/compose/compose-file/compose-file-v3/#restart) configuration can help if the Redis takes a while to get ready.

# Solution 💡

## 1. Create the docker-compose file:
_**Note**: Be sure you are placed in the directory `./part_2/exercise_04/`._

```bash
touch docker-compose.yml
```

## 2. Populate the `docker-compose.yml`:
```yml
version: '3.8'

services:
  backend:
    image: backend-project
    build: 
      context: ../exercise_04/example-backend
      dockerfile: Dockerfile.backend
    ports:
      - 8080:8080
    environment:
      - REDIS_HOST=redis
    container_name: backend

  frontend:
    image: frontend-project
    build: 
      context: ../exercise_04/example-frontend
      dockerfile: Dockerfile.frontend
      args:
        - REACT_APP_BACKEND_URL=http://127.0.0.1:8080
    ports:
      - 1000:5000
    container_name: frontend
  
  redis:
    image: redis:alpine
    container_name: redis
```

This setup configures a backend and frontend service, with the backend connecting to a Redis database for caching or storage, all containerized and networked for local development or deployment.

## 3. Run the docker-compose:
```bash
docker compose up
```

## Check the output:
Open your search engine (eg. Chrome) and type `http://127.0.0.1:1000`, you should see this when you press the button:

![success](https://github.com/milistu/DevOpsWithDocker/blob/main/assets/exercise_2_4_output.png "Exercise 2.04 Output")

## Cleanup 🧹
Remove docker containers:
```bash
docker compose down
```