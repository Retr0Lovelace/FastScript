# Web

`web` est un script Bash pour démarrer un serveur web simple en utilisant Python 3. Il vous permet de servir un fichier spécifique ou le répertoire courant via HTTP.

## Installation

1. Téléchargez le script et enregistrez-le sous le nom `web.sh`.

2. Rendez le script exécutable :
    ```bash
    chmod +x web.sh
    ```

3. Déplacez le script dans un répertoire inclus dans votre `PATH` pour pouvoir l'exécuter comme une commande. Par exemple :
    ```bash
    mkdir -p ~/bin
    mv web.sh ~/bin/start_server
    ```

    Assurez-vous que `~/bin` est dans votre `PATH`. Ajoutez la ligne suivante à votre `~/.bashrc` ou `~/.profile` :
    ```bash
    export PATH="$HOME/bin:$PATH"
    ```

    Rechargez votre profil :
    ```bash
    source ~/.bashrc  # ou source ~/.profile
    ```

## Utilisation

Le script peut être utilisé pour démarrer un serveur web sur un port spécifié et servir un fichier spécifique ou le répertoire courant.

### Syntaxe

```bash
start_server [-p port] [-h] [file]
```

### Options

- `-p port` : Spécifie le port sur lequel démarrer le serveur web (par défaut : 8080).
- `-h` : Affiche l'aide et quitte le script.
- `[file]` : Fichier à servir (par défaut : répertoire courant).

### Exemples

- Démarrer le serveur sur le port par défaut (8080) et servir le répertoire courant :
    ```bash
    start_server
    ```

- Démarrer le serveur sur le port 8000 et servir le répertoire courant :
    ```bash
    start_server -p 8000
    ```

- Démarrer le serveur sur le port 8000 et servir un fichier spécifique :
    ```bash
    start_server -p 8000 index.html
    ```

- Afficher l'aide :
    ```bash
    start_server -h
    ```

## Prérequis

- Python 3 doit être installé sur votre système.

## Fonctionnement

1. Le script vérifie si Python 3 est installé. S'il ne l'est pas, il affiche un message d'erreur et quitte.
2. Le script analyse les options de la ligne de commande pour déterminer le port et le fichier à servir.
3. Si aucun fichier n'est spécifié, le répertoire courant est servi.
4. Si un fichier est spécifié, le serveur web est démarré et le fichier est ouvert dans le navigateur par défaut.
5. Le script affiche un message lorsque le serveur est arrêté.

## Auteurs

Ce script a été développé par Retr0LoveLace.


Ce README fournit des informations complètes sur l'installation, l'utilisation et le fonctionnement du script `web.sh`. Vous pouvez le personnaliser davantage selon vos besoins.
