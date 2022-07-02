#!/bin/bash

cat > /tmp/service.yaml <<EOF
apiVersion: v1
kind: Service
metadata:
  name: my-app
spec:
  selector:
    app: my-app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
EOF

cat > /tmp/deploy.yaml <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: my-app
  name: my-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
      - image: quinont/resistrining:ej1
        name: myapp
        ports:
        - containerPort: 8080
EOF

kubectl apply -f /tmp/deploy.yaml
kubectl apply -f /tmp/service.yaml

#kubectl wait --for=condition=ready pod nginx
sleep 5

touch /tmp/finished
