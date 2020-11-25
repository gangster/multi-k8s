docker build -t deeden/multi-client:latest -t deeden/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t deeden/multi-server:latest -t deeden/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t deeden/multi-worker:latest -t deeden/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push deeden/multi-client:latest
docker push deeden/multi-server:latest
docker push deeden/multi-worker:latest
docker push deeden/multi-client:$GIT_SHA
docker push deeden/multi-server:$GIT_SHA
docker push deeden/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=deeden/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment server=deeden/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment server=deeden/multi-worker:$GIT_SHA