# MANDATORY EXERCISE 1.14: ENVIRONMENT 🤔
Start both frontend-example and backend-example with correct ports exposed and add ENV to Dockerfile with necessary information from both READMEs ([front](https://github.com/docker-hy/material-applications/tree/main/example-frontend), [back](https://github.com/docker-hy/material-applications/tree/main/example-backend)).

Ignore the backend configurations until frontend sends requests to `_backend_url_/ping` when you press the button.

You know that the configuration is ready when the button for 1.14 of frontend-example responds and turns green.

Do not alter the code of either project

Submit the edited Dockerfiles and commands used to run.

![input_1](https://github.com/milistu/DevOpsWithDocker/blob/main/assets/exercise_1_14_input_1.png "Backend and Frontend")

The frontend will first talk to your browser. Then the code will be executed from your browser and that will send a message to backend.

![input_2](https://github.com/milistu/DevOpsWithDocker/blob/main/assets/exercise_1_14_input_1.png "More information about connection between frontend and backend")

- TIP: When configuring web applications keep browser developer console ALWAYS open, F12 or cmd+shift+I when the browser window is open. Information about configuring cross origin requests is in README of the backend project.

- TIP: Developer console has multiple views, most important ones are Console and Network. Exploring the Network tab can give you a lot of information on where messages are being sent and what is received as response!

## Solution 💡

1. We need to add ENV variable in both frontend and backend Dockerfile.

    In frontend Dockerfile (Exercise 12) we need to add:

    ```Dockerfile
    ENV REACT_APP_BACKEND_URL=http://localhost:8080
    ```
    And, in backend Dockerfile (Exercise 13) we need to add:

    ```Dockerfile
    ENV REQUEST_ORIGIN=http://localhost:1000
    ```

    _**Note**: Previous lines of code are already added in Dockerfiles._

2. Start both backend and frontend containers:

    Start backend container:
    ```bash
    docker run -p 127.0.0.1:8080:8080 backend-project
    ```

    Start frontend container:
    ```bash
    docker run -p 127.0.0.1:1000:1000 frontend-project
    ```

3. Open you search engine (eg. Chrome) and type `http://127.0.0.1:1000`, you should see this when you press the button:

    ![success](https://github.com/milistu/DevOpsWithDocker/blob/main/assets/exercise_1_14_output.png "Exercise 14 Output")

4. After we verified that everything works we can now delete the "example-frontend" and "example-backend" from previous exercises so we don't waste space:

    _**Note**: Be shure you are in directory `part_1/exercise_14/`_

    ```bash
    rm -r ../exercise_12/example-frontend ../exercise_13/example-backend
    ```