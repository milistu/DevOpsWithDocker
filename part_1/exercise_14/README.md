# MANDATORY EXERCISE 1.14: ENVIRONMENT 🤔
Start both frontend and backend with the correct ports exposed and add [ENV](https://docs.docker.com/reference/dockerfile/#env) to Dockerfile with necessary information from both READMEs ([front](https://github.com/docker-hy/material-applications/tree/main/example-frontend), [back](https://github.com/docker-hy/material-applications/tree/main/example-backend)).

Ignore the backend configurations until the frontend sends requests to `_backend_url_/ping` when you press the button.

You know that the configuration is ready when the button for 1.14 of frontend responds and turns green.

_Do not alter the code of either project_

Submit the edited Dockerfiles and commands used to run.

![input_1](https://github.com/milistu/DevOpsWithDocker/blob/main/assets/exercise_1_14_input_1.png "Backend and Frontend")

The frontend will first talk to your browser. Then the code will be executed from your browser and that will send a message to the backend.

![input_2](https://github.com/milistu/DevOpsWithDocker/blob/main/assets/exercise_1_14_input_2.png "More information about connection between frontend and backend")

TIPS: 
- When configuring web applications keep the browser developer console ALWAYS open, F12 or cmd+shift+I when the browser window is open. Information about configuring cross-origin requests is in the README of the backend project.
- The developer console has multiple views, the most important ones are Console and Network. Exploring the Network tab can give you a lot of information on where messages are being sent and what is received as a response!

# Solution 💡
_**Note**: Make sure you are located in `./part_1/exercise_14/` directory._
## 1. Copy relevant files:

```bash
./copy_project.sh
```

## 2. Add ENV variable in both frontend and backend Dockerfile.

In the backend Dockerfile ([Exercise 13](https://github.com/milistu/DevOpsWithDocker/tree/main/part_1/exercise_13)) we need to add:

```Dockerfile
ENV REQUEST_ORIGIN=http://localhost:1000
```

However, in the frontend Dockerfile ([Exercise 12](https://github.com/milistu/DevOpsWithDocker/tree/main/part_1/exercise_12)) we need to add slightly different changes:

```Dockerfile
# Accept REACT_APP_BACKEND_URL as a build-time argument
ARG REACT_APP_BACKEND_URL

# Use the argument to set the environment variable
ENV REACT_APP_BACKEND_URL=$REACT_APP_BACKEND_URL
```
And we will pass `REACT_APP_BACKEND_URL` argument upon build. 

You probably asking yourself why? 

> React applications are built into static files (HTML, CSS, JS) by the npm run build command. During this build process, environment variables prefixed with REACT_APP_ are embedded into the built static files. This means that the values for these environment variables must be set before the build command is executed, as they are baked into the code at build time and cannot be changed without rebuilding the application.

Setting `REACT_APP_BACKEND_URL` in the Dockerfile would create problems in later exercises because we will need to change its value.

This also means that we will need to rebuild our frontend-project image!

_**Note**: Previous lines of code are already added in Dockerfiles._

## 3. Rebuild frontend-project image:

```bash
docker build --build-arg REACT_APP_BACKEND_URL=http://127.0.0.1:8080 . -t frontend-project -f Dockerfile.frontend
```

## 4. Rebuild backend-project image:

```bash
docker build . -t backend-project -f Dockerfile.backend
```

## 5. Start both backend and frontend containers:

Start backend container:
```bash
docker run -p 127.0.0.1:8080:8080 backend-project
```

Start frontend container:
```bash
docker run -p 127.0.0.1:1000:5000 frontend-project
```

## 6. Check results
Open your search engine (eg. Chrome) and type `http://127.0.0.1:1000`, you should see this when you press the button:

![success](https://github.com/milistu/DevOpsWithDocker/blob/main/assets/exercise_1_14_output.png "Exercise 14 Output")