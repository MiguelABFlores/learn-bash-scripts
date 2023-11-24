#!/bin/bash

# Configuration
echo "Enter the GitLab Runner name: "
read -r GITLAB_RUNNER_NAME
echo "Enter the GitLab URL: " 
read -r GITLAB_URL
echo "Enter the registration token: "
read -r REGISTRATION_TOKEN
TAG_LIST="docker"
DOCKER_IMAGE="docker:stable"
DOCKER_VOLUMES="/var/run/docker.sock:/var/run/docker.sock"

# Register the GitLab Runner
docker run --rm -v /var/folders/gitlab-runner/config:/etc/gitlab-runner gitlab/gitlab-runner register \
  --non-interactive \
  --name "$GITLAB_RUNNER_NAME" \
  --url "$GITLAB_URL" \
  --registration-token "$REGISTRATION_TOKEN" \
  --tag-list "$TAG_LIST" \
  --executor "docker" \
  --docker-image "$DOCKER_IMAGE" \
  --docker-volumes "$DOCKER_VOLUMES" \
  --docker-privileged

# Start the GitLab Runner
docker run -d --name gitlab-runner --restart always \
  -v /var/folders/gitlab-runner/config:/etc/gitlab-runner \
  -v /var/run/docker.sock:/var/run/docker.sock \
  gitlab/gitlab-runner:latest

echo "GitLab Runner has been created and started successfully."
