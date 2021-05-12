FROM python:3.7
MAINTAINER Akhil Raj

RUN pip3 install boto3 && pip3 install requests
WORKDIR /opt/
ADD snapshot.py /opt/snapshot.py

ENTRYPOINT [ "python3", "snapshot.py" ]