#! /bin/bash

sudo docker run --rm -d -u root --name jenkins-container -p 8080:8080 -p 50000:50000 -v ~/jenkins-data:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock -v "$HOME":/home jenkinsci/blueocean