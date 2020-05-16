docker build -t san2sh87/multi-worker:latest -t san2sh87/multi-worker:$SHA  -f ./worker/Dockerfile ./worker
docker build -t san2sh87/multi-client:latest -t san2sh87/multi-client:$SHA  -f ./client/Dockerfile ./client 
docker build -t san2sh87/multi-server:latest -t san2sh87/multi-server:$SHA  -f ./server/Dockerfile ./server

docker push san2sh87/multi-client:latest  
docker push san2sh87/multi-worker:latest
docker push san2sh87/multi-server:latest 

docker push san2sh87/multi-client:$SHA
docker push san2sh87/multi-worker:$SHA
docker push san2sh87/multi-server:$SHA
kubectl apply -f k8s

kubectl set image deployments/server-deployment server=san2sh87/multi-server:$SHA 
kubectl set image deployments/client-deployment client=san2sh87/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=san2sh87/multi-worker:$SHA

