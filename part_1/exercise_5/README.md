# EXERCISE 1.5: SIZES OF IMAGES 🤔
In the [Exercise 1.3](https://github.com/milistu/DevOpsWithDocker/blob/main/part_1/exercise_3/solution.md) we used `devopsdockeruh/simple-web-service:ubuntu`.

Here is the same application but instead of Ubuntu is using Alpine Linux: `devopsdockeruh/simple-web-service:alpine`.

Pull both images and compare the image sizes. Go inside the alpine container and make sure the secret message functionality is the same. Alpine version doesn't have bash but it has sh.

## Solution 💡

1. Pull both images:

    ```bash
    docker pull devopsdockeruh/simple-web-service:ubuntu
    docker pull devopsdockeruh/simple-web-service:alpine
    ```

2. Check images size:

    | **REPOSITORY** | **TAG** | **IMAGE ID** | **CREATED** | **SIZE** |
    | :---: | :---: | :---: | :---: | :---: |
    | devopsdockeruh/simple-web-service | ubuntu | 4e3362e907d5 | 2 years ago | `83MB` |
    | devopsdockeruh/simple-web-service | alpine | fd312adc88e0 | 2 years ago | `15.7MB` |

3. Create a container with `alpine`:

    ```bash
    docker run --rm -d -it --name secret-msg devopsdockeruh/simple-web-servic
    e:alpine
    ```

4. Access container with input privileges:

    ```bash
    docker exec -it secret-msg sh
    ```

5. Read "secret message":

    ```bash
    tail -f ./text.log
    ```

__*Secret message:*__

```bash
Secret message is: 'You can find the source code here: https://github.com/docker-hy'
2023-12-30 18:08:31 +0000 UTC
2023-12-30 18:08:33 +0000 UTC
2023-12-30 18:08:35 +0000 UTC
2023-12-30 18:08:37 +0000 UTC
2023-12-30 18:08:39 +0000 UTC
```