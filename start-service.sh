#!/bin/bash

sudo su
docker node update --availability drain master
docker service create --name web-server --replicas 10 -p 80:80 httpd