# EXERCISE 2.9 🤔
Most of the buttons may have stopped working in the example application. Make sure that every button for exercises works.

Remember to take a peek into the browser's developer consoles again like we did back in [part 1](https://devopswithdocker.com/part-1/section-6/), remember also [this](https://github.com/docker-hy/material-applications/tree/main/example-frontend#exercise-114---to-connect-to-backend) and [this](https://github.com/docker-hy/material-applications/tree/main/example-backend).

The buttons of the Nginx exercise and the first button behave differently but you want them to match.

If you had to make any changes explain what you did and where.

Submit the docker-compose.yml and both Dockerfiles.

# Solution 💡
_**Note**: Be sure you are placed in the directory `./part_2/exercise_09/`._

## 1. Copy the docker-compose file and Nginx config from Exercise 2.8:
_**Note**: Working docker-compose is already present in the directory, these steps only describe to you how we achieved this._

```bash
rsync -av --exclude='README.md' ../exercise_08/ ./
```

## 2. We need to change the backend and the frontend URLs in the docker-compose file:

Add this to the backend:
```yml
environment:
    - REQUEST_ORIGIN=http://localhost
```
Change this in frontend:
```yml
args:
    - REACT_APP_BACKEND_URL=http://localhost/api
```

## 3. Run docker-compose:
```bash
docker compose up
```

## Check the output:
Open your search engine (eg. Chrome) and type `http://127.0.0.1` (or `http://localhost/`).

Check, every button should work now!

## Cleanup 🧹
Remove docker containers:
```bash
docker compose down
```