# Utilisation d'une image Python légère et stable
FROM python:3.11-slim

# Empêche Python de générer des fichiers .pyc et assure un affichage direct des logs
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Installation des dépendances système (nécessaires pour OpenCV et PySyft)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libgl1-mesa-glx \
    libglib2.0-0 \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Définition du répertoire de travail
WORKDIR /app

# Mise à jour de pip
RUN pip install --no-cache-dir --upgrade pip

# Installation de PySyft et des outils de Data Science
# Note : On installe une version stable de PySyft
RUN pip install --no-cache-dir \
    syft==0.8.6 \
    torch \
    torchvision \
    pandas \
    scikit-learn \
    matplotlib \
    opencv-python-headless \
    jupyterlab

# Exposer les ports : 
# 8080 pour le serveur PySyft (Domain)
# 8888 pour Jupyter Lab (votre interface de code)
EXPOSE 8080 8888

# Commande par défaut : Lance Jupyter Lab au démarrage
# On désactive le token pour faciliter l'accès via Dokploy (sécurisez via Dokploy si besoin)
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''"]
