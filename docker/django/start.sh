cd /app
gunicorn tripper.wsgi --bind 0.0.0.0:8000