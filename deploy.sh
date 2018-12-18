docker build -t aleks921/multi-client:latest -t aleks921/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aleks921/multi-server:latest -t aleks921/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aleks921/multi-worker:latest -t aleks921/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push aleks921/multi-client:latest
docker push aleks921/multi-server:latest
docker push aleks921/multi-worker:latest

docker push aleks921/multi-client:$SHA
docker push aleks921/multi-server:$SHA
docker push aleks921/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=aleks921/multi-server:$SHA
kubectl set image deployments/client-deployment client=aleks921/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=aleks921/multi-worker:$SHA
