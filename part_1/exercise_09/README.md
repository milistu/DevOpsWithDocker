# EXERCISE 1.9: VOLUMES 🤔
In this exercise we won't create a new Dockerfile.

Image `devopsdockeruh/simple-web-service` creates a timestamp every two seconds to `/usr/src/app/text.log` when it's not given a command. Start the container with bind mount so that the logs are created into your filesystem.

Submit the command you used to complete the exercise.

__Hint:__ read the note that was made just before this exercise!

## Solution 💡

1. Create a `.log` file:

    ```bash
    touch text.log
    ```

2. Run container:

    ```bash
    docker run --rm -v "$(pwd)/text.log:/usr/src/app/text.log" devopsdockeruh/simple-web-service
    ```

__*Output:*__

```bash
2023-12-30 20:08:16 +0000 UTC
2023-12-30 20:08:18 +0000 UTC
2023-12-30 20:08:20 +0000 UTC
2023-12-30 20:08:22 +0000 UTC
2023-12-30 20:08:24 +0000 UTC

```