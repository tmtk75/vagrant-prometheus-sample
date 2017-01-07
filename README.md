# README

This repository provides an environment where prometheus and grafana are running on.
You can very easily launch it if you have vagrant 1.8.x.

```
                server
                 - prometheus
                 - grafana
                 - td-agent
                    |
                    |
       +------------+------------+
       |                         |
       v                         v
    client1                   client2
     - node_exporter            - node_exporter
     - nginx                    - nginx
     - td-agent                 - td-agent
```

## Getting started
Download ansible roles.
```
$ make setup
```

Just bring up all VMs. This basically may take several tens minutes (e.g: 15 minutes for me)
because it launches three VMs and downloads lots of components.
```
$ vagrant up
```
If you're failed, `vagrant up --provision [server|client1|client2]` or `vagrant provision [...]` work to fix.

Then type to open prometheus targets page.
```
$ make
```

## Sample requests
Generate sample requests.
```
$ make gen
```

## Running playbook
You can manually run playbooks if you need.

```
$ vagrant ssh-config > ssh-config
$ ansible-playbook server.yml -t grafana
```


## Discovery with consul
### Enable consul cluster
```
$ ansible-playbook consul.yml
...
$ ansible -m shell client -a "/usr/local/sbin/consul join 192.168.100.50"
```

### prometheus configuration
TBD


## Configured URLs
----
prometheus   | URL
-------------|--------------------------
server       | http://192.168.100.50:9090
alertmanager | http://192.168.100.50:9093


grafana   | URL
----------|--------------------------
dashboard | http://192.168.100.50:3000

grafana admin is `admin/admin`.


## Misc
* Default port allocations
  * https://github.com/prometheus/prometheus/wiki/Default-port-allocations


### Run fluentd as a foreground process
```
 /opt/td-agent/embedded/bin/fluentd -c /etc/td-agent/td-agent.conf  -v
```
