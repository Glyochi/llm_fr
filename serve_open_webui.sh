echo "Stopping open-webui..."
docker stop open-webui
echo "Removing open-webui container..."
docker container rm open-webui
echo "Creating and starting open-webui container..."
docker run \
  -d \
  -e OLLAMA_API_BASE_URL=http://127.0.0.1:11434/api \
  --network=host \
  --gpus all \
  --name open-webui \
  --add-host=host.docker.internal:host-gateway \
  -v /home/gly/projects/ollama/persistent_storage/open_webui:/app/backend/data \
  --restart always ghcr.io/open-webui/open-webui:cuda
##  -p 3000:8080 \
