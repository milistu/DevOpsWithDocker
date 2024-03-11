# EXERCISE 1.3: SECRET MESSAGE 🤔
Now that we've warmed up it's time to get inside a container while it's running!

Image `devopsdockeruh/simple-web-service:ubuntu` will start a container that outputs logs into a file. Go inside the container and use `tail -f ./text.log` to follow the logs. Every 10 seconds the clock will send you a "secret message".

Submit the secret message and command(s) given as your answer.

# Solution 💡

## 1. Create a container:

```bash
docker run -d --name web-service devopsdockeruh/simple-web-service:ubuntu
```
    
## 2. Access container with input privileges

```bash
docker exec -it web-service bash
```

## 3. Read "secret message": 

```bash
tail -f ./text.log
```

## __*Secret message:*__

```bash
2024-03-11 16:55:57 +0000 UTC
Secret message is: 'You can find the source code here: https://github.com/docker-hy'
2024-03-11 16:55:59 +0000 UTC
2024-03-11 16:56:01 +0000 UTC
2024-03-11 16:56:03 +0000 UTC
2024-03-11 16:56:05 +0000 UTC
2024-03-11 16:56:07 +0000 UTC
```

## Cleanup 🧹
```bash
docker stop web-service
```