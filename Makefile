DOCKER_IP = $(shell boot2docker ip 2>/dev/null)

all: dev

dev:
	@echo "Please make sure that you've run \"boot2docker up\" manually"
	fig up -d db
	@echo $(DOCKER_IP)
	(export DOCKER_IP=$(DOCKER_IP) && grunt serve)




