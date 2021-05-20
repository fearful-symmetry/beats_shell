#!/usr/bin/env bash

# initialize the env vars for elastic-package
# If not available, use some defaults
if $(docker ps | grep -q elastic-package-stack) ; then
    $(elastic-package stack shellinit)
else
    # system defaults
    export ELASTIC_PACKAGE_ELASTICSEARCH_USERNAME="elastic"
    export ELASTIC_PACKAGE_ELASTICSEARCH_PASSWORD="changeme"
    export ELASTIC_PACKAGE_ELASTICSEARCH_HOST="localhost:9200"
    export ELASTIC_PACKAGE_KIBANA_HOST="localhost:5601"
fi

# Elastic stack queries
KIB_API="curl -sS -u $ELASTIC_PACKAGE_ELASTICSEARCH_USERNAME:$ELASTIC_PACKAGE_ELASTICSEARCH_PASSWORD $ELASTIC_PACKAGE_KIBANA_HOST"

alias esup="curl -u $ELASTIC_PACKAGE_ELASTICSEARCH_USERNAME:$ELASTIC_PACKAGE_ELASTICSEARCH_PASSWORD $ELASTIC_PACKAGE_ELASTICSEARCH_HOST"
alias kibagents="$KIB_API/api/fleet/agent-status | python -m json.tool"

alias kibup="kib_status $ELASTIC_PACKAGE_KIBANA_HOST $ELASTIC_PACKAGE_ELASTICSEARCH_USERNAME $ELASTIC_PACKAGE_ELASTICSEARCH_PASSWORD"

# Run Test Fetch on the local Dir
alias tf="go test -v -tags=integrations -run TestFetch"

# Run Test Data on the local Dir
alias td="go test -v -data -run TestData"

alias beats="cd $HOME/go/src/github.com/elastic/beats"

alias ep="elastic-package"

# testv runs `testFetch` inside a list of supplied vagrant containers
# This assumes that A) we're in the directory of the metricset B) The vagrantbox is setup to develop beats, with go and the beats already setup.
function tfv () {
	box_list="$1"
    
    #grab the CWD
    to_test=$(go list -f '{{.Dir}}' | grep -o "go/.*")
    echo "=== Will run TestFetch on ${to_test}"
    vagrant up "${box_list}"
    _runtest "${box_list}" "cd ${to_test}; go test -v -tags=integrations -run TestFetch"

}

# Private wrapper functon to run a given test
func _runtest() {
    host="$1"
    cmd="$2"

    echo -e "=== Running "${new_cmd}" on ${host}"
    # Weird mishmash of single and double quotes needed to make this actually work
    vagrant ssh "${host}" --no-tty -c "bash -l -c '${cmd}'"
}