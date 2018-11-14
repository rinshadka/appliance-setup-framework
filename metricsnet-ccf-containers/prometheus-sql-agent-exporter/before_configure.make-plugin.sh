#!/usr/bin/env bash

if [[ -f prometheus-sql-agent-exporter.ccf-tmpl-conf.jsonnet ]]; then
   mv prometheus-sql-agent-exporter.ccf-tmpl-conf.jsonnet $HOME/.ccf/etc/prometheus-sql-agent-exporter.ccf-conf.jsonnet
fi
