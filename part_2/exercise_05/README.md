# EXERCISE 2.5 🤔
The project https://github.com/docker-hy/material-applications/tree/main/scaling-exercise is a barely working application. Go ahead and clone it for yourself. The project already includes docker-compose.yml so you can start it by running `docker compose up`.

The application should be accessible through http://localhost:3000. However, it doesn't work well enough and I've added a load balancer for scaling. Your task is to scale the `compute` containers so that the button in the application turns green.

This exercise was created with [Sasu Mäkinen](https://github.com/sasumaki)

Please return the used commands for this exercise.

# Solution 💡

## 1. Copy necessary files:
_**Note**: Be sure you are placed in the directory `./part_2/exercise_05/`._

```bash
./copy_files.sh
```

## 2. Change directory:

```bash
cd scaling-exercise 
```

## 3. Run the docker-compose and find the right scaling compute parameter:
```bash
docker compose up --scale compute=2
``` 

## Check the output:
Open your search engine (eg. Chrome) and type `http://127.0.0.1:3000`.
Press the button to test if your number of compute units is sufficient.

_**Note**: Your aim is to get the **bottom** bar to fill before the **first** depletes!_

When you have the right number of compute units the button will change color to green:

![success](https://github.com/milistu/DevOpsWithDocker/blob/main/assets/exercise_2_5_output.png "Exercise 2.05 Output")

## Cleanup 🧹
Remove docker containers:
```bash
docker compose down
```