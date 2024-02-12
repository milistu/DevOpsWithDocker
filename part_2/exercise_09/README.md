# EXERCISE 2.9 🤔
Most of the buttons may have stopped working in the example application. Make sure that every button for exercises works.

Remember to take a peek into the browsers developer consoles again like we did back [part 1](https://devopswithdocker.com/part-1/section-6/), remember also [this](https://github.com/docker-hy/material-applications/tree/main/example-frontend#exercise-114---to-connect-to-backend) and [this](https://github.com/docker-hy/material-applications/tree/main/example-backend).

The buttons of Nginx exercise and the first button behave differently but you want them to match.

If you had to do any changes explain what you did and where.

Submit the docker-compose.yml and both Dockerfiles.

# Solution 💡

## 1. Copy the docker compose file and ndinx config from Exercise 2.8:
_**Note**: Be shure you are placed in directory `./part_2/exercise_09/`._

```bash
rsync -av --exclude='README.md' ../exercise_08/ ./
```

## 2. We need to change backend and forntend url's in docker compose file:

Add this to backend:
```docker
environment:
    - REQUEST_ORIGIN=http://localhost
```
Add this to frontend:
```docker
environment:
    - REACT_APP_BACKEND_URL=http://localhost/api
```

## 3. Run docker compose:
```bash
docker compose up
```

## Check the output:
Open you search engine (eg. Chrome) and type `http://127.0.0.1` (or `http://localhost/`).

Check, every button should work now!