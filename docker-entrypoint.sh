###
# credits: stefanprodan/swarmprom
###
#!/bin/sh -e

NODE_NAME=$(cat /etc/nodename)
echo "node_meta{node_id=\"$NODE_ID\", container_label_com_docker_swarm_node_id=\"$NODE_ID\", node_name=\"$NODE_NAME\"} 1" > /etc/node-exporter/node-meta.prom

set -- /bin/node_exporter "$@"

exec "$@"

# #!/bin/sh -e

# if [ -z ${HOST_HOSTNAME+x} ]; then
#   echo "Environment variable 'HOST_HOSTNAME' not set, we won't add the hostname metric."
# else
#   host_hostname=$(cat ${HOST_HOSTNAME})
#   echo "host{host=\"$host_hostname\", node=\"$(hostname)\"} 1" > /etc/node-exporter/host_hostname.prom
# fi

# # if command starts with an option, prepend node-exporter binary
# if [ "${1:0:1}" = '-' ]; then
#   set -- $NODE_EXPORTER_BIN "$@"
# fi

# exec "$@"
