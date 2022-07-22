#!/bin/bash

for i in {1..5}; do
    curl host01:30000/mypath
    sleep 0.3
done

for i in {1..5}; do
    curl host01:31000/mypath
    sleep 0.3
done

