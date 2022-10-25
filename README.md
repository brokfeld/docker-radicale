# docker-radicale

```bash
## 01 build
docker build . -t brokfeld/radicale:latest

## 02 stop and remove a old container
docker stop radicale && docker rm radicale

## 03 start container
docker run \
  -d \
  --name radicale \
  -p 5232:5232 \
  --env USER_UID=$(id -u $USER) \
  --env USER_GID=$(id -g $USER) \
  --volume=data:/app/data:rw \
  --restart unless-stopped \
  brokfeld/radicale:latest

## create a user
docker exec -it radicale /bin/bash
htpasswd -B -c /app/data/users username1
```

## compose

```bash
## 01 create .env file
echo "UID=$(id -u $USER)" > .env && echo "GID=$(id -g $USER)" >> .env
```

```yaml
## 02 create compose.yaml
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
## create a user
docker exec -it radicale /bin/bash
htpasswd -B -c /app/data/users username1

# start
docker compose up -d

# stop
docker compose down

# logs
docker compose logs

# update image
docker compose down && docker compose pull && docker compose up -d
```
