docker build -t georgetatsis/multi-client:latest -t georgetatsis/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t georgetatsis/multi-server:latest -t georgetatsis/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t georgetatsis/multi-worker:latest -t georgetatsis/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push georgetatsis/multi-client:latest
docker push georgetatsis/multi-server:latest
docker push georgetatsis/multi-worker:latest

docker push georgetatsis/multi-client:$GIT_SHA
docker push georgetatsis/multi-server:$GIT_SHA
docker push georgetatsis/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=georgetatsis/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=georgetatsis/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=georgetatsis/multi-worker:$GIT_SHA