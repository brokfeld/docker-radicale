FROM ubuntu:latest

EXPOSE 5232

WORKDIR /app


RUN mkdir data/collections -p

# /app/config
COPY config /app

# /app/data/users
COPY users /app/data

RUN apt update && apt upgrade -f -y

RUN apt install python3 python3-pip build-essential libffi-dev python3-dev apache2-utils -f -y

RUN python3 -m pip install --upgrade radicale
RUN python3 -m pip install --upgrade https://github.com/Unrud/RadicaleInfCloud/archive/master.tar.gz
RUN python3 -m pip install --upgrade radicale[bcrypt]

RUN adduser radicale
#RUN addgroup radicale
#RUN addgroup radicale radicale

HEALTHCHECK --interval=30s --retries=3 CMD curl --fail http://localhost:5232 || exit 1

COPY docker-entrypoint.sh /app
RUN chmod +x /app/docker-entrypoint.sh
ENTRYPOINT ["/app/docker-entrypoint.sh"]

CMD ["radicale", "--debug" , "--config", "/app/config"]
#CMD ["radicale", "--config", "/app/config"]


