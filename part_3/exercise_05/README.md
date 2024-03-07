# MANDATORY EXERCISE 3.5 🤔
In exercises [1.12](https://devopswithdocker.com/part-1/section-6/#exercises-111-114) and [1.13](https://devopswithdocker.com/part-1/section-6/#exercises-111-114) we created Dockerfiles for both example [frontend](https://github.com/docker-hy/material-applications/tree/main/example-frontend) and [backend](https://github.com/docker-hy/material-applications/tree/main/example-backend).

Security issues with the user being a root are serious for the example frontend and backend as the containers for web services are supposed to be accessible through the Internet.

Make sure the containers start their processes as a non-root user.

Backend image is based on [Alpine Linux](https://www.alpinelinux.org/), that does not support the command `useradd`. Google will surely help you a way to create user in an `alpine` based image.

Submit the Dockerfiles.

# Solution 💡

## 1. Copy Necessery files:
_**Note**: Make sure you are located in `./part_3/exercise_05/` directory._

Run command:
```bash
./copy_files.sh
```

You will now see both **exercise-frontend** and **exercise-backend** dirs.

## 2. Frontend - Create Dockerfile
_**Note**: Make sure you are located in `./part_3/exercise_05/exercise-frontend` directory._


We will use existing dockerfile from [exercise 1.12](https://github.com/milistu/DevOpsWithDocker/tree/main/part_1/exercise_12). 
We will add code for non-root user:
```dockerfile
# Create a non-root user
RUN adduser -D appuser && \
    chown -R appuser:appuser /app

USER appuser
```

## 3. Build frontend image and run container:
Build Docker image with command:
```bash
docker build --build-arg REACT_APP_BACKEND_URL=http://127.0.0.1:8080 . -t frontend
```

Run Docker container:
```bash
docker run --rm -p 127.0.0.1:1000:1000 frontend
```


## 4. Backend - Create Dockerfile
_**Note**: Make sure you are located in `./part_3/exercise_05/exercise-backend` directory._

We will use existing dockerfile from [exercise 1.13](https://github.com/milistu/DevOpsWithDocker/tree/main/part_1/exercise_13). 
We will add code for non-root user:
```dockerfile
# Create a non-root user
RUN adduser -D appuser && \
    chown -R appuser:appuser /app

USER appuser
```

## 5. Build backend image and run container:
Build Docker image with command:
```bash
docker build . -t backend
```

Run Docker container:
```bash
docker run --rm -p 127.0.0.1:8080:8080 backend
```

## 6. Check user:
If you want to check user of your running container you can simply run this command:
```bash
docker exec -it CONTAINER_NAME_OR_ID id
```

And you will get output similar to this:
```bash
uid=1000(appuser) gid=1000(appuser) groups=1000(appuser)
```

## 6. Check results
Open you search engine (eg. Chrome) and type `http://127.0.0.1:1000`, you should see this when you press the button:

![success](https://github.com/milistu/DevOpsWithDocker/blob/main/assets/exercise_1_14_output.png "Exercise 14 Output")