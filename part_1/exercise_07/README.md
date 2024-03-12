# EXERCISE 1.7: IMAGE FOR SCRIPT 🤔
We can improve our previous solutions now that we know how to create and build a Dockerfile.

Let us now get back to [Exercise 1.4](https://github.com/milistu/DevOpsWithDocker/blob/main/part_1/exercise_4/solution.md).

Create a new file `script.sh` on your local machine with the following contents:

```bash
while true
do
  echo "Input website:"
  read website; echo "Searching.."
  sleep 1; curl http://$website
done
```

Create a Dockerfile for a new image that starts from _ubuntu:20.04_ and add instructions to install `curl` into that image. Then add instructions to copy the script file into that image and finally set it to run on container start using CMD.

After you have filled the Dockerfile, build the image with the name "curler".

- If you are getting permission denied, use `chmod` to give permission to run the script.

The following should now work:

```
$ docker run -it curler

  Input website:
  helsinki.fi
  Searching..
  <!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
  <html><head>
  <title>301 Moved Permanently</title>
  </head><body>
  <h1>Moved Permanently</h1>
  <p>The document has moved <a href="https://www.helsinki.fi/">here</a>.</p>
  </body></html>
  ```

Remember that [RUN](https://docs.docker.com/engine/reference/builder/#run) can be used to execute commands while building the image!

Submit the Dockerfile.

# Solution 💡

## 1. Create a `script.sh` and copy the code.
```bash
while true
do
  echo "Input website:"
  read website; echo "Searching.."
  sleep 1; curl http://$website
done
```

## 2. Create and populate the `Dockerfile`
```Dockerfile
FROM ubuntu:20.04

RUN apt update && apt install -y curl

WORKDIR /usr/src/app

COPY script.sh .

RUN chmod +x script.sh

CMD ./script.sh
```
## 3. Build a Docker image:

_**Note**: Be sure you are in the directory containing `Dockerfile`._
  
```bash
docker build . -t curler
```

## 4. Run container:

```bash
docker run -it --rm curler
```

## 5. Check results:
Input example URL:
```
helsinki.fi
```

_Output:_

```html
<html>
<head><title>301 Moved Permanently</title></head>
<body>
<center><h1>301 Moved Permanently</h1></center>
<hr><center>nginx/1.22.1</center>
</body>
</html>
```