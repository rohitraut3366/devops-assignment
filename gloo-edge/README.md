# Gloo-Edge Experiment

- Configure [Gloo Edge](https://docs.solo.io/gloo-edge/latest/getting_started/) Gateway in minikube
- Create an Application and containerization: Here I have given a simple flask application, and I will be using the same for demonstration.
Dockerfile
```
FROM centos
RUN yum install python36 -y
RUN pip3 install flask
COPY app.py .
EXPOSE 5000
CMD ["python3", "app.py"]
```

- Create Deployment and Expose 
```
kubectl create deployment basic-flask --image=rohitraut3366/flask-basic:v2
kubectl expose deployment basic-flask --type=ClusterIP --port=5000
```
Gloo-Edge continuously monitoring all services in clusters, and it creates upstream(end service)
`glooctl get upstream`

<img src="https://raw.githubusercontent.com/rohitraut3366/devops-assignment/master/gloo-edge/Images/img1.png" alt="Image" style="float: left; margin-right: 10px;" />