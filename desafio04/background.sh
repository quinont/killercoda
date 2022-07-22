#!/bin/bash

cat > /tmp/service1.yaml <<EOF
apiVersion: v1
kind: Service
metadata:
  labels:
    app: app1
  name: app1
spec:
  ports:
  - port: 80
    protocol: TCP
    targetPort: 80
    nodePort: 30000
  selector:
    layer: backend
  type: NodePort
EOF

cat > /tmp/service2.yaml <<EOF
apiVersion: v1
kind: Service
metadata:
  labels:
    app: app2
  name: app2
spec:
  ports:
  - port: 80
    protocol: TCP
    targetPort: 80
    nodePort: 31000
  selector:
    layer: backend
  type: NodePort
EOF

cat > /tmp/configmap1.yaml <<EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: configuracion1
data:
  default.conf: |
    server {
        listen 80 default_server;

        proxy_connect_timeout       3;
        proxy_send_timeout          3;
        proxy_read_timeout          3;
        send_timeout                3;

        location /mypath {
            access_log off;
            return 200 "app1\n";
        }

        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   /usr/share/nginx/html;
        }
    }
EOF

cat > /tmp/configmap2.yaml <<EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: configuracion2
data:
  default.conf: |
    server {
        listen 80 default_server;

        proxy_connect_timeout       3;
        proxy_send_timeout          3;
        proxy_read_timeout          3;
        send_timeout                3;

        location /mypath {
            access_log off;
            return 200 "app2\n";
        }

        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   /usr/share/nginx/html;
        }
    }
EOF

cat > /tmp/deploy1.yaml <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: app1
  name: app1
spec:
  replicas: 1
  selector:
    matchLabels:
      app: app1
  template:
    metadata:
      labels:
        app: app1
        layer: backend
    spec:
      volumes:
      - name: config
        configMap:
          name: configuracion1
      containers:
      - image: nginx
        name: backend
        volumeMounts:
        - name: config
          mountPath: /etc/nginx/conf.d/
EOF

cat > /tmp/deploy2.yaml <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: app2
  name: app2
spec:
  replicas: 1
  selector:
    matchLabels:
      app: app2
  template:
    metadata:
      labels:
        app: app2
        layer: backend
    spec:
      volumes:
      - name: config
        configMap:
          name: configuracion2
      containers:
      - image: nginx
        name: backend
        volumeMounts:
        - name: config
          mountPath: /etc/nginx/conf.d/
EOF

kubectl apply -f /tmp/configmap1.yaml
kubectl apply -f /tmp/deploy1.yaml
kubectl apply -f /tmp/service1.yaml

kubectl apply -f /tmp/configmap2.yaml
kubectl apply -f /tmp/deploy2.yaml
kubectl apply -f /tmp/service2.yaml

#kubectl wait --for=condition=ready pod nginx
sleep 5

touch /tmp/finished

