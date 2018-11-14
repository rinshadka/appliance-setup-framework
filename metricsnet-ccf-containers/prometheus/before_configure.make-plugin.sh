#!/usr/bin/env bash

if [[ -f prometheus.ccf-tmpl-conf.jsonnet ]]; then
   mv prometheus.ccf-tmpl-conf.jsonnet $HOME/.ccf/etc/prometheus.ccf-conf.jsonnet
fi
