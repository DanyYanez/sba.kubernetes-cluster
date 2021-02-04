# Image with python to deploy de flask app
FROM python:3.7-alpine
WORKDIR /sba.kubernetes-cluster

# Copy all the files in the repo
ADD . /sba.kubernetes-cluster

# Installing requirements.txt
RUN pip install -r requirements.txt

# The aplication will be run in port 80
EXPOSE 80

# Command to run the app
CMD ["python","web.py"]
