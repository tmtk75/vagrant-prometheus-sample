##
prometheus:
	open http://192.168.100.50:9090/targets

grafana:
	open http://192.168.100.50:3000

##
curl:
	curl http://192.168.100.51:80

curl-proxy:
	curl http://192.168.100.51:9999

gen:
	(for e in `seq 1 100`; do \
	  curl -s 192.168.100.51:80; \
	  curl -s 192.168.100.52:9999; \
	  curl -s 192.168.100.52:80/foobar; done) > /dev/null

##
setup: roles/prometheus roles/grafana roles/grafana/templates/encoder roles/consul

roles/prometheus:
	git clone https://github.com/tmtk75/ansible-prometheus roles/prometheus

roles/grafana/templates/encoder: roles/grafana
	git clone https://github.com/picotrading/config-encoder-macros roles/grafana/templates/encoder

roles/grafana:
	git clone https://github.com/picotrading/ansible-grafana roles/grafana

roles/consul:
	git clone https://github.com/tmtk75/ansible-consul roles/consul

##
ssh-config: .vagrant/machines/server/virtualbox/id
	vagrant ssh-config > ssh-config

playbook:
	ansible-playbook server.yml -t prometheus

##
consul:
	ansible-playbook consul.yml
	ansible -m shell client -a "/usr/local/sbin/consul join 192.168.100.50"

