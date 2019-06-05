docker build -t weezyval/multi-client:latest -t weezyval/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t weezyval/multi-server:latest -t weezyval/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t weezyval/multi-worker:latest -t weezyval/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push weezyval/multi-client:latest
docker push weezyval/multi-server:latest
docker push weezyval/multi-worker:latest

docker push weezyval/multi-client:$SHA
docker push weezyval/multi-server:$SHA
docker push weezyval/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=weezyval/multi-server:$SHA
kubectl set image deployments/client-deployment client=weezyval/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=weezyval/multi-worker:$SHA