#!/bin/bash

gcloud compute instances create reddit-app \
    --project=infra-384407 \
    --zone=europe-west1-b \
    --machine-type=e2-micro \
    --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default \
    --maintenance-policy=MIGRATE \
    --provisioning-model=STANDARD \
    --service-account=594498866021-compute@developer.gserviceaccount.com \
    --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
    --tags=reddit-app \
    --create-disk=auto-delete=yes,boot=yes,device-name=reddit-app,image=projects/infra-384407/global/images/reddit-base-1682758412,mode=rw,size=20,type=projects/infra-384407/zones/europe-west1-b/diskTypes/pd-balanced \
    --no-shielded-secure-boot \
    --shielded-vtpm \
    --shielded-integrity-monitoring \
    --labels=ec-src=vm_add-gcloud \
    --reservation-affinity=any \
    --metadata-from-file startup-script=./reddit-app-deploy.sh

gcloud compute --project=infra-384407 firewall-rules create readdit-app --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:80,tcp:9292 --target-tags=reddit-app