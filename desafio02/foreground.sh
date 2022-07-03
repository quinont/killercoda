echo "Preparando el esenario, por favor espere..."
while [ ! -f /tmp/finished ]; do sleep 1; echo "espere..."; done
echo DONE
