FROM jenkins/jenkins:lts
USER root
RUN curl -O https://bootstrap.pypa.io/get-pip.py && python get-pip.py && pip install awscli
USER Jenkins
