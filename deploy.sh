docker build -t gamelogist/multi-client:latest -t gamelogist/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t gamelogist/multi-server:latest -t gamelogist/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t gamelogist/multi-worker:latest -t gamelogist/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push gamelogist/multi-client:latest
docker push gamelogist/multi-server:latest
docker push gamelogist/multi-worker:latest

docker push gamelogist/multi-client:$SHA
docker push gamelogist/multi-server:$SHA
docker push gamelogist/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=gamelogist/multi-server:$SHA
kubectl set image deployments/client-deployment client=gamelogist/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=gamelogist/multi-worker:$SHA 

