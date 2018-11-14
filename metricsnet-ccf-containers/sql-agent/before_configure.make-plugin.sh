#!/usr/bin/env bash

if [[ -f sql-agent.ccf-tmpl-conf.jsonnet ]]; then
   mv sql-agent.ccf-tmpl-conf.jsonnet $HOME/.ccf/etc/sql-agent.ccf-conf.jsonnet
fi
