# EXERCISE 2.10 🤔
Now we have the reverse proxy up and running! All the communication to our app should be done through the reverse proxy and direct access (eg. accessing the backend with a GET to http://localhost:8080/ping ) should be prevented.

Use a port scanner, eg https://hub.docker.com/r/networkstatic/nmap to ensure that there are no extra ports open in the host.

It might be enough to just run

```bash
$ docker run -it --rm --network host networkstatic/nmap localhost
```
If you have an M1/M2 Mac, you might need to build the image yourself.

The result looks like the following (I used a self-built image):
```bash
$ docker run -it --rm --network host nmap localhost
Starting Nmap 7.93 ( https://nmap.org ) at 2023-03-05 12:28 UTC
Nmap scan report for localhost (127.0.0.1)
Host is up (0.0000040s latency).
Other addresses for localhost (not scanned): ::1
Not shown: 996 closed tcp ports (reset)
PORT     STATE    SERVICE
80/tcp   filtered http
111/tcp  open     rpcbind
5000/tcp filtered commplex-link
8080/tcp filtered http-proxy

Nmap done: 1 IP address (1 host up) scanned in 1.28 seconds
```
As we see, there are two suspicious open ports: 5000 and 8080. So it is obvious that the frontend and backend are still directly accessible in the host network. This should be fixed!

You are done when the port scan report looks something like this:
```bash
Starting Nmap 7.93 ( https://nmap.org ) at 2023-03-05 12:39 UTC
Nmap scan report for localhost (127.0.0.1)
Host is up (0.0000040s latency).
Other addresses for localhost (not scanned): ::1
Not shown: 998 closed tcp ports (reset)
PORT    STATE    SERVICE
80/tcp  filtered http
111/tcp open     rpcbind

Nmap done: 1 IP address (1 host up) scanned in 1.28 seconds
```
# Solution 💡

## 1. Copy the docker compose file and ndinx config from Exercise 2.9:
_**Note**: Be shure you are placed in directory `./part_2/exercise_10/`._

```bash
rsync -av --exclude='README.md' ../exercise_09/ ./
```

## 2. Run docker compose:
```bash
docker compose up
```

## 3. Check for open ports:
```docker
docker run -it --rm --network host networkstatic/nmap localhost
```
We have som additional ports open:
```bash
Starting Nmap 7.92 ( https://nmap.org ) at 2024-02-12 16:04 UTC
Nmap scan report for localhost (127.0.0.1)
Host is up (0.0000020s latency).
Other addresses for localhost (not scanned): ::1
Not shown: 995 closed tcp ports (reset)
PORT     STATE    SERVICE
80/tcp   filtered http
111/tcp  open     rpcbind
1000/tcp filtered cadlock
8080/tcp filtered http-proxy
8083/tcp filtered us-srv

Nmap done: 1 IP address (1 host up) scanned in 1.34 seconds
```

## 4. Stop containers:
```bash
docker compose down
```

## 5. Copy frontend and backend images:

We need to copy the files necessary to build our images and change them.
I created a neat script to do everything at once, just run the command:

```bash

```