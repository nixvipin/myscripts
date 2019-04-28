apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: tomcat-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - http:
      paths:
      - path: /myapp
        backend:
          serviceName: tomcat-service
          servicePort: 8080
