# EXERCISE 1.4: MISSING DEPENDENCIES 🤔
Start a Ubuntu image with the process `sh -c 'while true; do echo "Input website:"; read website; echo "Searching.."; sleep 1; curl http://$website; done'`

If you're on Windows, you'll want to switch the `'` and `"` around: `sh -c "while true; do echo 'Input website:'; read website; echo 'Searching..'; sleep 1; curl http://$website; done"`.

You will notice that a few things required for proper execution are missing. Be sure to remind yourself which flags to use so that the container actually waits for input.

> Note also that curl is NOT installed in the container yet. You will have to install it from inside of the container.

Test inputting `helsinki.fi` into the application. It should respond with something like

```html
<html>
  <head>
    <title>301 Moved Permanently</title>
  </head>

  <body>
    <h1>Moved Permanently</h1>
    <p>The document has moved <a href="http://www.helsinki.fi/">here</a>.</p>
  </body>
</html>
```

This time return the command you used to start the process and the command(s) you used to fix the ensuing problems.

**Hint** for installing the missing dependencies you could start a new process with `docker exec`.

- This exercise has multiple solutions, if the curl for helsinki.fi works then it's done. Can you figure out other (smart) solutions?

# Solution 💡
## Create a container:

```bash
docker run -it --rm --name miss-dep ubuntu sh -c 'apt update && apt install -y curl;  while true; do echo "Input website:"; read website; echo "Searching.."; sleep 1; curl http://$website; done'
```

_**Note**: We added `apt update && apt install -y curl;` in our command to fix the missing dependency issue._

## Output for example url `helsinki.fi`:

```html
<html>
<head><title>301 Moved Permanently</title></head>
<body>
<center><h1>301 Moved Permanently</h1></center>
<hr><center>nginx/1.22.1</center>
</body>
</html>
```