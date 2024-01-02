# MANDATORY EXERCISE 1.12: HELLO, FRONTEND! 🤔
A good developer creates well-written READMEs. Such that they can be used to create Dockerfiles with ease.

Clone, fork or download the project from https://github.com/docker-hy/material-applications/tree/main/example-frontend.

Create a Dockerfile for the project (example-frontend) and give a command so that the project runs in a Docker container with port 5000 exposed and published so when you start the container and navigate to http://localhost:5000 you will see message if you're successful.

- note that the port 5000 is reserved in the more recent OSX versions (Monterey, Big Sur), so you have to use some other host port
Submit the Dockerfile.

As in other exercises, do not alter the code of the project

- TIP: The project has install instructions in README.

- TIP: Note that the app starts to accept connections when "Accepting connections at http://localhost:5000" has been printed to the screen, this takes a few seconds

- TIP: You do not have to install anything new outside containers.

## Solution 💡

_**Note:** Our repository includes the "material-applications/spring-example-project" as a sub-module. To incorporate these files into our container, we need to first transfer them to our exercise directory. This step is crucial because Docker can only copy files from the build context, which is typically the directory containing the Dockerfile and its subdirectories._<br>
You can achieve this by initiating the docker build from the project's root, manually copying the files, or using a script to automate this process. We'll provide a script to facilitate the file copying, but feel free to adopt any method that suits your workflow best.


1. Check if port 5000 is in use:

    On Linux and macOS:
    ```bash
    sudo lsof -i :5000
    ```
    On Windows:
    ```
    netstat -ano | findstr :5000
    ```
    If you get output from these commands, it means something is running on port 5000. The output will typically include the process ID (PID) of the process using the port.

    In my case my `5000` port is **occupied** so I will be using port `1000` instead.

    _**Note**: If your port 1000 is not available you need to change the `Dockerfile` and replace 1000 with your available port!_

2. Copy relevant files:

    ```bash
    ./copy_project.sh
    ```

3. Build Docker image:

    _**Note**: Be shure you are in directory containing `Dockerfile`_

    ```bash
    docker build . -t frontend-project
    ```

4. Run container:
    
    ```bash
    docker run -p 127.0.0.1:1000:1000 frontend-project
    ```

5. Open you search engine (eg. Chrome) and type `http://127.0.0.1:1000`, you should see this:

    ![success](https://github.com/milistu/DevOpsWithDocker/blob/main/assets/exercise_12_output.png "Exercise 12 Output")

_**Note**: We won't be deleting "example-frontend" yet, we will need it for next exercises._

<!-- 6. After we verified that everything works we can now delete the "example-frontend" so we don't waste space:
    ```bash
    rm -r example-frontend
    ``` -->