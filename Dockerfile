FROM gitlab/gitlab-runner:latest
RUN curl -sSL https://get.docker.com/ | sh
RUN apt-get update && apt-get install docker-compose-plugin -y
RUN apt-get install make -y
WORKDIR /app
