FROM ubuntu:20.04

RUN apt update && apt install -y curl

WORKDIR /usr/src/app

COPY script.sh .

RUN chmod +x script.sh

CMD ./script.sh

