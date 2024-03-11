# EXERCISE 1.2: CLEANUP 🤔
We have containers and an image that are no longer in use and are taking up space. Running `docker ps -as` and `docker image ls` will confirm this.

Clean the Docker daemon by removing all images and containers.

Submit the output for `docker ps -a` and `docker image ls`

# Solution 💡

## 1. Check containers `docker ps -as`:

| **CONTAINER ID** | **IMAGE** | **COMMAND** | **CREATED** | **STATUS** | **PORTS** | **NAMES** | **SIZE** |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| 86f9060736ca | nginx | "/docker-entrypoint.…" | 13 minutes ago | Up 13 minutes | 80/tcp | cont3 | 1.09kB |
| 56e4a9b93eaa | nginx | "/docker-entrypoint.…" | 13 minutes ago | Exited (0) 12 minutes ago |  | cont2 | 1.09kB |
| e12ac1be75c8 | nginx | "/docker-entrypoint.…" | 15 minutes ago | Exited (0) 12 minutes ago |  | cont1 | 1.09kB |

## 2. Check images `docker images`:

| **REPOSITORY** | **TAG** | **IMAGE ID** | **CREATED** | **SIZE** |
| :---: | :---: | :---: | :---: | :---: |
| nginx | latest | 8aea65d81da2 | 2 months ago |  192MB |

## 3. Stop running container:

```bash
docker stop cont3
```

## 4. Delete all containers that are not running:

```bash
docker container prune
```

## 5. Delete specific containers by NAME or ID:
```bash
docker rm cont1 cont2 cont3
```
## 6. Delete image:
```bash
docker rmi nginx
```

## The output of `docker ps -a`:

| **CONTAINER ID** | **IMAGE** | **COMMAND** | **CREATED** | **STATUS** | **PORTS** | **NAMES** | **SIZE** |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |

## The output of `docker images`:

| **REPOSITORY** | **TAG** | **IMAGE ID** | **CREATED** | **SIZE** |
| :---: | :---: | :---: | :---: | :---: |