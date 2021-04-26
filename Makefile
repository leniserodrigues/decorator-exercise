test:
	docker-compose run --rm test

lint:
	docker-compose run --rm lint

auto-correct:
	docker-compose run --rm auto-correct

run:
	docker-compose run --rm main
