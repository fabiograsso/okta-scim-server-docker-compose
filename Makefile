.PHONY: start stop restart logs build start-logs restart-logs

start :
	@docker-compose up -d
	@sleep 10
	@bash -c "/usr/bin/curl -s http://localhost:5001/api/tunnels | grep -o '\"public_url\": *\"[^\"]*\"' | grep -o 'https:\/\/[^\"]*'"
	@bash -c "echo -e '\n\n'"

stop :
	@docker-compose down

restart : stop start

logs :
	@docker-compose logs -f --tail=500

build :
	@docker-compose build  --no-cache --parallel --pull --force-rm

start-logs : start logs

restart-logs : restart logs
