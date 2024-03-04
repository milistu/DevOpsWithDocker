# EXERCISE 3.1: YOUR PIPELINE 🤔
Create now a similar deployment pipeline for a simple NodeJS/Express app found [here](https://github.com/docker-hy/material-applications/tree/main/express-app).

Either clone the project or copy the files to your own repository. Set up similar deployment pipeline (or the "first half") using GitHub Actions that was just described. Ensure that a new image gets pushed to Docker Hub every time you push the code to GitHub (you may eg. change the message the app shows).

Note that there is importat change that you should make to the above workflow configuration, the branch should be named _main_:
```bash
name: Release NodeJS app

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      # ...
```
The earlier example still uses the old GitHub naming convention and calls the main branch _master_.

Some of the actions that the above example uses are a bit outdated, so go through the documentation

[actions/checkout](https://github.com/actions/checkout)
[docker/login-action](https://github.com/docker/login-action)
[docker/build-push-action](https://github.com/docker/build-push-action)
and use the most recent versions in your workflow.

Keep an eye on the GitHub Actions page to see that your workflow is working:
![Github Actions page](https://github.com/milistu/DevOpsWithDocker/blob/main/assets/exercise_3_1_input.png "Exercise 3.01 Input")

Ensure also from Docker Hub that your image gets pushed there.

Next, run your image locally in detached mode, and ensure that you can access it with the browser.

Now set up and run the [Watchtower](https://github.com/containrrr/watchtower) just as described above.

You might do these two in a single step in a shared Docker Compose file.

Now your deployment pipeline is set up! Ensure that it works:

- make a change to your code

- commit and push the changes to GitHub

- wait for some time (the time it takes for GitHub Action to build and push the image plus the Watchtower poll interval)

- reload the browser to ensure that Watchtower has started the new version (that is, your changes are visible)

Submit a link to the repository with the config.

# Solution 💡

## 1. Copy necessary files:
_**Note**: Be shure you are placed in directory `./part_3/exercise_01/`._

```bash
./copy_files.sh
```

## 1. Create a GitHub repo:
We are going to create a repo for NodeJS/Express app with code from [express-app]([here](https://github.com/docker-hy/material-applications/tree/main/express-app)). 

You can use [this](https://github.com/milistu/express-app) as a reference.

## 2. Create workflows:
We will create our deployment workflow using GitHub actions

```yaml
name: Release NodeJS app

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - 
        name: Login to Docker Hub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}
      - 
        name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3
        with:
          driver: docker-container
      - 
        name: Build and push
        uses: docker/build-push-action@v5
        with:
          push: True
          tags: studeni/express-app:latest
          platforms: linux/amd64,linux/arm64/v8
```

Main actions are:
- actions/checkout@v4 - used to check out the code from the repository
- docker/login-action@v3 - used to log in to Docker Hub

- docker/setup-buildx-action@v3 - ensure that Buildx uses the docker-container driver, which supports multi-platform builds
- docker/build-push-action@v5 - used to build the image and push it to Docker Hub

## 3. Ensure Image runs:

```bash
docker run -p 8080:8080 studeni/express-app
```

Open browser and enter http://localhost:8080 You should see "Hello World!" text.

## 4. Setup Watchtower:
We will create docker compose file to combine both our app and Watchtower.

```yaml
version: '3.8'

services:
  app:
    image: studeni/express-app
    ports:
      - 8080:8080
    
  watchtower:
    image: containrrr/watchtower
    environment:
      -  WATCHTOWER_POLL_INTERVAL=60 # Poll every 60 seconds
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    container_name: watchtower
```

## 5. Run docker compose:

```bash
docker compose up
```

## 6. Make changes:

We will now make changes to our express-app and push them to GitHub.

- In `index.js` you can change line 5 from "Hello World!" to "Hello Aliens!".

- Commit and push changes to GitHub. 

- We will need to wait for minut or two, first for GitHub actions to push our new image to hub and then for Watchtower to dowload and rebuild our new image. 

- Check your browser http://localhost:8080, you will see now "Hello Aliens! 👽 🛸"

---
### Complete solution can be found on [link](https://github.com/milistu/express-app).