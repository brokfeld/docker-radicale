FROM ubuntu:latest

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
#RUN python3 -m pip install --upgrade radicale
RUN python3 -m pip install --upgrade https://github.com/Kozea/Radicale/archive/refs/heads/master.zip 
#https://github.com/Kozea/Radicale/archive/master.tar.gz

## 07 healthcheck
HEALTHCHECK --interval=30s --retries=3 CMD curl --fail http://localhost:5232 || exit 1

## 08 entrypoint
COPY docker-entrypoint.sh /app
RUN chmod +x /app/docker-entrypoint.sh
ENTRYPOINT ["/app/docker-entrypoint.sh"]

## 09 start radicale
#CMD ["radicale", "--debug" , "--config", "/app/config"]
CMD ["radicale", "--config", "/app/config"]


