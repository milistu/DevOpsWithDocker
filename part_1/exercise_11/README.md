# EXERCISE 1.11: SPRING 🤔
Create a Dockerfile for an old Java Spring project that can be found from the [course repository](https://github.com/docker-hy/material-applications/tree/main/spring-example-project).

The setup should be straightforward with the README instructions. Tips to get you started:

Use [openjdk image](https://hub.docker.com/_/openjdk) `FROM openjdk:_tag_` to get Java instead of installing it manually. Pick the tag by using the README and Docker Hub page.

You've completed the exercise when you see a 'Success' message in your browser.

Submit the Dockerfile you used to run the container.

## Solution 💡

_**Note:** Our repository includes the "material-applications/spring-example-project" as a sub-module. To incorporate these files into our container, we need to first transfer them to our exercise directory. This step is crucial because Docker can only copy files from the build context, which is typically the directory containing the Dockerfile and its subdirectories._<br>
You can achieve this by initiating the docker build from the project's root, manually copying the files, or using a script to automate this process. We'll provide a script to facilitate the file copying, but feel free to adopt any method that suits your workflow best.


1. Copy relevant files:

    ```bash
    ./copy_project.sh
    ```

2. Build Docker image:

    _**Note**: Be shure you are in directory containing `Dockerfile`_

    ```bash
    docker build . -t spring-project
    ```

3. Run container:
    
    ```bash
    docker run -p 127.0.0.1:1000:8080 spring-project
    ```

4. Open you search engine (eg. Chrome) and type `http://127.0.0.1:1000`, you should see this when you press the button:

    ![success](https://github.com/milistu/DevOpsWithDocker/blob/main/assets/exercise_11_output.png "Exercise 11 Output")

5. After we verified that everything works we can now delete the "spring-example-project" so we don't waste space:
    ```bash
    rm -r spring-example-project
    ```