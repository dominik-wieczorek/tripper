FROM python:3.11
ENV PYTHONUNBUFFERED 1
WORKDIR /app
ADD . ./app
RUN apt-get update && apt-get install libgeos-dev -y
RUN pip install -r ./app/requirements.txt