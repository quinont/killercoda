#!/bin/bash

cat > /tmp/service.yaml <<EOF
apiVersion: v1
kind: Service
metadata:
  name: be-furioso-svc
spec:
  selector:
    version: v15
  type: NodePort
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
      nodePort: 30000
EOF

cat > /tmp/configmap.yaml <<EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: proxypass-config
data:
  default.conf: |
    server {
        listen 80 default_server;

        proxy_connect_timeout       3;
        proxy_send_timeout          3;
        proxy_read_timeout          3;
        send_timeout                3;

        location /health {
            access_log off;
            return 200 "healthy\n";
        }

        location / {
            proxy_pass                      http://127.0.0.1:8080/mypath;
            proxy_http_version              1.1;
            proxy_pass_request_headers      on;
        }

        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   /usr/share/nginx/html;
        }
    }
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
      version: v15
  template:
    metadata:
      labels:
        app: be-furioso
        version: v15
    spec:
      volumes:
      - name: config
        configMap:
          name: proxypass-config
      containers:
      - image: nginx:1.23.0-alpine
        name: sidecard-proxy
        ports:
        - containerPort: 80
        readinessProbe:
          httpGet:
            path: /health
            port: 80
        livenessProbe:
          httpGet:
            path: /health
            port: 80
        volumeMounts:
        - name: config
          mountPath: "/etc/nginx/conf.d/"
      - image: quinont/resistrining:ej3
        name: furioso
        ports:
        - containerPort: 8080
EOF

kubectl apply -f /tmp/configmap.yaml
kubectl apply -f /tmp/deploy.yaml
kubectl apply -f /tmp/service.yaml

#kubectl wait --for=condition=ready pod nginx
sleep 5

touch /tmp/finished

for i in $(seq 500); do
    curl localhost:30000 -H "User-Agent: MyLegacy-App-3.0"
    sleep $[ ( $RANDOM % 4 )  + 1 ]s
done
