kind: Service
apiVersion: v1
metadata:
  name: tomcat-service
spec:
  selector:
    app: tomcat
  ports:
  - protocol: TCP
    port: 8080
    targetPort: 8080
