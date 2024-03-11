# EXERCISE 1.6: HELLO DOCKER HUB 🤔
Run `docker run -it devopsdockeruh/pull_exercise`.

The command will wait for your input.

Navigate through the [Docker hub](https://hub.docker.com/) to find the docs and Dockerfile that was used to create the image.

Read the Dockerfile and/or docs to learn what input will get the application to answer a "secret message".

Submit the secret message and command(s) given to get it as your answer.

# Solution 💡

## 1.  Pull and run `pull_exercise`:

```
docker run -it devopsdockeruh/pull_exercise
```

## 2. Find input from README on [Docker Hub](https://hub.docker.com/r/devopsdockeruh/pull_exercise):

Input = `basics`

## __*Secret message:*__

```bash
You found the correct password. Secret message is:
"This is the secret message"
```

## Cleanup 🧹
Fin out container name or ID:
```bash
docker ps -a
```
Remove the container with the command:
```bash
docker rm CONTAINER_ID_OR_NAME
```