#!/bin/bash

[[ $(kubectl get pod nginx-yaml -o jsonpath='{.metadata.labels.creado-con}') == "yaml" ]]
