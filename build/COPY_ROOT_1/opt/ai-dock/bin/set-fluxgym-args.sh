#!/bin/bash

echo "$@" > /etc/fluxgym_args.conf
supervisorctl restart fluxgym