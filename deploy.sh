docker build -t yestay90/multi-client:latest -t yestay90/multi-client:$SHA -f ./client/Dockerfile ./client
docker buuild -t yestay90/multi-server:latest -t yestay90/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t yestay90/multi-worker:latest -t yestay90/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push yestay90/multi-client:latest
docker push yestay90/multi-server:latest
docker push yestay90/multi-worker:latest

docker push yestay90/multi-client:$SHA
docker push yestay90/multi-server:$SHA
docker push yestay90/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=yestay90/multi-server:$SHA
kubectl set image deployments/client-deployment client=yestay90/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=yestay90/multi-worker:$SHA

