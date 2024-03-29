# EXERCISE 1.1: GETTING STARTED 🤔
Since we already did "Hello, World!" in the material let's do something else.

Start 3 containers from an image that does not automatically exit (such as nginx) in detached mode.

Stop two of the containers and leave one container running.

Submit the output for `docker ps -a` which shows 2 stopped containers and one running.

# Solution 💡

## 1. Start 3 containers in detached mode:

```bash
docker run -d --name cont1 nginx
docker run -d --name cont2 nginx
docker run -d --name cont2 nginx
```

## 2. Stop 2 containers `cont1, cont2`:

```bash
docker stop cont1
docker stop cont2
```
## 3. Output for `docker ps -a`:

| **CONTAINER ID** | **IMAGE** | **COMMAND** | **CREATED** | **STATUS** | **PORTS** | **NAMES** |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| 86f9060736ca | nginx | "/docker-entrypoint.…" | About a minute ago | Up About a minute | 80/tcp | cont3 |
| 56e4a9b93eaa | nginx | "/docker-entrypoint.…" | About a minute ago | Exited (0) 20 seconds ago |  | cont2 |
| e12ac1be75c8 | nginx | "/docker-entrypoint.…" | 3 minutes ago | Exited (0) 22 seconds ago |  | cont1 |