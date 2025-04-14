#!/usr/env/bin bash
set -Eeuo pipefail

user="$(whoami)"
if [[ "$user" != "root" ]]; then
	echo "Please run script with sudo"
	exit
fi

#models_dir="/media/kobespecial/Others/ollama/models"
models_dir="/media/sdb/big_storage/ollama/models"

ln -fs "$models_dir" /usr/share/ollama/.ollama/
sudo chown ollama:ollama "/usr/share/ollama/.ollama"
