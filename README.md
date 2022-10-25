# docker-radicale

```bash
# build and run
docker build . -t brokfeld/radicale:latest
docker stop radicale && docker rm radicale
docker run \
  -d \
  --name radicale \
  -p 5232:5232 \
  --env USER_UID=$(id -u $USER) \
  --env USER_GID=$(id -g $USER) \
  --volume=data:/app/data:rw \
  --restart unless-stopped \
  brokfeld/radicale:latest


# create user
docker exec -it radicale /bin/bash
htpasswd -B -c /app/data/users username1
```

## compose

```bash
# create .env file
echo "UID=$(id -u $USER)" > .env && echo "GID=$(id -g $USER)" >> .env
```

```yaml
# compose.yaml
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
# start
docker compose up -d

# stop
docker compose down

# logs
docker compose logs

# update image
docker compose down && docker compose pull && docker compose up -d
```
