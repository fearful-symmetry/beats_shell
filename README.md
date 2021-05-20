# Beats Shell

Common Scripts / aliases for beats development

## Install

Add the repo root to your path, and `source` the `beats_actions.sh` file.

```bash
export PATH=$HOME/beats_shell:$PATH
source $HOME/beats_shell/beats_actions.sh

```
## Commands

Many of the commands assume one is using `elastic-package` to manage a dev environment, If you're not, set the following env vars:

```
ELASTIC_PACKAGE_ELASTICSEARCH_USERNAME
ELASTIC_PACKAGE_ELASTICSEARCH_PASSWORD
ELASTIC_PACKAGE_ELASTICSEARCH_HOST
ELASTIC_PACKAGE_KIBANA_HOST
```

- `eprstat` : Query different EPR repos to see what repo is using a given version of a package. Example: `eprstat system`

- `kibagents` : View the agents attached to Kibana

- `kubup` : Check to see if Kibana is available

- `esup` : Check to see if Elasticsearch is available

- `tf` : run `TestFetch` tests inside a metricset

- `td` : run `TestData` tests inside a metricset

- `ep` : Alias for `elastic-package`
