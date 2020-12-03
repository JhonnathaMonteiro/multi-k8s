docker build -t jhonnatha/multi-client:latest -t jhonnatha/multi-client:$SHA -f ./client/Dockerfile.dev ./client
docker build -t jhonnatha/multi-server:latest -t jhonnatha/multi-server:$SHA -f ./server/Dockerfile.dev ./server
docker build -t jhonnatha/multi-worker:latest -t jhonnatha/multi-worker:$SHA -f ./worker/Dockerfile.dev ./worker

docker push jhonnatha/multi-client:latest
docker push jhonnatha/multi-server:latest
docker push jhonnatha/multi-worker:latest

docker push jhonnatha/multi-client:$SHA
docker push jhonnatha/multi-server:$SHA
docker push jhonnatha/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jhonnatha/multi-server:$SHA
kubectl set image deployments/client-deployment client=jhonnatha/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jhonnatha/multi-worker:$SHA