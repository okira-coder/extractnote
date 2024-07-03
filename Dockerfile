# Utilisez l'image de base Python
FROM python:3.9

# Installer les dépendances nécessaires pour PyMuPDF
RUN apt-get update && apt-get install -y \
    gcc \
    build-essential \
    libmupdf-dev \
    mupdf-tools \
    libfreetype6-dev \
    libjpeg-dev \
    libopenjp2-7-dev \
    libtiff5-dev \
    libmujs-dev \
    python3-dev

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copiez le fichier requirements.txt dans le conteneur
COPY requirements.txt .

# Installez les dépendances Python
RUN pip install --no-cache-dir -r requirements.txt

# Copiez le code source de l'application dans le conteneur
COPY . .

# Exposez le port sur lequel l'application s'exécute
EXPOSE 8000

# Commande pour exécuter l'application avec uvicorn
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
