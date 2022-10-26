# docker-radicale

GitHub Actions builds, based on this repository, every month the latest version from master branch of
[https://github.com/Kozea/Radicale](https://github.com/Kozea/Radicale) on
[Docker Hub](https://hub.docker.com/repository/docker/brokfeld/radicale)

## Getting started

### docker

```bash
# start container
docker run \
  -d \
  --name radicale \
  -p 5232:5232 \
  --env USER_UID=$(id -u $USER) \
  --env USER_GID=$(id -g $USER) \
  --volume=data:/app/data:rw \
  --restart unless-stopped \
  brokfeld/radicale:latest

# create a user
docker exec -it radicale /bin/bash
htpasswd -B -c /app/data/users username1

# stop container
docker stop radicale 

# remove container
docker rm radicale
```

### compose

```bash
# create .env file
echo "UID=$(id -u $USER)" > .env && echo "GID=$(id -g $USER)" >> .env
```

```yaml
# create compose.yaml
services:
  radicale:
    image: brokfeld/radicale:latest
    container_name: radicale
    restart: unless-stopped
    environment:
      - USER_UID=${USER_UID}
      - USER_GID=${USER_GID}
    ports:
      - 5232:5232
    volumes:
      - ./data:/app/data:rw
```

```bash
# create a user
docker exec -it radicale /bin/bash
htpasswd -B -c /app/data/users username1
```

```bash
# start
docker compose up -d

# stop
docker compose down

# logs
docker compose logs

# update image
docker compose down && docker compose pull && docker compose up -d
```

## License

[GPL-3.0](LICENSE)
