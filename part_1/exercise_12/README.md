# MANDATORY EXERCISE 1.12: HELLO, FRONTEND! 🤔
A good developer creates well-written READMEs. Such that they can be used to create Dockerfiles with ease.

Clone, fork or download the project from https://github.com/docker-hy/material-applications/tree/main/example-frontend.

Create a Dockerfile for the project (example-frontend) and give a command so that the project runs in a Docker container with port 5000 exposed and published so when you start the container and navigate to http://localhost:5000 you will see the message if you're successful.

- note that port 5000 is reserved in the more recent OSX versions (Monterey, Big Sur), so you have to use some other host port

Submit the Dockerfile.

_As in other exercises, do not alter the code of the project_

TIPS: 
- The project has install instructions in README.
- Note that the app starts to accept connections when "Accepting connections at http://localhost:5000" has been printed to the screen, this takes a few seconds.
- You do not have to install anything new outside containers.
- The project might not work with too new Node.js versions.

# Solution 💡

## 1. Check if port 5000 is in use:

On Linux and macOS:
```bash
sudo lsof -i :5000
```
On Windows:
```
netstat -ano | findstr :5000
```
If you get output from these commands, it means something is running on port 5000. The output will typically include the process ID (PID) of the process using the port.

In my case, my `5000` port is **occupied** so I will be using port `1000` instead.

_**Note**: If your port 1000 is not available you need to find the available port and use it instead of port 1000 during the exercise._

## 2. Copy relevant files:

```bash
./copy_project.sh
```

## 3. Build Docker image:

_**Note**: Be sure you are in the directory containing `Dockerfile`_

```bash
docker build . -t frontend-project
```

## 4. Run container:
    
```bash
docker run --rm -p 127.0.0.1:1000:5000 frontend-project
```

## 5. Check results:
Open your search engine (eg. Chrome) and type `http://127.0.0.1:1000`, you should see this:

![success](https://github.com/milistu/DevOpsWithDocker/blob/main/assets/exercise_1_12_output.png "Exercise 12 Output")
