#                                 __                 __
#    __  ______  ____ ___  ____ _/ /____  ____  ____/ /
#   / / / / __ \/ __ `__ \/ __ `/ __/ _ \/ __ \/ __  /
#  / /_/ / /_/ / / / / / / /_/ / /_/  __/ /_/ / /_/ /
#  \__, /\____/_/ /_/ /_/\__,_/\__/\___/\____/\__,_/
# /____                     matthewdavis.io, holla!
#
include .make/Makefile.inc

NS                  ?= default
APP                 ?= guacamole
MYSQL_HOSTNAME		?= mysql
MYSQL_DATABASE      ?= guacamole
MYSQL_USER          ?= guacamole
MYSQL_PASSWORD      ?= guacamole
export

## Find first pod and follow log output
logs:

	for i in {1..100}; do sleep 1; if ! kubectl --namespace $(NS) logs -f $(shell kubectl get pods --all-namespaces -lapp=$(APP) -o jsonpath='{.items[0].metadata.name}'); then exit 0; fi; done; exit 1

initdb:

	docker run --rm guacamole/guacamole /opt/guacamole/bin/initdb.sh --mysql > initdb.sql