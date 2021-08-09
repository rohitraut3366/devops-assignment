FROM centos


RUN yum install -y yum-utils git unzip epel-release java && \
    yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo && \
    yum -y install packer terraform ansible && \
    yum clean all 

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"  && \
    unzip awscliv2.zip  &&  \
    ./aws/install && \
    rm -rf awscliv2.zip

RUN pip3 install --no-cache-dir boto3 boto

CMD ["/bin/bash"]
