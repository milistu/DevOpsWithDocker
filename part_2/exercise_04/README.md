# EXERCISE 2.4 🤔
In this exercise you should expand the configuration done in [Exercise 2.3](https://devopswithdocker.com/part-2/section-1/#exercises-22---23) and set up the example backend to use the key-value database [Redis](https://redis.com/).

Redis is quite often used as a [cache](https://en.wikipedia.org/wiki/Cache_(computing)) to store data so that future requests for data can be served faster.

The backend uses a slow API to fetch some information. You can test the slow API by requesting `/ping?redis=true` with curl. The frontend app has a button to test this.

So you should improve the performance of the app and configure a Redis container to cache information for the backend. The [documentation](https://hub.docker.com/_/redis/) of the Redis image might contain some useful info.

The backend [README](https://github.com/docker-hy/material-applications/tree/main/example-backend) should have all the information that is needed for configuring the backend.

When you've correctly configured the button will turn green.

Submit the docker-compose.yml

![Input](https://github.com/milistu/DevOpsWithDocker/blob/main/assets/exercise_2_4_input.png "Exercise 2.04 Input")

Backend, frontend and redis

The [restart: unless-stopped](https://docs.docker.com/compose/compose-file/compose-file-v3/#restart) configuration can help if the Redis takes a while to get ready.

# Solution 💡

## 1. Check for necessary Images:
```bash
docker images 
```
If you do not see `frontend-project` and `backend-project`, refer to the first step from [previous exercise](https://github.com/milistu/DevOpsWithDocker/tree/main/part_2/exercise_03) to rebuild them.


## 1. Create docker compose file:
_**Note**: Be shure you are placed in directory `./part_2/exercise_04/`._

```bash
touch docker-compose.yml
```

## 2. Populate the `docker-compose.yml`:
- **Version**: `3.8`

- **Services**:
  - **Backend**:
    - **Image**: `backend-project`
    - **Container Name**: `backend`
    - **Ports**: Maps port `8080` on the host to port `8080` in the container.

  - **Frontend**:
    - **Image**: `frontend-project`
    - **Container Name**: `frontend`
    - **Ports**: Maps port `1000` on the host to port `1000` in the container.

Configures and runs separate containers for backend and frontend projects, accessible on ports `8080` and `1000` of the host, respectively.

## 3. Run docker compose:
```bash
docker compose up
```

## Check the output:
Open you search engine (eg. Chrome) and type `http://127.0.0.1:1000`, you should see this when you press the button:

  ![success](https://github.com/milistu/DevOpsWithDocker/blob/main/assets/exercise_2_4_output.png "Exercise 2.04 Output")