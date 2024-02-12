# EXERCISE 2.8 🤔
Add [Nginx](https://hub.docker.com/_/nginx) to example to work as a [reverse proxy](https://en.wikipedia.org/wiki/Reverse_proxy) in front of the example app frontend and backend. According to Wikipedia

_A reverse proxy is a type of proxy server that retrieves resources on behalf of a client from one or more servers. These resources are then returned to the client, appearing as if they originated from the reverse proxy server itself._

![Input](https://github.com/milistu/DevOpsWithDocker/blob/main/assets/exercise_2_8_input.png "Exercise 2.08 Input")

So in our case, the reverse proxy will be the single point of entry to our application, and the final goal will be to set both the React frontend and the Express backend behind the reverse proxy.

The idea is that browser makes _all_ requests to _http://localhost_. If the request has a url prefix _http://localhost/api_, Nginx should forward the request to the backend container. All the other requests are directed the frontend container.

So, at the end you should see that the frontend is accessible simply by going to http://localhost. All buttons, except the one labelled _Exercise 2.8_ may have stopped working, do not worry about them, we shall fix that later.

The following file should be set to `/etc/nginx/nginx.conf` inside the nginx container. You can use a file bind mount where the contents of the file is the following:
```bash
events { worker_connections 1024; }

http {
  server {
    listen 80;

    location / {
      proxy_pass _frontend-connection-url_;
    }

    # configure here where requests to http://localhost/api/...
    # are forwarded
    location /api/ {
      proxy_set_header Host $host;
      proxy_pass _backend-connection-url_;
    }
  }
}
```
Nginx, backend and frontend should be connected in the same network. See the image above for how the services are connected. You find [Nginx-documentation](https://www.nginx.com/resources/wiki/start/topics/examples/full/) helpful, but remember, the configuration you need is pretty straight forward, if you end up doing complex things, you are most likely doing something wrong.

If and when your app "does not work", remember to have a look in log, it can be pretty helpful in pinpointing errors:
```bash
2_7-proxy-1  | /docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
2_7-proxy-1  | /docker-entrypoint.sh: Configuration complete; ready for start up
2_7-proxy-1  | 2023/03/05 09:24:51 [emerg] 1#1: invalid URL prefix in /etc/nginx/nginx.conf:8
2_7-proxy-1 exited with code 1
```
Submit the docker-compose.yml

# Solution 💡

## 1. Copy the docker compose file from Exercise 2.6:
_**Note**: Be shure you are placed in directory `./part_2/exercise_08/`._

```bash
cp ../exercise_06/docker-compose.yml docker-compose.yml
```

## 2. Make nginx config file:
```bash
touch nginx.conf
```
After creating config file paste the content from exercise with right url's for frontend and backend.
```bash
events { worker_connections 1024; }

http {
  server {
    listen 80;

    location / {
      proxy_pass http://frontend:1000/;
    }

    location /api/ {
      proxy_set_header Host $host;
      proxy_pass http://backend:8080/;
    }
  }
}
```

## 3. Add bind mount to database `docker-compose.yml`:
```docker
  proxy:
    image: nginx:alpine
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
    ports:
      - 80:80
    depends_on:
      - backend
      - frontend
    container_name: nginx
```

## 5. Run docker compose:
```bash
docker compose up
```

## Check the output:
Open you search engine (eg. Chrome) and type `http://127.0.0.1` (or `http://localhost/`), you should see this when you press the button:

![success](https://github.com/milistu/DevOpsWithDocker/blob/main/assets/exercise_2_8_output.png "Exercise 2.08 Output")
