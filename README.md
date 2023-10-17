# App Pet Cats

#### About

Applicação simples em Node.js e docker para uso em exemplos de projetos cloud.  

Um simples front-end para **Cat as a Service (CATAAS)**, uma API simples que fornece imagens de gatos. 

#### Setup in Linux
``` bash

# NODE.js
sudo apt-get update && sudo apt-get install -y ca-certificates curl gnupg
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
NODE_MAJOR=18
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt-get update && sudo apt-get install nodejs -y
sudo npm install -g npm@10.2.0

# APP
mkdir -p ~/app && cd ~/app
npm init
npm install --save express axios
```

#### Usage local
``` bash
cd ~/app
node index.js
```

#### Using Docker
``` bash
cd ~/app
# Dev
docker build --target development -t app-pet-cats-node:dev-release .
docker run -it --rm --name app-pet -p 3000:3000 -v .:/opt/app -w /opt/app app-pet-cats-node:dev-release sh
node index.js

# Prod
docker build --no-cache --target production -t erivando/app-pet-cats-node:latest .
docker run -it --rm -d --name app-pet-cat -p 80:3000 erivando/app-pet-cats-node:latest
docker exec -it app-pet-cat ls -la .
docker logs -f app-pet-cat
```

#### Image Docker
https://hub.docker.com/r/erivando/app-pet-cats-node