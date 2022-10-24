# radicale-infcloud

```bash
# build and run
docker build . -t brokfeld/radicale-infcloud:latest
docker stop radicale-infcloud
docker rm radicale-infcloud
docker run \
  -d \
  --name radicale-infcloud \
  -p 5232:5232 \
  --restart unless-stopped \
  brokfeld/radicale-infcloud:latest


# create user
docker exec -it radicale-infcloud /bin/bash
htpasswd -B -c /app/data/users username1
```