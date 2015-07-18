## Settings

MACHINE=dev
DB=database
SERVICE=web
PORT=8000
FILE=development
PROJECT = $(shell basename $(shell pwd) | tr -d "-" | tr -d " " | tr -d "_" | tr -d ".")


default:
	echo $(PROJECT)

## Machine commands

machine:
	docker-machine start $(MACHINE) || docker-machine create -d virtualbox $(MACHINE)

env:
	docker-machine env $(MACHINE)

ip:
	docker-machine ip $(MACHINE)


# Compose commands

build:
	docker-compose -p $(PROJECT) -f config/$(FILE).yml build $(SERVICE)

up:
	docker-compose -p $(PROJECT) -f config/$(FILE).yml up -d $(SERVICE)

start:
	docker-compose -p $(PROJECT) -f config/$(FILE).yml start $(SERVICE)

stop:
	docker-compose -p $(PROJECT) -f config/$(FILE).yml stop $(SERVICE)

rm:
	docker-compose -p $(PROJECT) -f config/$(FILE).yml rm $(SERVICE)

kill:
	docker-compose -p $(PROJECT) -f config/$(FILE).yml kill $(SERVICE)

logs:
	docker-compose -p $(PROJECT) -f config/$(FILE).yml logs $(SERVICE)

scale:
	docker-compose -p $(PROJECT) -f config/$(FILE).yml scale $(SERVICE)=$(INSTANCES)

ps:
	docker-compose -p $(PROJECT) -f config/$(FILE).yml ps

port:
	docker-compose -p $(PROJECT) -f config/$(FILE).yml port $(SERVICE) $(PORT)


# Django commands

app:
	docker exec -it $(PROJECT)_$(SERVICE)_1 mkdir applications/$(NAME)
	docker exec -it $(PROJECT)_$(SERVICE)_1 python manage.py startapp $(NAME) applications/$(NAME)

makemigrations:
	docker exec -it $(PROJECT)_$(SERVICE)_1 python manage.py makemigrations

migrate:
	docker exec -it $(PROJECT)_$(SERVICE)_1 python manage.py migrate

createsuperuser:
	docker exec -it $(PROJECT)_$(SERVICE)_1 python manage.py createsuperuser

collectstatic:
	docker exec -it $(PROJECT)_$(SERVICE)_1 python manage.py collectstatic --noinput


## Other commands

postgres:
	docker start postgresql || docker run --name postgresql -d postgres

psql:
	docker exec -i -t postgresql psql -U postgres $(DB)

createdb:
	docker exec -i -t postgresql psql -U postgres -c "CREATE DATABASE $(DB);"

dropdb:
	docker exec -i -t postgresql psql -U postgres -c "DROP DATABASE $(DB);"

clean:
	find . -name '*.DS_Store' -type f -delete
	find . -name '*.pyc' -type f -delete

open:
	open "http://$(shell docker-machine ip $(MACHINE)):$(PORT)"

shell:
	docker exec -it $(PROJECT)_$(SERVICE)_1 bash
