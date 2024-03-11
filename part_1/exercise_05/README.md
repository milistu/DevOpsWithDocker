# EXERCISE 1.5: SIZES OF IMAGES 🤔
In [Exercise](https://github.com/milistu/DevOpsWithDocker/blob/main/part_1/exercise_3/solution.md)[ 1.3](https://github.com/milistu/DevOpsWithDocker/blob/main/part_1/exercise_3/solution.md) we used `devopsdockeruh/simple-web-service:ubuntu`.

Here is the same application but instead of Ubuntu is using [Alpine Linux](https://www.alpinelinux.org/): `devopsdockeruh/simple-web-service:alpine`.

Pull both images and compare the image sizes. Go inside the Alpine container and make sure the secret message functionality is the same. Alpine version doesn't have bash but it has sh.

# Solution 💡

## 1. Pull both images:

```bash
docker pull devopsdockeruh/simple-web-service:ubuntu
docker pull devopsdockeruh/simple-web-service:alpine
```

## 2. Check image size:

```bash
docker images
```

| **REPOSITORY** | **TAG** | **IMAGE ID** | **CREATED** | **SIZE** |
| :---: | :---: | :---: | :---: | :---: |
| devopsdockeruh/simple-web-service | ubuntu | 4e3362e907d5 | 2 years ago | `83MB` |
| devopsdockeruh/simple-web-service | alpine | fd312adc88e0 | 2 years ago | `15.7MB` |

## 3. Create a container with `alpine`:

```bash
docker run --rm -d -it --name secret-msg devopsdockeruh/simple-web-servic
e:alpine
```

## 4. Access container with input privileges:

```bash
docker exec -it secret-msg sh
```

## 5. Read "secret message":

```bash
tail -f ./text.log
```

## __*Secret message:*__

```bash
Secret message is: 'You can find the source code here: https://github.com/docker-hy'
2024-03-11 17:21:19 +0000 UTC
2024-03-11 17:21:21 +0000 UTC
2024-03-11 17:21:23 +0000 UTC
2024-03-11 17:21:25 +0000 UTC
2024-03-11 17:21:27 +0000 UTC
```

## Cleanup 🧹
Exit the container with the command:
```bash
exit
```

Stop the container:
```bash
docker stop secret-msg
```