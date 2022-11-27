FROM python:3.11

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

RUN apt-get update && apt-get install libgeos-dev -y && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /tmp/requirements.txt

RUN pip install --no-cache-dir -r /tmp/requirements.txt && rm -rf /tmp/requirements.txt && useradd -U app_user && install -d -m 0755 -o app_user -g app_user /app/static

WORKDIR /app

USER app_user:app_user
COPY --chown=app_user:app_user .. .

RUN chmod +x docker/django/*.sh
ENTRYPOINT [ "docker/django/entrypoint.sh" ]
CMD [ "docker/django/start.sh" ]