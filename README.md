# OKTA SCIM SERVER DOCKER COMPOSE

## Table of contents

[TOC]

---

## Description

This project is based on [okta-scim-flask-example](https://github.com/oktadev/okta-scim-flask-example) and the guidance of the Okta blog post [How to Build a Flask SCIM Server Configured for Use with Okta](https://developer.okta.com/blog/2021/09/01/flask-scim-server).
There are some issues with running the Flesk server in an environment with Python >3.11. As it's not easy to prepare an environment with the right version of Python and the relative dependencies, I prepared a Docker Compose in order to make very quick the startup of the SCIM Server.

---

## Quick instructions

Before run:
edit file `config/ngrok.yml` with the Authtoken (otherwise the ngrok session will be limited to 2 hours)

To start the SCIM Server, execute the following:

`make start`

The ngrok URL is outputted in the console after the startup.Then you can follow the instruction on [How to Build a Flask SCIM Server Configured for Use with Okta](https://developer.okta.com/blog/2021/09/01/flask-scim-server) to create and configure the application in Okta.

Remember that the free version of ngrok uses dynamic URLs, so at every execution of the server, the public URL will change and must be updated on the Okta configuration.

|URL |Description|
|-----------------------|-----------|
| http://localhost:8081 | ngrok console |
| http://localhost:8082 | Adminer (for checking the db content) |
| http://localhost:8083 | Okta Scim Server (for local debugging and testing) |

The Postgres data folder is saved in `data/postgresql` in order to make the db persistent. To start from scratch, delete the folder.

You can test the app by running:

`curl -XGET -H 'Authorization: Bearer 123456789' -H "Content-type: application/json" 'http://localhost:8084/scim/v2/Users'`

for localhost access, and:

`curl -XGET -H 'Authorization: Bearer 123456789' -H "Content-type: application/json" 'https://xyz.ngrok-free.app/scim/v2/Users'`

for public access (remember to change the ngrok URL with yours)

---

## Prerequisites

Docker and Docker Compose

---

## Usage

A Makefile is present in order to create some shortcuts for common operations.

Usage:

|Command |Description|
|-------------------|-----------|
|`make start` | Start docker-compose (in background)|
|`make stop` | Stop docker-compose |
|`make restart` | Restart docker-compose |
|`make start-logs` | Start docker-compose with logs |
|`make restart-logs`| Restart docker-compose with logs |
|`make logs` | Show the last 500 logs and start tail -f |
|`make build` | Rebuild all docker images |

---

## Notes
This project is only for testing purposes. No kind of security is implemented (i.e. PostgreSQL runs with trust authentication enabled)

---

## Folders
|Folder|Description|
|------|-----------|
|`okta-scim-server`| Custom docker images used in this project|
|`config`| Configuration file|

---

## Custom Images

### scim-server

---
