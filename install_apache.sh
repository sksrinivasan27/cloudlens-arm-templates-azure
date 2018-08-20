#!/bin/bash
apt-get -y update

# install Apache2
apt-get -y install apache2 

# write some HTML
echo \<center\>\<h1\>My Demo App\</h1\>\<br/\>\</center\> > /var/www/html/demo.html

# restart Apache
apachectl restart

# install docker engine
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce -y

# Launch CloudLens container with static project key
sudo docker pull ixiacom/cloudlens-sandbox-agent
sudo docker run \
--name CloudLensEBC \
-v /:/host \
-v /var/run/docker.sock:/var/run/docker.sock \
-d --restart=always \
--net=host \
--privileged \
ixiacom/cloudlens-sandbox-agent:latest \
--server agent.ixia-sandbox.cloud \
--accept_eula y \
--apikey sHcgBg6StfR5pkbfJxXOv06zoiU0oMCMtjJkrbgIb \
--custom_tags CloudServiceProvider=Azure
