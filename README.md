# pet-cats-node
Applicação simples em Node.js e docker para uso em exemplos de projetos cloud.

### Setup in Linux
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
