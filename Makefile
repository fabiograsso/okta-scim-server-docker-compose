.PHONY: start stop restart logs build start-logs restart-logs

start :
	@docker-compose up -d
	@sleep 5
	@bash -c "echo -e '\nngrok URL:\n'"
	@bash -c "/usr/bin/curl -s http://localhost:8081/api/tunnels | grep -o '\"public_url\": *\"[^\"]*\"' | grep -o '\"[^\"]*\"$$' | sed -e 's/^\"//' -e 's/\"$$//'"
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
