# EXERCISE 2.1 🤔
Let us now leverage the Docker Compose with the simple webservice that we used in [Exercise 1.3](https://devopswithdocker.com/part-1/section-2/#exercise-13)

Without a command `devopsdockeruh/simple-web-service` will create logs into its `/usr/src/app/text.log`.

Create a docker-compose.yml file that starts `devopsdockeruh/simple-web-service` and saves the logs into your filesystem.

Submit the docker-compose.yml, and make sure that it works simply by running `docker compose up` if the log file exists.

# Solution 💡

_**Note**: Be sure you are placed in the directory `./part_2/exercise_01/`._

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
        build: .
        volumes:
            - ./text.log:/usr/src/app/text.log
        container_name: sws
```

## 3. Create `text.log`:
_**Note**: When Docker Compose processes the volume definition (`- ./text.log:/usr/src/app/text.log`), it looks for `./text.log` on the host. If it doesn't find an existing file at that path, Docker automatically creates a directory with the name `text.log` in the host's specified path, because Docker cannot determine if you intended to mount a file or a directory._

```bash
touch text.log
```

## 4. Run the docker-compose:
```bash
docker compose up
```

## Check the output:
Open the `text.log` file to uncover the secret message!