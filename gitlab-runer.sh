#/bin/bash

echo step - $1
echo repository location - $2

if [[ -d "$DIRECTORY" ]]
then
    echo "$DIRECTORY exists on your filesystem."
fi


docker rm -fv gitlab-runner && \
docker volume create gitlab-volume && \
docker build . -t gitlab-runner-local && \
(docker run --rm \
 --name gitlab-runner \
 --entrypoint '' \
 -v /var/run/docker.sock:/var/run/docker.sock \
 -v $2:/app \
 -v $(pwd)/config:/etc/gitlab-runner \
 -v gitlab-volume:/app/builds \
 -ti \
 gitlab-runner-local bash -c "
 git config --global --add safe.directory /app \
  && cd /app && gitlab-runner exec shell $1") || \
docker volume rm gitlab-volume
