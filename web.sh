#!/bin/bash

# Script pour démarrer un serveur web avec Python3

# Fonction pour afficher l'aide
usage() {
    echo "Usage: $0 [-p port] [file]"
    echo "  -p port    Choisissez le port pour le serveur web (par défaut: 8080)"
    echo "  [file]     Fichier à servir (par défaut: répertoire courant)"
    exit 1
}

# Port par défaut
port=8080

# Analyser les options de la ligne de commande
while getopts "p:" opt; do
    case ${opt} in
        p )
            port=${OPTARG}
            ;;
        \? )
            usage
            ;;
    esac
done
shift $((OPTIND -1))

# Fichier ou répertoire à servir
target=${1:-$(pwd)}

# Vérifiez si Python 3 est installé
if ! command -v python3 &> /dev/null
then
    echo "Python3 n'est pas installé. Veuillez installer Python3 et réessayer."
    exit 1
fi

# Vérifiez si la cible existe
if [ ! -e "$target" ]; then
    echo "Le fichier ou répertoire spécifié n'existe pas: $target"
    exit 1
fi

# Démarrez le serveur web sur le port spécifié
echo "Démarrage du serveur web sur le port ${port} en servant $target..."
if [ -d "$target" ]; then
    # Si la cible est un répertoire, démarrez le serveur depuis ce répertoire
    cd "$target"
    python3 -m http.server ${port}
else
    # Si la cible est un fichier, démarrez le serveur et affichez le fichier
    python3 -m http.server ${port} &
    server_pid=$!
    sleep 1  # Attendez un moment pour démarrer le serveur
    xdg-open "http://localhost:${port}/${target}"
    wait $server_pid
fi

# Affichez un message lorsque le serveur est arrêté
echo "Le serveur web a été arrêté."
