# Utilisation d'une image Python légère et stable
FROM python:3.11-slim

# Format corrigé pour ENV (key=value)
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Installation des dépendances système
# Remplacement de libgl1-mesa-glx par libgl1 (plus récent)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libgl1 \
    libglib2.0-0 \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Définition du répertoire de travail
WORKDIR /app

# Mise à jour de pip
RUN pip install --no-cache-dir --upgrade pip

# Installation de PySyft et des outils de Data Science
RUN pip install --no-cache-dir \
    syft==0.8.6 \
    torch \
    torchvision \
    pandas \
    scikit-learn \
    matplotlib \
    opencv-python-headless \
    jupyterlab

# Ports pour PySyft et Jupyter
EXPOSE 8080 8888

# Commande par défaut
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''"]