# Image de base légère avec Python
FROM python:3.10-slim

LABEL org.opencontainers.image.title="mini-ci-cd-flask" \
      org.opencontainers.image.source="https://github.com/AmielDylan/mini-ci-cd-flask.git" \
      org.opencontainers.image.version="0.1.0"

# Bonnes pratiques Python
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Utilisateur non-root
RUN useradd -m appuser
WORKDIR /app

# Copier les dependances puis installer 
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

# Copier le code de la racine dans /app
COPY --chown=appuser:appuser . /app

# Exposer le port de l’app
EXPOSE 5000

# Passer en utilisateur non-root pour exécuter l'app
USER appuser

# Commande de démarrage
CMD ["python", "app.py"]