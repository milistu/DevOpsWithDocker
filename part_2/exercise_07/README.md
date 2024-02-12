# EXERCISE 2.7 🤔
Postgres image uses a volume by default. Define manually a volume for the database in a convenient location such as in `./database` so you should use now a [bind mount](https://docs.docker.com/storage/bind-mounts/). The image [documentation](https://github.com/docker-library/docs/blob/master/postgres/README.md#where-to-store-data) may help you with the task.

After you have configured the bind mount volume:

- Save a few messages through the frontend
- Run `docker compose down`
- Run `docker compose up` and see that the messages are available after refreshing browser
- Run `docker compose down` and delete the volume folder manually
- Run `docker compose up` and the data should be gone

> TIP: To save you the trouble of testing all of those steps, just look into the folder before trying the steps. If it's empty after `docker compose up` then something is wrong.

Submit the docker-compose.yml

The benefit of a bind mount is that since you now exactly where the data is in your file system, it is easy to create backups. If Docker managed volumes are used, the location of the data in the file system can not be controlled and that makes backups a bit less trivial...

# Solution 💡

## 1. Copy the docker compose file from Exercise 2.6:
_**Note**: Be shure you are placed in directory `./part_2/exercise_07/`._

```bash
cp ../exercise_06/docker-compose.yml docker-compose.yml
```

## 2. Add bind mount to database `docker-compose.yml`:
```docker
volumes:
    - ./database:/var/lib/postgresql/data
```

## 3. Create a database folder:
```bash
mkdir database
```

## 4. Run docker compose:
```bash
docker compose up
```

## Check the output:

- Save a few messages through the frontend
    - Open you search engine (eg. Chrome) and type `http://127.0.0.1:1000`

    ![success](https://github.com/milistu/DevOpsWithDocker/blob/main/assets/exercise_2_7_output.png "Exercise 2.07 Output")

- Run `docker compose down` ✅
- Run `docker compose up` and see that the messages are available after refreshing browser ✅
    - We have all messages when button "GET ALL MESSAGES!" is pressed.

- Run `docker compose down` and delete the volume folder manually ✅
    - Run command to delete the folder: ```rm -r database```
- Run `docker compose up` and the data should be gone ✅
    - We get only "pong" message when button "GET ALL MESSAGES!" is pressed.