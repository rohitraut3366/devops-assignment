FROM centos

RUN yum install python36 -y

RUN pip3 install flask

COPY app.py .

EXPOSE 5000

CMD ["python3", "app.py"]