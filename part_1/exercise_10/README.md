# EXERCISE 1.10: PORTS OPEN 🤔
In this exercise, we won't create a new Dockerfile.

The image `devopsdockeruh/simple-web-service` will start a web service in port `8080` when given the argument "server". In [Exercise 1.8](https://github.com/milistu/DevOpsWithDocker/tree/main/part_1/exercise_8) you already did a image that can be used to run the web service without any argument.

Use now the -p flag to access the contents with your browser. The output to your browser should be something like: `{ message: "You connected to the following path: ...`

Submit your used commands for this exercise.

## Solution 💡

1. Build Docker image:

    _**Note**: Be shure you are in directory containing `Dockerfile`_

    ```bash
    docker build . -t web-server
    ```

2. Run container:
    
    ```bash
    docker run -p 127.0.0.1:1000:8080 web-server
    ```

3. Open you search engine (eg. Chrome) and type `127.0.0.1:1000`

__*Output:*__

```
{"message":"You connected to the following path: /","path":"/"}
```