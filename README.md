# Setup

1. Ollama running locally. 
- `ollama server`
- `ollama ls`
- `ollama run/pull ...`
- This will listen at port `11434`
- Ollama is managed by systemd (/etc/systemd/system/ollama.service). In the config you should configure these environment variables when running
    - OLLAMA_DEBUG=1
    - OLLAMA_HOST=0.0.0.0 (This is for the openWebUI later)

2. Models are stored on a samba server also locally. Need to check if the drives are mounted before actually running.
- `bash remount_drives.sh` 

3. OpenWebUI as UI interface (https://www.youtube.com/watch?v=Wjrdr0NU4Sk&ab_channel=NetworkChuck)
- Running inside a docker container
- This will listen at port `8080`
- Need to install nvidia docker toolkit
- `bash serve_open_webui.sh`
    - Expose to local network mode `network=host`
    - Define `-e OLLAMA_API_BASE_URL=http://127.0.0.1:11434/api`
    - Mount persistent storage to `/app/backend/data` so you dont lose your chat history 

4. ComfyUI and ComfyUI Manager for Image/Video generation
- `python3 main.py --listen=0.0.0.0`
- This will listen at port `8188`
- The diffusion models have to exist in `/models/checkpoint`
- Need to have a `workflow` to be able to generate anything.
- Integration with OpenWebUI requires importing that workflow, specified the json `key` for:
    - text prompt
    - width/height
    - seed/steps
    - model's name
- As well as OpenWebUI uses the right configurations for those keys (say wrong width height might lead to very bad looking images)

