docker build -t balkanbgboy/multi-client:latest -t balkanbgboy/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t balkanbgboy/multi-server:latest -t balkanbgboy/multi-server:$SHA -f ./client/Dockerfile ./server
docker build -t balkanbgboy/multi-worker:latest -t balkanbgboy/multi-worker:$SHA -f ./client/Dockerfile ./worker

docker push balkanbgboy/multi-client:latest
docker push balkanbgboy/multi-server:latest
docker push balkanbgboy/multi-worker:latest

docker push balkanbgboy/multi-client:$SHA
docker push balkanbgboy/multi-server:$SHA
docker push balkanbgboy/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=balkanbgboy/multi-server:$SHA
kubectl set image deployment/client-deployment server=balkanbgboy/multi-client:$SHA
kubectl set image deployment/worker-deployment server=balkanbgboy/multi-worker:$SHA