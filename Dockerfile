FROM ubuntu:22.04

EXPOSE 5232

## 01 set work dir
WORKDIR /app

## 02 make dirs
RUN mkdir data/collections -p

## 03 copy configuration file
COPY config /app

## 04 create empty users file
RUN echo "" > /app/data/users

## 05 install dependencies
RUN apt update && apt upgrade -f -y
RUN apt install python3 python3-pip apache2-utils -f -y

## 06 install radicale
RUN python3 -m pip install --upgrade radicale===3.1.8

## 07 add user for execution
RUN adduser radicale --system

## 08 healthcheck
HEALTHCHECK --interval=30s --retries=3 CMD curl --fail http://localhost:5232 || exit 1

## 09 entrypoint
COPY docker-entrypoint.sh /app
RUN chmod +x /app/docker-entrypoint.sh
ENTRYPOINT ["/app/docker-entrypoint.sh"]

## 10 start radicale
#CMD ["radicale", "--debug" , "--config", "/app/config"]
CMD ["radicale", "--config", "/app/config"]


