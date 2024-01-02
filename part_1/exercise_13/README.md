# MANDATORY EXERCISE 1.13: HELLO, BACKEND! 🤔
Clone, fork or download a project from https://github.com/docker-hy/material-applications/tree/main/example-backend.

Create a Dockerfile for the project (example-backend). Start the container with port 8080 published.

When you start the container and navigate to http://localhost:8080/ping you should get a "pong" as response.

Submit the Dockerfile and the command used.

Do not alter the code of the project

## Solution 💡

_**Note:** Our repository includes the "material-applications/spring-example-project" as a sub-module. To incorporate these files into our container, we need to first transfer them to our exercise directory. This step is crucial because Docker can only copy files from the build context, which is typically the directory containing the Dockerfile and its subdirectories._<br>
You can achieve this by initiating the docker build from the project's root, manually copying the files, or using a script to automate this process. We'll provide a script to facilitate the file copying, but feel free to adopt any method that suits your workflow best.


1. Check if port 8080 is in use:

    On Linux and macOS:
    ```bash
    sudo lsof -i :8080
    ```
    On Windows:
    ```
    netstat -ano | findstr :8080
    ```
    If you get output from these commands, it means something is running on port 8080. The output will typically include the process ID (PID) of the process using the port.

    In my case my `8080` port is **free** so I will continue using it.

    _**Note**: If your port 8080 is not available you need to change the `Dockerfile` and replace 8080 with your available port!_

2. Copy relevant files:

    ```bash
    ./copy_project.sh
    ```

3. Build Docker image:

    _**Note**: Be shure you are in directory containing `Dockerfile`_

    ```bash
    docker build . -t backend-project
    ```

4. Run container:
    
    ```bash
    docker run -p 127.0.0.1:8080:8080 backend-project
    ```

5. Open you search engine (eg. Chrome) and type `http://127.0.0.1:8080/ping`, you should see `pong`.

_**Note**: We won't be deleting "example-backend" yet, we will need it for next exercises._
