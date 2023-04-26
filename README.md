# frost_infra
integration whith travic-ci

###GCP

### 1. Bastion host
- we have two instance bastion with external ip and internal with internal network
- during first connection to bastion you have to add key "-A" in order to add your ssh key to shh agent and after we can that to internal host, but not convinien to do it every time 
	ssh -A <user>@bastion
- we can connect to internal host from our local machine in to ways:
	-- using single command:
		ssh -A <user>@<bastion_ip> -t ssh <user>@<internal_host_ip>
		ssh <user>@<internal_host_ip> -o "ProxyCommand ssh <user>@<bastion_ip> -W %h:%p"
	-- add configuration to .ssh/config and use only "ssh bastion" or "ssh internal":
		Host bastion
		    Hostname <bastion_ip>
		    IdentityFile ~/.ssh/id_rsa
		    User <user>
		Host internal
		    Hostname <internal_host_ip>
		    User <user>
		    ProxyCommand ssh -W %h:%p bastion
		    IdentityFile ~/.ssh/id_rsa
 
### 2. VPN connection

# Instalition:
Step 1: Add Pritunl and MongoDB repositories and public keys
Next, add Pritunl repository to your Ubuntu 20.04 using the below command.
echo "deb http://repo.pritunl.com/stable/apt $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/pritunl.list

Pritunl VPN is build from MongoDB. We will go ahead to also add Mongodb repository using the command below:

echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list

Now add public keys for MongoDB and Pritunl repositories.

curl -fsSL https://www.mongodb.org/static/pgp/server-5.0.asc|sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/mongodb-5.gpg

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7AE645C0CF8E292A

sudo apt update

Step 3: Install Pritunl and MongoDB
Install Pritunl and MongoDB on Ubuntu 20.04 with the below commands:

sudo apt --assume-yes install pritunl mongodb-org

Now start and enable Pritunl and MongoDB as below:

sudo systemctl start pritunl mongod
sudo systemctl enable pritunl mongod

https://computingforgeeks.com/install-and-configure-pritunl-vpn-server-on-ubuntu/