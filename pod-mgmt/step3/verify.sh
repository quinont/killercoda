#!/bin/bash

[[ $(kubectl get pod nginx-yaml -o jsonpath='{.spec.containers[0].image}') == "nginx:1.23.0" ]]
