# Utiliser une image de base officielle de Python
FROM python:3

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copier les fichiers de requirements dans le répertoire de travail
COPY requirements.txt /app/

# Installer les dépendances Python
RUN pip install --no-cache-dir -r requirements.txt

# Copier le reste du code de l'application dans le répertoire de travail
COPY . /app/

# Exposer le port que l'application utilisera
EXPOSE 8000

VOLUME [ "/app/logs" ]


# Définir la commande par défaut pour exécuter l'application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]