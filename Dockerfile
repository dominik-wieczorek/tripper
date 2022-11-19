FROM python:3.11
ENV PYTHONUNBUFFERED 1
WORKDIR /app
ADD . ./app
RUN pip install -r ./app/requirements.txt