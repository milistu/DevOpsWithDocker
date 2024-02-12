# EXERCISE 2.6 🤔
Let us continue with the example app that we worked with in [Exercise 2.4](https://github.com/milistu/DevOpsWithDocker/tree/main/part_2/exercise_04).

Now you should add a database to the example backend.

Use a Postgres database to save messages. For now there is no need to configure a volume since the official postgres image sets a default volume for us. Use the Postgres image documentation to your advantage when configuring: https://hub.docker.com/_/postgres/. Especially part Environment Variables is a valuable one.

The backend [README](https://github.com/docker-hy/material-applications/tree/main/example-backend) should have all the information needed to connect.

There is again a button (and a form!) in the frontend that you can use to ensure your configuration is done right.

Submit the docker-compose.yml

- TIP: When configuring the database, you might need to destroy the automatically created volumes. Use command `docker volume prune`, `docker volume ls` and `docker volume rm` to remove unused volumes when testing. Make sure to remove containers that depend on them beforehand.

- `restart: unless-stopped` can help if the Postgres takes a while to get ready

![Input](https://github.com/milistu/DevOpsWithDocker/blob/main/assets/exercise_2_6_input.png "Exercise 2.06 Input")

# Solution 💡

## 1. Copy the docker compose file from Exercise 2.4:
_**Note**: Be shure you are placed in directory `./part_2/exercise_06/`._

```bash
cp ../exercise_04/docker-compose.yml docker-compose.yml
```

## 2. Add Postgres database `docker-compose.yml`:
```docker
  db:
    image: postgres:13.2-alpine
    restart: unless-stopped    
    container_name: db
    environment:
      POSTGRES_PASSWORD: postgres
```
We also need to set environment variables in backend:
```docker
    - POSTGRES_HOST=db
    - POSTGRES_USER=postgres
    - POSTGRES_PASSWORD=postgres
```
Also, we will ad that backend depends on db:
```docker
  depends_on:
    - db
      
```

## 3. Run docker compose:
```bash
docker compose up
```

## Check the output:
Open you search engine (eg. Chrome) and type `http://127.0.0.1:1000`, you should see this when you press the button:

![success](https://github.com/milistu/DevOpsWithDocker/blob/main/assets/exercise_2_6_output.png "Exercise 2.06 Output")


