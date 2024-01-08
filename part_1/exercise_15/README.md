# EXERCISE 1.15: HOMEWORK 🤔
Create Dockerfile for an application or any other dockerised project in any of your own repositories and publish it to Docker Hub. This can be any project, except the clones or forks of backend-example or frontend-example.

For this exercise to be complete you have to provide the link to the project in Docker Hub, make sure you at least have a basic description and instructions for how to run the application in a [README](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-readmes) that's available through your submission.

## Solution 💡

The `simple-backend` is the solution for this exercise,  just change into project directory and follow the README.
```bash
cd simple-backend
```

### 🐳 DockerHub

You can run this project direct from [DockerHub](https://hub.docker.com/repository/docker/studeni/simple-backend/general), to fast check how everything works:

_**Note**: First check if your port 1000 is occupied._
```bash
docker run --rm -it -e PORT=1000 -p 127.0.0.1:1000:1000 studeni/simple-backend:small
```