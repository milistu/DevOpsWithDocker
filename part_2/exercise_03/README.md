# MANDATORY EXERCISE 2.3 🤔
As we saw previously, starting an application with two programs was not trivial and the commands got a bit long.

In the [previous part](https://devopswithdocker.com/part-1/section-6/) we created Dockerfiles for both [frontend](https://github.com/docker-hy/material-applications/tree/main/example-frontend) and [backend](https://github.com/docker-hy/material-applications/tree/main/example-backend) of the example application. Next, simplify the usage into one docker-compose.yml.

Configure the backend and frontend from [part 1](https://devopswithdocker.com/part-1/section-6#exercises-111-114) to work in Docker Compose.

Submit the docker-compose.yml

# Solution 💡

_**Note**: Be sure you are placed in the directory `./part_2/exercise_03/`._

## 1. Copy relevant files:

```bash
./copy_project.sh
```

## 2. Create the docker-compose file:
_**Note**: Be sure you are placed in the directory `./part_2/exercise_03/`._
```bash
cd ../../part_2/exercise_03/
```

```bash
touch docker-compose.yml
```

## 3. Populate the `docker-compose.yml`:

```yml
version: '3.8'

services:
  backend:
    build: 
      context: example-backend
      dockerfile: Dockerfile.backend
    ports:
      - 8080:8080
    container_name: backend
  
  frontend:
    build: 
      context: example-frontend
      dockerfile: Dockerfile.frontend
      args:
        - REACT_APP_BACKEND_URL=http://127.0.0.1:8080
    ports:
      - 1000:5000
    container_name: frontend
```

Configures and runs separate containers for backend and frontend projects, accessible on ports `8080` and `1000` of the host, respectively.

## 4. Run the docker-compose:
```bash
docker compose up
```

## Check the output:
Open your search engine (eg. Chrome) and type `http://127.0.0.1:1000`, you should see this when you press the button:

  ![success](https://github.com/milistu/DevOpsWithDocker/blob/main/assets/exercise_1_14_output.png "Exercise 2.03 Output")

## Cleanup 🧹
Remove docker containers:
```bash
docker compose down
```
