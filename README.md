# docker-radicale

```bash
# build and run
docker build . -t brokfeld/radicale:latest
docker stop radicale && docker rm radicale
docker run \
  -d \
  --name radicale \
  -p 5232:5232 \
  --restart unless-stopped \
  brokfeld/radicale:latest


# create user
docker exec -it radicale /bin/bash
htpasswd -B -c /app/data/users username1
```

## compose

```yaml
services:
  radicale:
    image: brokfeld/radicale:latest
    container_name: radicale
    restart: unless-stopped
    ports:
      - 5232:5232
    volumes:
      - ./data:/app/data:rw
```

```bash
docker compose up -d
```