# EXERCISE 2.1 🤔
Let us now leverage the Docker Compose with the simple webservice that we used in the [Exercise 1.3](https://devopswithdocker.com/part-1/section-2/#exercise-13)

Without a command `devopsdockeruh/simple-web-service` will create logs into its `/usr/src/app/text.log`.

Create a docker-compose.yml file that starts `devopsdockeruh/simple-web-service` and saves the logs into your filesystem.

Submit the docker-compose.yml, make sure that it works simply by running `docker compose up` if the log file exists.

## Solution 💡

_**Note**: Be shure you are placed in directory `./part_2/exercise_01/`._

### 1. First create docker compose file:
```bash
touch docker-compose.yml
```

### 2. Populate the `docker-compose.yml`:
- **Service Name**: `simple-web-service`
- **Image**: Built from the current directory, tagged as `devopsdockeruh/simple-web-service`.
- **Volume**: Maps `./text.log` on the host to `/usr/src/app/text.log` in the container for log persistence.
- **Container Name**: `sws`

### 3. Create `text.log`:
_**Note**: When Docker Compose processes the volume definition (`- ./text.log:/usr/src/app/text.log`), it looks for `./text.log` on the host. If it doesn't find an existing file at that path, Docker automatically creates a directory with the name `text.log` in the host's specified path, because Docker cannot determine if you intended to mount a file or a directory._

```bash
touch text.log
```

### 4. Run docker compose:
```bash
docker compose up
```

### Check the output:
Open the `text.log` file to uncover the secret message!