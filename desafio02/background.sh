#!/bin/bash

cat > /tmp/service.yaml <<EOF
apiVersion: v1
kind: Service
metadata:
  name: be-furioso-svc
spec:
  selector:
    version: be-furioso
  type: NodePort
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
      nodePort: 30000
EOF

cat > /tmp/deploy.yaml <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: be-furioso
  name: be-furioso
spec:
  replicas: 3
  selector:
    matchLabels:
      app: be-furioso
      version: v12
  template:
    metadata:
      labels:
        app: be-furioso
        version: v12
    spec:
      containers:
      - image: quinont/resistrining:ej2
        name: furioso
        ports:
        - containerPort: 8080
EOF

kubectl apply -f /tmp/deploy.yaml
kubectl apply -f /tmp/service.yaml

#kubectl wait --for=condition=ready pod nginx
sleep 5

touch /tmp/finished
