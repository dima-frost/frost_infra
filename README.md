# frost_infra
integration whith travic-ci

# Test app deployment to GCP 

### Google Cloud CLI installation 

You can automate Google Cloud CLI installation using the install script.

For Linux and MacOS:

Save the install script locally instead of piping it to bash.

Enter the following at a command prompt:

curl https://sdk.cloud.google.com > install.sh
Run the script, passing arguments described as follows:

bash install.sh --disable-prompts

### Manual deployment

#### Create instance

gcloud compute instances create redit-app --project=infra-384407 --zone=europe-west1-b --machine-type=e2-micro --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default --maintenance-policy=MIGRATE --provisioning-model=STANDARD --service-account=594498866021-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --tags=puma-server,http-server --create-disk=auto-delete=yes,boot=yes,device-name=instance-1,image=projects/ubuntu-os-cloud/global/images/ubuntu-1804-bionic-v20230425,mode=rw,size=10,type=projects/infra-384407/zones/us-central1-a/diskTypes/pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=ec-src=vm_add-gcloud --reservation-affinity=any

#### Ruby instalition

sudo apt update
sudo apt install -y ruby-full ruby-bundler build-essential

Check:
ruby -v
bundler -v

#### Mongodb instalition

We will go ahead to also add Mongodb repository using the command below:

> echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list 

Now add public keys for MongoDB and Pritunl repositories.

> curl -fsSL https://www.mongodb.org/static/pgp/server-5.0.asc|sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/mongodb-5.gpg

> sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7AE645C0CF8E292A 

> sudo apt update 

Install  MongoDB with the below commands:

> sudo apt install  mongodb-org -y 

Now start and enable MongoDB as below:

> sudo systemctl start mongod 
> sudo systemctl enable mongod 

### App instalition

> git clone -b monolith https://github.com/express42/reddit.git

> cd reddit && bundle install

> puma -d

### Open http port

gcloud compute --project=infra-384407 firewall-rules create default-puma-server --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:80 --source-ranges=0.0.0.0/0 --target-tags=puma-server
