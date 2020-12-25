#!/bin/bash

docker build -t rajeevsiewnath/multi-client:latest -t rajeevsiewnath/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rajeevsiewnath/multi-server:latest -t rajeevsiewnath/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rajeevsiewnath/multi-worker:latest -t rajeevsiewnath/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rajeevsiewnath/multi-client:latest
docker push rajeevsiewnath/multi-server:latest
docker push rajeevsiewnath/multi-worker:latest
docker push rajeevsiewnath/multi-client:$SHA
docker push rajeevsiewnath/multi-server:$SHA
docker push rajeevsiewnath/multi-worker:$SHA

kubectl apply -f ./k8s

kubectl set image deployments/client-deployment client=rajeevsiewnath/multi-client:$SHA
kubectl set image deployments/server-deployment server=rajeevsiewnath/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=rajeevsiewnath/multi-worker:$SHA