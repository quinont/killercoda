#!/bin/bash

[[ $(kubectl get pod | wc -l) -eq "0" ]]
