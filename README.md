# frost_infra
integration whith travic-ci

### Instance for self-hosted gitlab 
gcloud compute instances create gitlab-ci --project=docker-388412 --zone=europe-west3-b --machine-type=e2-medium --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default --maintenance-policy=MIGRATE --provisioning-model=STANDARD --service-account=327552343375-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --tags=gitlab-ci,http-server,https-server --create-disk=auto-delete=yes,boot=yes,device-name=gitlab-ci,image=projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20230605,mode=rw,size=50,type=projects/docker-388412/zones/europe-west3-b/diskTypes/pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=goog-ec-src=vm_add-gcloud --reservation-affinity=any

### Gitlab installation

https://about.gitlab.com/install/#ubuntu