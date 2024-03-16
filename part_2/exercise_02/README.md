# EXERCISE 2.2 🤔
Read about how to add the command to docker-compose.yml from the [documentation](https://docs.docker.com/compose/compose-file/compose-file-v3/#command).

The familiar image `devopsdockeruh/simple-web-service` can be used to start a web service, see the [exercise 1.10](https://devopswithdocker.com/part-1/section-5/#exercise-110).

Create a docker-compose.yml and use it to start the service so that you can use it with your browser.

Submit the docker-compose.yml, and make sure that it works simply by running `docker compose up`

# Solution 💡

_**Note**: Be sure you are placed in the directory `./part_2/exercise_02/`._

## 1. First create the docker-compose file:
```bash
touch docker-compose.yml
```

## 2. Populate the `docker-compose.yml`:

```yml
version: '3.8'

services:
  simple-web-service:
    image: devopsdockeruh/simple-web-service
    ports:
      - 8080:8080
    container_name: sws
    command: server
```

- **Version**: `3.8`
- **Service**: `simple-web-service`
  - **Image**: `devopsdockeruh/simple-web-service`
  - **Container Name**: `sws`
  - **Ports**: Maps port `8080` on the host to port `8080` in the container.
  - **Command**: Runs the `server` command within the container.

Launches a web service accessible on port `8080` of the host.

## 3. Run the docker-compose:
```bash
docker compose up
```

## Check the output:
Open the web browser and search `http://localhost:8080/`. 
You should see the following message:
```js
{"message":"You connected to the following path: /","path":"/"}
```