# MANDATORY EXERCISE 1.13: HELLO, BACKEND! 🤔
Clone, fork or download a project from https://github.com/docker-hy/material-applications/tree/main/example-backend.

Create a Dockerfile for the project (example-backend). Start the container with port 8080 published.

When you start the container and navigate to http://localhost:8080/ping you should get a "pong" as a response.

Submit the Dockerfile and the command used.

Do not alter the code of the project

# Solution 💡

## 1. Check if port 8080 is in use:

On Linux and macOS:
```bash
sudo lsof -i :8080
```
On Windows:
```
netstat -ano | findstr :8080
```
If you get output from these commands, it means something is running on port 8080. The output will typically include the process ID (PID) of the process using the port.

In my case, my `8080` port is **free** so I will continue using it.

_**Note**: If your port 1000 is not available you need to find the available port and use it instead during the exercise._

## 2. Copy relevant files:

```bash
./copy_project.sh
```

## 3. Build Docker image:

_**Note**: Be sure you are in the directory containing `Dockerfile`_

```bash
docker build . -t backend-project
```

## 4. Run container:
    
```bash
docker run --rm -p 127.0.0.1:8080:8080 backend-project
```

## 5. Check results:
Open your search engine (eg. Chrome) and type `http://127.0.0.1:8080/ping`, you should see `pong`.

_**Note**: We won't be deleting "example-backend" yet, we will need it for the next exercises._
